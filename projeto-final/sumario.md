# Motor de Xadrez Acelerado por Hardware em FPGA com Comunicação TCP/IP

Murilo Kenji Unten e Vitor Kenji Zoppo Yamada

14 de novembro de 2026. 

## 1. Visão Geral do Projeto

Este documento apresenta a especificação técnica de um sistema para execução de partidas de xadrez entre um usuário humano (peças brancas, operando em um computador) e a placa Altera DE2 (peças pretas, operando de forma autônoma).

O sistema combina Nios II, pilha de protocolos TCP/IP, Ethernet, interfaceamento com o display LCD 16x2 da placa e um acelerador de hardware dedicado em VHDL acoplado ao barramento Avalon para manipulação de bitboards, calcular quantidade de lances validos, validação de regras do xadrez e seleção aleatória de lances legais.

---

## 2. Objetivo e Interação entre Sistemas

### 2.1. Objetivo Geral
Desenvolver uma arquitetura hardware/software capaz de calcular quantidade de lances válidos e jogar uma partida completa de xadrez contra um jogador humano através de uma rede Ethernet, demonstrando a integração entre lógica reconfigurável em VHDL e comunicação via sockets TCP entre cliente e servidor.

### 2.2. Interação entre os Sistemas e Aplicações Externas
A solução opera sob arquitetura cliente-servidor sobre rede Ethernet, estabelecendo a comunicação entre a aplicação externa no computador hospedeiro e o sistema embarcado na FPGA:
1. **Cliente (Computador):** Aplicação externa, desenvolvida em linguagem Odin, responsável pela interação com o usuário (peças brancas), exibição do estado do tabuleiro, leitura dos comandos do jogador e envio do lance pretendido à placa DE2 através de um socket TCP.
2. **Servidor (Placa DE2):** Recebe os dados via Ethernet (DM9000A), submete os bitboards e o lance candidato ao acelerador em VHDL, atualiza o display LCD com o total de lances legais da posição e alertas (xeque, xeque-mate, afogamento ou lance inválido), seleciona um lance legal para as peças pretas e devolve a resposta ao cliente.

---

## 3. Descrição dos Módulos

### 3.1. Módulo Cliente
- **Gerenciamento de Sessão e Interface:** Apresenta o tabuleiro, recebe a entrada dos lances das peças branca, exibe as respostas das peças pretas, realiza o movimento das peças de acordo com os lances realizados.
- **Comunicação de Rede:** Estabelecer conexão TCP com o endereço IP da placa DE2, serializar os pacotes de estado/lance e aguardar de forma síncrona a resposta do servidor.

### 3.2. Módulo de Software e Sistema Operacional (Nios II / C / uC/OS-II)
- **Sistema Operacional e Pilha TCP/IP:** Executa sobre o kernel de tempo real uC/OS-II integrado à pilha de rede NicheStack, operando sobre o driver de camada física e enlace do controlador DM9000A.
- **Servidor de Sockets:** Implementado em linguagem C utilizando a API de sockets (`socket`, `bind`, `listen`, `accept`, `recv`, `send`), gerenciando o ciclo de turnos da partida.
- **Controlador de LCD:** Rotina em C que envia comandos e caracteres ao controlador do display LCD 16x2 da DE2 via Avalon, exibindo continuamente o número de lances válidos disponíveis na posição e mensagens de diagnóstico da partida.
- **Camada de Abstração de Hardware (HAL):** Realiza leitura e escrita nos registradores mapeados em memória (`IOWR_32DIRECT` / `IORD_32DIRECT`) do componente VHDL customizado.

### 3.3. Módulo de Hardware (VHDL)
Implementado como um periférico slave no barramento Avalon-MM, dividido nos seguintes submódulos:
- **Banco de Registradores Avalon-MM (32 bits):** Interface síncrona responsável por armazenar os *bitboards* de entrada (divididos em palavras de 32 bits alta e baixa), parâmetros de estado da partida e registradores de controle, além de expor os resultados de validação, contagem e lance escolhido.
- **Unidade de Geração de Máscaras e Regras do Xadrez:** Lógica dedicada que calcula ataques e movimentos pseudo-legais e legais para todas as peças (peões, cavalos, bispos, torres, damas e reis), verificando exposição do próprio rei ao xeque e contemplando integralmente:
  * **Roque** (menor e maior, verificando movimentação prévia de rei/torre e casas intermediárias sob ataque);
  * **Captura *en passant*** (baseada na casa alvo do duplo avanço anterior);
  * **Promoção de peão** (conversão para dama, torre, bispo ou cavalo);
  * **Detecção de condições de término e rejeição:** Xeque, Xeque-mate, Afogamento e sinalização de lance inválido submetido pelas brancas.
- **Contador e Seletor Pseudoaleatório (LFSR):** Contabiliza o número total de lances legais válidos na posição atual e utiliza um registrador de deslocamento com realimentação linear operando no clock do sistema para selecionar um índice válido dentre os lances possíveis das peças pretas.

---

## 4. Detalhes de Implementação

### 4.1. Representação do Tabuleiro por Bitboards
Cada configuração de peças é representada por um unsigned int 64 bits bitboard, onde o bit 0 corresponde à casa A1 e o bit 63 à casa H8. São utilizados 12 bitboards distintos (6 tipos de peças para as brancas e 6 para as pretas). Como o barramento Avalon-MM do Nios II opera com largura de 32 bits, cada bitboard de 64 bits é transferido por meio de um par de registradores 32 bits.

### 4.2. Mapa de Registradores do Hardware
O componente VHDL expõe 26 registradores de escrita e 3 registradores de leitura, todos com largura de 32 bits:

#### Registradores de Escrita (Nios II $\rightarrow$ Hardware VHDL)
| Endereço | Registrador | Largura | Descrição |
| :--- | :--- | :--- | :--- |
| `0x00` a `0x0B` | `BB_BRANCAS[0..11]` | 32 bits | 6 pares (`LOW`/`HIGH`) contendo os bitboards de peões, cavalos, bispos, torres, dama e rei das brancas. |
| `0x0C` a `0x17` | `BB_PRETAS[0..11]` | 32 bits | 6 pares (`LOW`/`HIGH`) contendo os bitboards de peões, cavalos, bispos, torres, dama e rei das pretas. |
| `0x18` | `REG_ESTADO_LANCE` | 32 bits | `[3:0]` Direitos de roque; `[9:4]` Casa alvo *en passant*; `[15:10]` Casa origem (brancas); `[21:16]` Casa destino (brancas); `[24:22]` Peça de promoção. |
| `0x19` | `REG_CONTROLE` | 32 bits | `[0]` `START` (inicia processamento); `[1]` `SOFT_RESET`; `[2]` `MODO` (`0`: validar lance branco; `1`: gerar/sortear lance preto). |

#### Registradores de Leitura (Hardware VHDL -> Nios II)
| Endereço | Registrador | Largura | Descrição |
| :--- | :--- | :--- | :--- |
| `0x1A` | `REG_STATUS` | 32 bits | `[0]` `DONE` (pronto); `[1]` `VALID`; `[2]` `CHECK`; `[3]` `CHECKMATE`; `[4]` `STALEMATE`. |
| `0x1B` | `REG_QTD_LANCES` | 32 bits | Quantidade de lances legais disponíveis na posição avaliada (exibida no display LCD). |
| `0x1C` | `REG_LANCE_ESCOLHIDO` | 32 bits | Lance selecionado para as pretas: `[5:0]` Origem; `[11:6]` Destino; `[14:12]` Peça promoção; `[17:15]` Tipo especial (normal, roque, *en passant*). |

### 4.3. Fluxo de Comunicação TCP/IP (Sockets)
1. O servidor Nios II inicializa a interface DM9000A, obtém o endereço IP e aguarda conexões em uma porta TCP.
2. O cliente conecta-se ao servidor e inicia a partida.
3. A cada jogada das brancas, o cliente envia um pacote contendo o lance executado (origem, destino e eventual promoção).
4. O Nios II carrega o estado atual e o lance candidato nos registradores do acelerador VHDL para validação:
   * **Se inválido:** O LCD exibe `INVALID` e o servidor retorna código de rejeição ao cliente, solicitando nova entrada sem alterar o turno.
   * **Se válido:** O tabuleiro interno é atualizado; se houver xeque-mate ou afogamento, o LCD exibe o alerta correspondente (`CHECKMATE` ou `STALEMATE`) e encerra a partida.
5. Estando a partida ativa, o Nios II aciona o acelerador em `MODO = 1` para calcular todos os lances legais das pretas, exibe a contagem (`REG_QTD_LANCES`) e eventuais alertas no LCD, aplica o lance sorteado (`REG_LANCE_ESCOLHIDO`) e transmite o pacote de resposta ao cliente.

### 4.4. Formatação do Display LCD (16x2)
O display LCD da DE2 fornece diagnóstico do processamento interno da FPGA:
- **Linha 1:** `VALID: XXX ` (onde `XXX` representa o valor de `REG_QTD_LANCES` na posição avaliada).
- **Linha 2:** Indicador de estado da partida (`REGULAR`, `CHECK `, `CHECKMATE`, `STALEMATE`, ou `INVALID`).

---

## 5. Atendimento aos Requisitos Mínimos

| Requisito Exigido | Solução Especificada no Projeto |
| :--- | :--- |
| **1) Interface operacional TCP/IP** | Pilha TCP/IP NicheStack executando sobre uC/OS-II no processador Nios II integrada ao controlador Ethernet DM9000A da placa DE2. |
| **2) Comunicação através de Sockets** | Servidor TCP implementado via API de Sockets em C (Nios II) comunicando-se com cliente TCP. |
| **3) Interfaceamento com periférico** | Controle do módulo **Display LCD 16x2** da placa DE2 para exibição dinâmica da contagem de lances válidos e alertas de estado do jogo. |
| **4) Hardware próprio ($\ge$ 2 reg. escrita e $\ge$ 2 reg. leitura de 32 bits)** | Acelerador de *bitboards* e regras de xadrez implementado em VHDL como periférico Avalon-MM contendo 26 registradores de escrita e 3 registradores de leitura de 32 bits. |
| **5) Comunicação entre plataforma e servidor/par** | Troca bidirecional de pacotes de estado e lances de xadrez entre o computador hospedeiro (cliente) e a DE2 (servidor). |