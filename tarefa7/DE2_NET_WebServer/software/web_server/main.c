#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "includes.h"
#include "system.h"
#include "io.h"
#include "ipport.h"
#include "tcpport.h"
#include "net.h"
#include "socket.h"
#include "alt_iniche_dev.h"
#include "dm9000a.h"

extern void alt_iniche_init(void);

#define TASK_STACKSIZE 2048

OS_STK rx_task_stk[TASK_STACKSIZE];
OS_STK tx_task_stk[TASK_STACKSIZE];

OS_EVENT *req_sem;
int client_sock = -1;
char global_rx_buf[1024];
char extracted_str[128];
int extracted_len = 0;

void tx_task(void *pdata) {
    char http_res_header[] = "HTTP/1.1 200 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Length: ";
    char tx_buf[512];
    char res_str[128];
    int i;
    INT8U err;

    while(1) {
        OSSemPend(req_sem, 0, &err);

        if (client_sock != -1) {
            printf("[TX Task] Processing string in User_HW (length: %d)...\n", extracted_len);
            fflush(stdout);

            for (i = 0; i < extracted_len; i++) {
                IOWR_8DIRECT(USER_HW_0_BASE, i, extracted_str[i]);
            }

            for (i = 0; i < extracted_len; i++) {
                res_str[i] = IORD_8DIRECT(USER_HW_0_BASE, i);
            }
            res_str[extracted_len] = '\0';

            printf("[TX Task] String received from HW: \"%s\"\n", res_str);
            fflush(stdout);

            sprintf(tx_buf, "%s%d\r\n\r\n%s", http_res_header, extracted_len, res_str);
            send(client_sock, tx_buf, strlen(tx_buf), 0);

            close(client_sock);
            client_sock = -1;

            printf("[TX Task] Response sent to PC and socket closed.\n\n");
            fflush(stdout);
        }
    }
}

void rx_task(void *pdata) {
    int server_sock;
    struct sockaddr_in server_addr, client_addr;
    int addr_len = sizeof(client_addr);
    int rx_len;
    char *body_ptr;
    unsigned char *ip_bytes;
    NET ifp;

    printf("[RX Task] Waiting for IP acquisition via DHCP...\n");
    fflush(stdout);

    int seconds = 0;
    while (!iniche_net_ready) {
        OSTimeDlyHMSM(0, 0, 1, 0);
        seconds++;

        if (seconds <= 5 || seconds % 5 == 0) {
            printf("  [Debug] Elapsed: %ds | iniche_net_ready: %d\n", seconds, iniche_net_ready);
            fflush(stdout);
        }
    }

    ifp = nets[0];
    while (ifp->n_ipaddr == 0) {
        OSTimeDlyHMSM(0, 0, 1, 0);
    }

    ip_bytes = (unsigned char *)&ifp->n_ipaddr;

    printf("\n==================================================\n");
    printf("  DE2 BOARD CONNECTED TO NETWORK!\n");
    printf("  IP Address (DHCP): %d.%d.%d.%d\n", ip_bytes[0], ip_bytes[1], ip_bytes[2], ip_bytes[3]);
    printf("==================================================\n\n");
    fflush(stdout);

    server_sock = socket(AF_INET, SOCK_STREAM, 0);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(80);
    server_addr.sin_addr.s_addr = INADDR_ANY;

    bind(server_sock, (struct sockaddr *)&server_addr, sizeof(server_addr));
    listen(server_sock, 5);

    printf("[RX Task] Web Server active on port 80. Waiting for connections...\n\n");
    fflush(stdout);

    while(1) {
        client_sock = accept(server_sock, (struct sockaddr *)&client_addr, &addr_len);
        if (client_sock != -1) {
            rx_len = recv(client_sock, global_rx_buf, sizeof(global_rx_buf) - 1, 0);
            if (rx_len > 0) {
                global_rx_buf[rx_len] = '\0';

                body_ptr = strstr(global_rx_buf, "\r\n\r\n");
                if (body_ptr) {
                    body_ptr += 4;
                    extracted_len = strlen(body_ptr);

                    if (extracted_len > 100) {
                        extracted_len = 100;
                    }

                    strncpy(extracted_str, body_ptr, extracted_len);
                    extracted_str[extracted_len] = '\0';

                    printf("[RX Task] Packet received! String: \"%s\" (%d bytes)\n", extracted_str, extracted_len);
                    fflush(stdout);

                    OSSemPost(req_sem);
                } else {
                    close(client_sock);
                    client_sock = -1;
                }
            } else {
                close(client_sock);
                client_sock = -1;
            }
        }
    }
}

int main(void) {
    printf("\n--- Nios II / uC/OS-II System Started ---\n");
    fflush(stdout);

    DM9000A_INSTANCE( DM9000A_0, dm9000a_0 );
    DM9000A_INIT( DM9000A_0, dm9000a_0 );

    printf("[Main] Initializing NicheStack network stack...\n");
    fflush(stdout);

    alt_iniche_init();
    netmain();

    req_sem = OSSemCreate(0);

    OSTaskCreate(rx_task, NULL, (void *)&rx_task_stk[TASK_STACKSIZE - 1], 12);
    OSTaskCreate(tx_task, NULL, (void *)&tx_task_stk[TASK_STACKSIZE - 1], 13);

    printf("[Main] Starting uC/OS-II scheduler...\n");
    fflush(stdout);

    OSStart();

    return 0;
}
