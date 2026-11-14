PROJETO FINAL - LOGICA RECONFIGURÁVEL
Motor de Xadrez Acelerado por Hardware com TCP/IP

1. Visao Geral

Este projeto especifica um sistema para partidas de xadrez entre
um jogador humano (pecas brancas, executando cliente em computador) e a placa
Altera DE2 (pecas pretas, executando resposta pseudoaleatoria valida).

- Comunicacao de rede: Ethernet via controlador DM9000A, pilha TCP/IP
  NicheStack sobre uC/OS-II no softcore Nios II e comunicacao via Sockets TCP.
- Periferico embarcado: Display LCD 16x2 exibindo a quantidade de lances
  validos calculados na posicao atual (VALID: XXX) e indicadores de estado
  (REGULAR, CHECK, CHECKMATE, STALEMATE, INVALID).
- Hardware (VHDL): Periferico Avalon-MM com registradores para manipulacao de bitboards,
  validacao/geracao de todos os lances legais e sorteio via LFSR.

2. Estrutura dos diretórios:

/
|-- /hardware_vhdl/               )
|   |-- chess_accel_avalon.vhd    -> Interface Avalon-MM 
|   |-- bitboard_movegen.vhd      -> Logica de geracao
|   |                                de mascaras de ataque, lances legais,
|   |                                roque, en passant, promocao e xeque.
|   |-- lfsr_selector.vhd         -> Gerador pseudoaleatorio e contador
|   |-- de2_chess_top.vhd         -> Entidade Top-Level conectando Nios II,
|                                    DM9000A, SDRAM, LCD e User_HW.
|-- /quartus_project/             
|   |-- de2_chess.qpf             -> Arquivo de projeto do Quartus II.
|   |-- de2_chess.qsf             -> Atribuicao de pinos da DE2
|   |-- nios_system.qsys          -> Qsys (Nios II, SDRAM,
|                                    DM9000A, LCD e User Hardware).
|
|-- /software_nios2/              
|   |-- main.c                    -> Inicializacao do uC/OS-II e NicheStack.
|   |-- tcp_chess_server.c        -> Servidor TCP e maquina de
|   |                                estados dos turnos da partida.
|   |-- lcd_display.c / .h        -> Driver do LCD da DE2.
|   |-- chess_hw_driver.c / .h    -> Funcoes de leitura/escrita nos
|   |                                registradores via Avalon-MM.
|   |-- dm9000a/                  -> Driver Ethernet.
|
|-- /client/                      
    |-- main.odin                 -> Loop principal da partida e interface 
    |-- board.odin                -> Representacao local e formatacao de lances.
    |-- net_client.odin           -> Comunicacao TCP.

3. Instrucoes de Execucao
3-1.
- Placa Altera DE2 (Cyclone II EP2C35F672C6) com cabo Ethernet conectado.
- Altera Quartus II 13.0sp1.
- Nios II Software for Eclipse (incluso no Quartus).
- Compilador Odin no computador cliente.

3-2. Passos para Execucao
a. Abrir '/quartus_project/de2_chess.qpf' no Quartus II 13.0, compilar o
   projeto e gravar o arquivo '.sof' na placa DE2 via Programmer.
b. Abrir o Nios II SBT for Eclipse, importar os projetos '/software_nios2/' e
   o respectivo BSP, compilar e executar ('Run As -> Nios II Hardware').
c. Verificar no console JTAG UART o endereco IP e a porta TCP configurados na
   placa DE2.
d. No computador hospedeiro, navegar ate '/client/' e executar:
   odin run . -- <IP_DE2> <PORTA_TCP>
