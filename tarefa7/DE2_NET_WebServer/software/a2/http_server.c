#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "io.h"
#include <fcntl.h>

/* MicroC/OS-II definitions */
#include "../a2_bsp/HAL/inc/includes.h"
#include "../a2_bsp/system.h"

/* Nichestack definitions */
#include "../a2_bsp/iniche/src/h/nios2/ipport.h"
#include "../a2_bsp/iniche/src/h/tcpport.h"
#include "../a2_bsp/iniche/src/h/libport.h"
#include "../a2_bsp/iniche/src/nios2/osport.h"
#include "basic_io.h"

#include "alt_error_handler.h"
#include "http_server.h"
#include "user_hw.h"

#define HTTP_TASK_STACKSIZE   4096
#define HTTP_RECV_BUF_SIZE    2048
#define HTTP_RESP_BUF_SIZE    2048

typedef struct {
    int           fd;
    int           serve_page; /* 1 -> reply with the HTML page, ignore msg */
    int           len;        /* length of msg (0 when serve_page is set)  */
    unsigned char msg[USER_HW_MAX_LEN];
} http_request_t;

static OS_STK   RXTaskStk[HTTP_TASK_STACKSIZE];
static OS_STK   TXTaskStk[HTTP_TASK_STACKSIZE];
static OS_EVENT *HttpRequestMbox;

/* Local test/demo page: lets the board be exercised from a plain browser
 * even without the separate PC client. The assignment's own PC client may
 * instead point its fetch()/XHR calls straight at GET /?msg=... */
static const char HTML_PAGE[] =
"<!DOCTYPE html>\n"
"<html><head><meta charset=\"utf-8\"><title>User_HW Echo</title></head>\n"
"<body>\n"
"<h1>NIOS II User_HW Web Server</h1>\n"
"<p>Digite uma string (max 100 caracteres):</p>\n"
"<input id=\"msg\" maxlength=\"100\" size=\"50\">\n"
"<button onclick=\"sendMsg()\">Enviar</button>\n"
"<p>Resposta: <span id=\"out\"></span></p>\n"
"<script>\n"
"function sendMsg(){\n"
"  var m = document.getElementById('msg').value;\n"
"  fetch('/?msg=' + encodeURIComponent(m))\n"
"    .then(function(r){ return r.text(); })\n"
"    .then(function(t){ document.getElementById('out').textContent = t; });\n"
"}\n"
"</script>\n"
"</body></html>\n";

/* Decodes application/x-www-form-urlencoded text (+  -> space, %XX -> byte),
 * truncating the output to 'maxlen' bytes. Returns the number of bytes
 * written to 'dst'. */
static int url_decode(const char *src, int srclen, char *dst, int maxlen)
{
    int i = 0, j = 0;

    while (i < srclen && j < maxlen) {
        char c = src[i];

        if (c == '+') {
            dst[j++] = ' ';
            i++;
        } else if (c == '%' && i + 2 < srclen) {
            char hex[3];
            hex[0] = src[i + 1];
            hex[1] = src[i + 2];
            hex[2] = '\0';
            dst[j++] = (char)strtol(hex, NULL, 16);
            i += 3;
        } else {
            dst[j++] = c;
            i++;
        }
    }
    return j;
}

/* Bounded search for "key" inside buf[0..len). Returns a pointer right
 * after the key, or NULL if not found. */
static char *find_param(char *buf, int len, const char *key)
{
    int keylen = strlen(key);
    int i;

    for (i = 0; i + keylen <= len; i++) {
        if (memcmp(buf + i, key, keylen) == 0)
            return buf + i + keylen;
    }
    return NULL;
}

/* Parses a (not necessarily complete) HTTP request already sitting in buf.
 * Looks for a "msg" value either in the GET query string or in a POST body;
 * falls back to treating the whole POST body as the raw string. When none
 * of that is found, flags the request so TX_Task serves the demo page. */
static void parse_http_request(char *buf, int n, http_request_t *req)
{
    char *line_end;
    char *path_start;
    char *path_end;
    char *query;
    char *value;

    req->len = 0;
    req->serve_page = 0;

    line_end = strstr(buf, "\r\n");
    path_start = strchr(buf, ' ');

    if (line_end == NULL || path_start == NULL) {
        req->serve_page = 1;
        return;
    }
    path_start++; /* skip the space after GET/POST */

    path_end = strchr(path_start, ' ');
    if (path_end == NULL || path_end > line_end) {
        req->serve_page = 1;
        return;
    }

    query = memchr(path_start, '?', path_end - path_start);
    if (query != NULL) {
        query++; /* skip '?' */
        value = find_param(query, path_end - query, "msg=");
        if (value != NULL) {
            char *value_end = value;
            while (value_end < path_end && *value_end != '&')
                value_end++;
            req->len = url_decode(value, value_end - value, (char *)req->msg, USER_HW_MAX_LEN);
            return;
        }
    }

    {
        char *header_end = strstr(buf, "\r\n\r\n");
        if (header_end != NULL) {
            char *body = header_end + 4;
            int body_len = n - (int)(body - buf);

            if (body_len > 0) {
                value = find_param(body, body_len, "msg=");
                if (value != NULL) {
                    char *body_end = body + body_len;
                    char *value_end = value;
                    while (value_end < body_end && *value_end != '&')
                        value_end++;
                    req->len = url_decode(value, value_end - value, (char *)req->msg, USER_HW_MAX_LEN);
                } else {
                    req->len = url_decode(body, body_len, (char *)req->msg, USER_HW_MAX_LEN);
                }
                return;
            }
        }
    }

    req->serve_page = 1;
}

static int build_page_response(char *out, int outsize)
{
    int body_len = strlen(HTML_PAGE);
    int n = snprintf(out, outsize,
        "HTTP/1.1 200 OK\r\n"
        "Content-Type: text/html\r\n"
        "Access-Control-Allow-Origin: *\r\n"
        "Connection: close\r\n"
        "Content-Length: %d\r\n"
        "\r\n",
        body_len);

    if (n < 0 || n + body_len >= outsize)
        return 0;

    memcpy(out + n, HTML_PAGE, body_len);
    return n + body_len;
}

static int build_msg_response(char *out, int outsize, const unsigned char *body, int body_len)
{
    int n = snprintf(out, outsize,
        "HTTP/1.1 200 OK\r\n"
        "Content-Type: text/plain\r\n"
        "Access-Control-Allow-Origin: *\r\n"
        "Connection: close\r\n"
        "Content-Length: %d\r\n"
        "\r\n",
        body_len);

    if (n < 0 || n + body_len >= outsize)
        return 0;

    memcpy(out + n, body, body_len);
    return n + body_len;
}

/* RX_Task: owns the listening socket, accepts connections and receives the
 * HTTP request. Hands each parsed request to TX_Task via HttpRequestMbox. */
void RX_Task(void *pdata)
{
    int listen_fd, client_fd;
    struct sockaddr_in server_addr, client_addr;
    int addr_len;
    char buf[HTTP_RECV_BUF_SIZE];
    int n;

    while (!iniche_net_ready)
        TK_SLEEP(1);

    listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_fd < 0) {
        printf("[RX_Task] socket() failed\n");
        while (1) TK_SLEEP(100);
    }

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = 0; /* INADDR_ANY */
    server_addr.sin_port = htons(HTTP_PORT);

    if (bind(listen_fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        printf("[RX_Task] bind() failed\n");
        close(listen_fd);
        while (1) TK_SLEEP(100);
    }

    listen(listen_fd, 2);
    printf("[RX_Task] Web server listening on port %d\n", HTTP_PORT);

    while (1) {
        addr_len = sizeof(client_addr);
        client_fd = accept(listen_fd, (struct sockaddr *)&client_addr, &addr_len);
        if (client_fd < 0)
            continue;

        n = recv(client_fd, buf, sizeof(buf) - 1, 0);
        if (n <= 0) {
            close(client_fd);
            continue;
        }
        buf[n] = '\0';

        {
            http_request_t *req = (http_request_t *)malloc(sizeof(http_request_t));
            if (req == NULL) {
                close(client_fd);
                continue;
            }

            req->fd = client_fd;
            parse_http_request(buf, n, req);

            if (OSMboxPost(HttpRequestMbox, (void *)req) != OS_NO_ERR) {
                printf("[RX_Task] busy, dropping connection\n");
                close(client_fd);
                free(req);
            }
        }
    }
}

/* TX_Task: pulls one request at a time, runs the string through User_HW
 * (the hardware does the per-char +1 / 0xF7->0x00 transform) and sends the
 * HTTP response back, then closes the connection. */
void TX_Task(void *pdata)
{
    http_request_t *req;
    unsigned char transformed[USER_HW_MAX_LEN];
    char response[HTTP_RESP_BUF_SIZE];
    int resp_len;
    INT8U err;

    while (1) {
        req = (http_request_t *)OSMboxPend(HttpRequestMbox, 0, &err);
        if (req == NULL)
            continue;

        if (req->serve_page) {
            resp_len = build_page_response(response, sizeof(response));
        } else {
            user_hw_transform(req->msg, transformed, req->len);
            resp_len = build_msg_response(response, sizeof(response), transformed, req->len);
        }

        if (resp_len > 0)
            send(req->fd, response, resp_len, 0);

        close(req->fd);
        free(req);
    }
}

void start_web_server_tasks(void)
{
    INT8U error_code;

    HttpRequestMbox = OSMboxCreate(NULL);

    error_code = OSTaskCreateExt(RX_Task,
                             NULL,
                             (void *)&RXTaskStk[HTTP_TASK_STACKSIZE],
                             HTTP_RX_TASK_PRIORITY,
                             HTTP_RX_TASK_PRIORITY,
                             RXTaskStk,
                             HTTP_TASK_STACKSIZE,
                             NULL,
                             0);
    alt_uCOSIIErrorHandler(error_code, 0);

    error_code = OSTaskCreateExt(TX_Task,
                             NULL,
                             (void *)&TXTaskStk[HTTP_TASK_STACKSIZE],
                             HTTP_TX_TASK_PRIORITY,
                             HTTP_TX_TASK_PRIORITY,
                             TXTaskStk,
                             HTTP_TASK_STACKSIZE,
                             NULL,
                             0);
    alt_uCOSIIErrorHandler(error_code, 0);
}
