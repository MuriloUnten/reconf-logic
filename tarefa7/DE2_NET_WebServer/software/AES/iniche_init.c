/******************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************                                                                             *
* Date - October 24, 2006                                                     *
* Module - iniche_init.c                                                      *
*                                                                             *                                                                             *
******************************************************************************/

/******************************************************************************
 * NicheStack TCP/IP stack initialization and Operating System Start in main()
 * for Simple Socket Server (SSS) example. 
 * 
 * This example demonstrates the use of MicroC/OS-II running on NIOS II.       
 * In addition it is to serve as a good starting point for designs using       
 * MicroC/OS-II and Altera NicheStack TCP/IP Stack - NIOS II Edition.                                                                                           
 *      
 * Please refer to the Altera NicheStack Tutorial documentation for details on 
 * this software example, as well as details on how to configure the NicheStack
 * TCP/IP networking stack and MicroC/OS-II Real-Time Operating System.  
 */
  
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "io.h"
#include <fcntl.h>
/* MicroC/OS-II definitions */
#include "../AES_bsp/HAL/inc/includes.h"

#include "../AES_bsp/system.h"

#include "dm9000a.h"

/* Simple Socket Server definitions */
#include "simple_socket_server.h"
#include "alt_error_handler.h"

/* Nichestack definitions */
#include "../AES_bsp/iniche/src/h/nios2/ipport.h"
#include "../AES_bsp/iniche/src/h/tcpport.h"
#include "../AES_bsp/iniche/src/h/libport.h"
#include "../AES_bsp/iniche/src/nios2/osport.h"
#include "basic_io.h"
#include "LCD.h"

#define BUFFER_SIZE 1048576

/* Definition of task stack for the initial task which will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example tasks. 
 */
OS_STK    SSSInitialTaskStk[TASK_STACKSIZE];

/* Declarations for creating a task with TK_NEWTASK.  
 * All tasks which use NicheStack (those that use sockets) must be created this way.
 * TK_OBJECT macro creates the static task object used by NicheStack during operation.
 * TK_ENTRY macro corresponds to the entry point, or defined function name, of the task.
 * inet_taskinfo is the structure used by TK_NEWTASK to create the task.
 */
TK_OBJECT(to_ssstask);
TK_ENTRY(SSSSimpleSocketServerTask);

struct inet_taskinfo ssstask = {
      &to_ssstask,
      "simple socket server",
      SSSSimpleSocketServerTask,
      4,
      APP_STACK_SIZE,
};

/* SSSInitialTask will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example 
 * RTOS structures and tasks. 
 */
void SSSInitialTask(void *task_data)
{
	printf("\n\nOK: projeto carregado!\n\n\n");
	INT8U error_code;

	/*
	* Initialize Altera NicheStack TCP/IP Stack - Nios II Edition specific code.
	* NicheStack is initialized from a task, so that RTOS will have started, and
	* I/O drivers are available.  Two tasks are created:
	*    "Inet main"  task with priority 2
	*    "clock tick" task with priority 3
	*/
	alt_iniche_init();
	netmain();

	/* Wait for the network stack to be ready before proceeding.
	* iniche_net_ready indicates that TCP/IP stack is ready, and IP address is obtained.
	*/
	while (!iniche_net_ready)
		TK_SLEEP(1);

	/* Now that the stack is running, perform the application initialization steps */

	/* Application Specific Task Launching Code Block Begin */

	printf("\nSimple Socket Server starting up\n");

	// Código começa aqui -----------------------------------------------------------------------
	int SocketFD;
	struct sockaddr_in sa;
	char file[BUFFER_SIZE];
	char buffer[2000];
	char send_buffer[BUFFER_SIZE];
	unsigned int plaintext[4];
	unsigned int enc_key[4];
	unsigned int dec_key[4];
	unsigned int cyphertext[4];
	unsigned int file_size;
	unsigned int received_bytes = 0;

	SocketFD = socket(AF_INET, SOCK_STREAM, 6);
	printf("Socket criado.\n");
	sa.sin_family = AF_INET;
	sa.sin_port = htons(1234);
	sa.sin_addr.s_addr = inet_addr("10.181.28.30"); // <-- ALTERAR O IP AQUI
	if (connect(SocketFD, (struct sockaddr *)&sa, sizeof sa) == -1) {
		perror("Connection failed.\n");
		printf("%s\n", strerror(errno));
		close(SocketFD);
		exit(EXIT_FAILURE);
	}

	msleep(1000);
	char msg[12]= "Placa online";
	if (send(SocketFD, msg, sizeof(msg), 0) < 0){
		perror("Send()");
		exit(EXIT_FAILURE);
	} else{
		printf("Msg enviada: Placa online\n");
	}


	while (1){

		  int i;

		  for (i = 0; i < 17; i++) {
			 buffer[i] = 0;
		  }

		  if(recv(SocketFD, buffer, 17, 0) < 0){
			  perror("Receive error!\n");
			  exit(EXIT_FAILURE);
		  }

		  if (buffer[0] == 'f'){

			  file_size = ((unsigned char)buffer[4] << 24) |
						 ((unsigned char)buffer[3] << 16) |
						 ((unsigned char)buffer[2] << 8)  |
						 ((unsigned char)buffer[1]);

			  char msg[16] = "x gravado!";

			   if(send(SocketFD, msg, sizeof(msg), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

			   msleep(100);

			   while(received_bytes < file_size){
				   unsigned int bytes_received = recv(SocketFD, file + received_bytes,
						   	   	   	   	   	   	   	   file_size - received_bytes, 0);
				   if(bytes_received < 0){
					   perror("Receive error!\n");
					   exit(EXIT_FAILURE);
				   }
				   received_bytes += bytes_received;
			   }

			   received_bytes = 0;


			   char msg2[16] = "Arquivo gravado!";

			   if(send(SocketFD, msg2, sizeof(msg2), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

		  }

		  else if (buffer[0] == 'a'){

			  int i;

			  for(i = 0 ; i < 4 ; i ++){
				  plaintext[i] = ((unsigned char)buffer[1+i*4] << 24) |
								 ((unsigned char)buffer[2+i*4] << 16) |
								 ((unsigned char)buffer[3+i*4] << 8)  |
								 ((unsigned char)buffer[4+i*4]);
			  }

			  //Write input text
			  for(i = 0 ; i < 4 ; i++){
				  IOWR(ENC_0_BASE, 4*i, plaintext[4-1-i]);
			  }

				//Write key
			   for(i = 0 ; i < 4 ; i++){
				   IOWR(ENC_0_BASE, 4*i + 16, enc_key[4-1-i]);
			   }

				//Write at start reg
			   IOWR(ENC_0_BASE, 60, 1);

			   while(IORD(ENC_0_BASE, 48) != 1){
			   }

			   for(i = 0 ; i < 4 ; i++){
				   cyphertext[i] = IORD(ENC_0_BASE, 4*i + 32);
			   }


			   if(send(SocketFD, (char*)cyphertext, sizeof(cyphertext), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

			   msleep(100);
		  }

		  else if (buffer[0] == 'e'){

			  int i, j;

			  for(j = 0 ; j < file_size ; j = j + 16){


				  for(i = 0 ; i < 4 ; i ++){
					  plaintext[i] = ((unsigned char)file[0+i*4 + j] << 24) |
									 ((unsigned char)file[1+i*4 + j] << 16) |
									 ((unsigned char)file[2+i*4 + j] << 8)  |
									 ((unsigned char)file[3+i*4 + j]);
				  }


				  //Write input text
				  for(i = 0 ; i < 4 ; i++){
					  IOWR(ENC_0_BASE, 4*i, plaintext[4-1-i]);
				  }

					//Write key
				   for(i = 0 ; i < 4 ; i++){
					   IOWR(ENC_0_BASE, 4*i + 16, enc_key[4-1-i]);
				   }

					//Write at start reg
				   IOWR(ENC_0_BASE, 60, 1);

				   while(IORD(ENC_0_BASE, 48) != 1){
				   }

				   for(i = 0 ; i < 4 ; i++){
					   cyphertext[i] = IORD(ENC_0_BASE, 4*i + 32);
					   unsigned int intValue = (unsigned int)cyphertext[i];
					   int k;
					   for (k = 0 ; k < 4 ; k++){
						   send_buffer[j + 4*(3-i) + k] = (unsigned char)(intValue >> (8 * (3-k)));
					   }
				   }
			  }

			   if(send(SocketFD, send_buffer, file_size, 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

		  }
		  else if (buffer[0] == 'd'){

			  int i, j;

			  for(j = 0 ; j < file_size ; j = j + 16){


				  for(i = 0 ; i < 4 ; i ++){
					  cyphertext[i] = ((unsigned char)file[0+i*4 + j] << 24) |
									 ((unsigned char)file[1+i*4 + j] << 16) |
									 ((unsigned char)file[2+i*4 + j] << 8)  |
									 ((unsigned char)file[3+i*4 + j]);
				  }


				  //Write input text
				  for(i = 0 ; i < 4 ; i++){
					  IOWR(DEC_0_BASE, 4*i, cyphertext[4-1-i]);
				  }

					//Write key
				   for(i = 0 ; i < 4 ; i++){
					   IOWR(DEC_0_BASE, 4*i + 16, dec_key[4-1-i]);
				   }

					//Write at start reg
				   IOWR(DEC_0_BASE, 60, 1);

				   while(IORD(DEC_0_BASE, 48) != 1){
				   }

				   for(i = 0 ; i < 4 ; i++){
					   plaintext[i] = IORD(DEC_0_BASE, 4*i + 32);
					   unsigned int intValue = (unsigned int)plaintext[i];
					   int k;
					   for (k = 0 ; k < 4 ; k++){
						   send_buffer[j + 4*(3-i) + k] = (unsigned char)(intValue >> (8 * (3-k)));
					   }
				   }
			  }


			   if(send(SocketFD, send_buffer, file_size, 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

		  }
		  else if(buffer[0] == 'b'){

			  int i;

			  for(i = 0 ; i < 4 ; i ++){
				  cyphertext[i] = ((unsigned char)buffer[1+i*4] << 24) |
								 ((unsigned char)buffer[2+i*4] << 16) |
								 ((unsigned char)buffer[3+i*4] << 8)  |
								 ((unsigned char)buffer[4+i*4]);
			  }

			  int j;

			  //Write input text
			  for(i = 0 ; i < 4 ; i++){
				  IOWR(DEC_0_BASE, 4*i, cyphertext[4-1-i]);
			  }

				//Write key
			   for(i = 0 ; i < 4 ; i++){
				   IOWR(DEC_0_BASE, 4*i + 16, dec_key[4-1-i]);
			   }

				//Write at start reg
			   IOWR(DEC_0_BASE, 60, 1);

			   while(IORD(DEC_0_BASE, 48) != 1){
			   }

			   for(i = 0 ; i < 4 ; i++){
					plaintext[i] = IORD(DEC_0_BASE, 4*i + 32);
			   }

			   if(send(SocketFD, (char*)plaintext, sizeof(plaintext), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }


		  }
		  else if(buffer[0] == 'k'){

			  int i;

			  for(i = 0 ; i < 4 ; i ++){
				  enc_key[i]       = ((unsigned char)buffer[1+i*4] << 24) |
								 ((unsigned char)buffer[2+i*4] << 16) |
								 ((unsigned char)buffer[3+i*4] << 8)  |
								 ((unsigned char)buffer[4+i*4]);
			  }


			  char msg[17] = "Chave armazenada!";

			   if(send(SocketFD, msg, sizeof(msg), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

			   msleep(10);
		  }
		  else if(buffer[0] == 'q'){

			  int i;


			  for(i = 0 ; i < 4 ; i ++){
				  enc_key[i]       = ((unsigned char)buffer[1+i*4] << 24) |
								 ((unsigned char)buffer[2+i*4] << 16) |
								 ((unsigned char)buffer[3+i*4] << 8)  |
								 ((unsigned char)buffer[4+i*4]);
			  }

			  for(i = 0 ; i < 4 ; i++){
				  IOWR(KEY_0_BASE, 4*i, enc_key[4-1-i]);
			  }

			  IOWR(KEY_0_BASE, 60, 1);

			  while(IORD(KEY_0_BASE, 48) != 1){
			  }

			  for(i = 0 ; i < 4 ; i++){
				  dec_key[4-i-1] = IORD(KEY_0_BASE, 4*i + 32);
			  }

			  char msg[17] = "Chave armazenada!";

			   if(send(SocketFD, msg, sizeof(msg), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

		  }
		  else{

			  char msg[16] = "Comando invalido";

			   if(send(SocketFD, msg, sizeof(msg), 0) < 0){
				   perror("Send error!\n");
				   exit(EXIT_FAILURE);
			   }

		  }
	}
}

/* Main creates a single task, SSSInitialTask, and starts task scheduler.
 */

int main (int argc, char* argv[], char* envp[])
{
  
  INT8U error_code;

  DM9000A_INSTANCE( DM9000A_0, dm9000a_0 );
  DM9000A_INIT( DM9000A_0, dm9000a_0 );

  /* Clear the RTOS timer */
  OSTimeSet(0);

  /* SSSInitialTask will initialize the NicheStack
   * TCP/IP Stack and then initialize the rest of the Simple Socket Server example
   * RTOS structures and tasks.
   */
  error_code = OSTaskCreateExt(SSSInitialTask,
                             NULL,
                             (void *)&SSSInitialTaskStk[TASK_STACKSIZE],
                             SSS_INITIAL_TASK_PRIORITY,
                             SSS_INITIAL_TASK_PRIORITY,
                             SSSInitialTaskStk,
                             TASK_STACKSIZE,
                             NULL,
                             0);
  alt_uCOSIIErrorHandler(error_code, 0);

  /*
   * As with all MicroC/OS-II designs, once the initial thread(s) and
   * associated RTOS resources are declared, we start the RTOS. That's it!
   */
  OSStart();
  
  while(1); /* Correct Program Flow never gets here. */

  return -1;
}
