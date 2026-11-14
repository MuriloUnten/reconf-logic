#ifndef __HTTP_SERVER_H__
#define __HTTP_SERVER_H__

/*
 * Minimal web server for the User_HW assignment.
 *
 * Two mandatory MicroC/OS-II tasks (threads):
 *   - RX_Task: accepts TCP connections on port 80 and receives the HTTP
 *     request (packet reception).
 *   - TX_Task: runs the string through User_HW and sends the HTTP response
 *     back to the PC client (packet transmission).
 *
 * They are decoupled by a MicroC/OS-II mailbox (HttpRequestMbox).
 */

#define HTTP_PORT              80

#define HTTP_RX_TASK_PRIORITY  8
#define HTTP_TX_TASK_PRIORITY  9

void RX_Task(void *pdata);
void TX_Task(void *pdata);

/* Creates the mailbox and starts RX_Task/TX_Task. Call once, after the
 * NicheStack TCP/IP stack is up (iniche_net_ready). */
void start_web_server_tasks(void);

#endif /* __HTTP_SERVER_H__ */
