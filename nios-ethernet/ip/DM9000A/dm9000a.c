#include <stdio.h>
#include "dm9000a.h"
#include "dm9000a_regs.h"
#include "basic_io.h"
#include <ether.h>
#include "sys/alt_irq.h"

dm9000a_dev g_dm9ka;
int autoReset = 0;

#define DM9KA dm9000a_dev*

void dm9ka_stats(void * pio, int iface);
int dm9ka_init(int iface);
int dm9ka_pkt_send(PACKET pkt);
int dm9ka_close(int iface);

void dm9000a_iow(unsigned int reg, unsigned int data)
{
  IOWR(DM9000A_INST_BASE, IO_addr, reg);
  usleep(STD_DELAY);
  IOWR(DM9000A_INST_BASE, IO_data, data);
}

unsigned int dm9000a_ior(unsigned int reg)
{
  IOWR(DM9000A_INST_BASE, IO_addr, reg);
  usleep(STD_DELAY);
  return IORD(DM9000A_INST_BASE, IO_data);
}

void phy_write(unsigned int reg, unsigned int value)
{
  dm9000a_iow(0x0C, reg | 0x40);
  dm9000a_iow(0x0E, ((value >> 8) & 0xFF));
  dm9000a_iow(0x0D, value & 0xFF);
  dm9000a_iow(0x0B, 0x8);
  IOWR(DM9000A_INST_BASE, IO_data, 0x0A);
  usleep(STD_DELAY);
  IOWR(DM9000A_INST_BASE, IO_data, 0x08);
  usleep(50);
}

unsigned int dm9000a_reset(unsigned char *mac_address)
{
  unsigned int i;
  dm9000a_iow(0x1E, 0x01);
  dm9000a_iow(0x1F, 0x00);
  msleep(10);
  dm9000a_iow(NCR, 0x03);
  usleep(20);
  dm9000a_iow(NCR, 0x00);
  dm9000a_iow(NCR, 0x03);
  usleep(20);
  dm9000a_iow(NCR, 0x00);
  dm9000a_iow(ISR, 0x3F);
  dm9000a_iow(NSR, 0x2C);
  dm9000a_iow(0x1F, 0x01);
  dm9000a_iow(0x1F, 0x00);
  msleep(20);
  phy_write(0, PHY_reset);
  usleep(50);
  phy_write(16, 0x404);
  phy_write(4, PHY_txab);
  phy_write(0, 0x1200);
  msleep(20);
  for (i = 0; i < 6; i++)
    dm9000a_iow(16 + i, mac_address[i]);
  dm9000a_iow(ISR, 0x3F);
  dm9000a_iow(NSR, 0x2C);
  dm9000a_iow(NCR, NCR_set);
  dm9000a_iow(0x08, BPTR_set);
  dm9000a_iow(0x09, FCTR_set);
  dm9000a_iow(0x0A, RTFCR_set);
  dm9000a_iow(0x0F, 0x00);
  dm9000a_iow(ETXCSR, ETXCSR_set);
  dm9000a_iow(IMR, INTR_set);
  dm9000a_iow(RCR, RCR_set | RX_ENABLE | PASS_MULTICAST);
  return (dm9000a_ior(0x2D) == 0x80) ? DMFE_SUCCESS : DMFE_FAIL;
}

unsigned int TransmitPacket(unsigned char *data_ptr, unsigned int tx_len)
{
  unsigned int i;
  dm9000a_iow(IMR, PAR_set);
  dm9000a_iow(0xFD, (tx_len >> 8) & 0xFF);
  dm9000a_iow(0xFC, tx_len & 0xFF);
  IOWR(DM9000A_INST_BASE, IO_addr, MWCMD);
  for (i = 0; i < tx_len; i += 2) {
    usleep(STD_DELAY);
    IOWR(DM9000A_INST_BASE, IO_data, (data_ptr[i+1]<<8) | data_ptr[i]);
  }
  dm9000a_iow(TCR, TCR_set | TX_REQUEST);
  while(!(dm9000a_ior(NSR) & 0x0C)) {
    usleep(STD_DELAY);
  }
  dm9000a_iow(NSR, 0x00);
  dm9000a_iow(IMR, INTR_set);
  return DMFE_SUCCESS;
}

#ifndef MTU
#define MTU 1514
#endif

int prep_dm9000a(int index)
{
  DM9KA dm9ka = &g_dm9ka;
  NET ifp;
  printf("[DM9000A] prep_dm9000a called. Index: %d\n", index);
  ifp = nets[index];
  ifp->n_mib->ifAdminStatus = 2;
  ifp->n_mib->ifOperStatus = 2;
  ifp->n_mib->ifLastChange = cticks * (100/TPS);
  ifp->n_mib->ifPhysAddress = (u_char*)dm9ka->mac_addr;
  ifp->n_mib->ifDescr = (u_char*)"DM9000A series ethernet";
  ifp->n_lnh = ETHHDR_SIZE;
  ifp->n_hal = 6;
  ifp->n_mib->ifType = ETHERNET;
  ifp->n_mtu = MTU;
  ifp->n_init = dm9ka_init;
  ifp->pkt_send = dm9ka_pkt_send;
  ifp->n_close = dm9ka_close;
  ifp->n_stats = dm9ka_stats;

#ifdef IP_V6
  ifp->n_flags |= (NF_NBPROT | NF_IPV6);
#else
  ifp->n_flags |= NF_NBPROT;
#endif

  dm9ka->mac_addr[0] = 0x02;
  dm9ka->mac_addr[1] = 0x12;
  dm9ka->mac_addr[2] = 0x34;
  dm9ka->mac_addr[3] = 0x56;
  dm9ka->mac_addr[4] = 0x78;
  dm9ka->mac_addr[5] = 0x90;
  printf("[DM9000A] Hardcoded MAC applied: %02X:%02X:%02X:%02X:%02X:%02X\n", dm9ka->mac_addr[0], dm9ka->mac_addr[1], dm9ka->mac_addr[2], dm9ka->mac_addr[3], dm9ka->mac_addr[4], dm9ka->mac_addr[5]);

  dm9ka->netp = ifp;
  dm9ka->intnum = DM9000A_INST_IRQ;
  dm9ka->regbase = DM9000A_INST_BASE;
  dm9ka->sending = 0;
  dm9ka->rx_ints = 0;
  dm9ka->tx_ints = 0;
  dm9ka->rcv_len = 0;
  dm9ka->snd_len = 0;
  dm9ka->tosend.q_len = 0;
  dm9ka->tosend.q_max = 0;
  ifp->n_local = (void*)dm9ka;
  return ++index;
}

error_t dm9000a_init(alt_iniche_dev *p_dev)
{
  printf("[DM9000A] dm9000a_init() called by NicheStack.\n");
  prep_dm9000a(p_dev->if_num);
  return 0;
}

static unsigned char dm9000a_rxReady(DM9KA dm9ka)
{
  unsigned char rv = 0;
  rv = dm9000a_ior(MRCMDX);
  rv = IORD(dm9ka->regbase, IO_data) & 0x03;
  return rv;
}

static void dm9000a_isr(int iface)
{
  unsigned char rx_rdy, istatus;
  unsigned int tmp, rx_sts, i, rx_len;
  struct ethhdr * eth;
  PACKET pkt;
  DM9KA dm9ka = (DM9KA)nets[iface]->n_local;
  dm9000a_iow(IMR, PAR_set);
  istatus = dm9000a_ior(ISR);
  rx_rdy = dm9000a_rxReady(dm9ka);
  usleep(STD_DELAY);
  while(rx_rdy == DM9000_PKT_READY)
  {
    IOWR(dm9ka->regbase, IO_addr, MRCMD);
    usleep(STD_DELAY);
    rx_sts = IORD(dm9ka->regbase, IO_data);
    usleep(STD_DELAY);
    rx_len = IORD(dm9ka->regbase, IO_data);
    if( !(rx_sts & 0xBF00) && (rx_len < MAX_PACKET_SIZE) )
    {
      if ((pkt = pk_alloc(rx_len + ETHHDR_BIAS)) == NULL)
      {
        dm9ka->netp->n_mib->ifInDiscards++;
        for (i = 0; i < rx_len; i += 2) {
          usleep(STD_DELAY);
          tmp = IORD(dm9ka->regbase, IO_data);
        }
      }
      else
      {
        unsigned char* data_ptr = pkt->nb_buff + ETHHDR_BIAS;
        for (i = 0; i < rx_len; i += 2) {
          usleep(STD_DELAY);
          tmp = IORD(dm9ka->regbase, IO_data);
          *data_ptr++ = tmp & 0xFF;
          *data_ptr++ = (tmp>>8) & 0xFF;
        }
        pkt->nb_prot = pkt->nb_buff + ETHHDR_SIZE;
        pkt->nb_plen = rx_len - 14;
        pkt->nb_tstamp = cticks;
        pkt->net = dm9ka->netp;
        eth = (struct ethhdr *)(pkt->nb_buff + ETHHDR_BIAS);
        pkt->type = eth->e_type;
        putq(&rcvdq, pkt);
        SignalPktDemux();
      }
    } else {
      for (i = 0; i < rx_len; i += 2) {
        usleep(STD_DELAY);
        tmp = IORD(dm9ka->regbase, IO_data);
      }
      rx_len = 0;
    }
    usleep(STD_DELAY);
    rx_rdy = dm9000a_rxReady(dm9ka);
    usleep(STD_DELAY);
  }
  if (rx_rdy & 0x02)
  {
    printf("whoa ... got a strange thing here ... \n");
    autoReset++;
    dm9000a_iow(NCR, 0x03);
    usleep(20);
    dm9000a_iow(NCR, 0x00);
    dm9000a_iow(NCR, 0x03);
    usleep(20);
    dm9000a_iow(NCR, 0x00);
    dm9000a_iow(NCR, NCR_set);
    dm9000a_iow(0x08, BPTR_set);
    dm9000a_iow(0x09, FCTR_set);
    dm9000a_iow(0x0A, RTFCR_set);
    dm9000a_iow(0x0F, 0x00);
    dm9000a_iow(0x2D, 0x80);
    dm9000a_iow(ETXCSR, ETXCSR_set);
    dm9000a_iow(IMR, INTR_set);
    dm9000a_iow(RCR, RCR_set | RX_ENABLE | PASS_MULTICAST);
  }
  dm9000a_iow(ISR, 0x3F);
  dm9000a_iow(IMR, INTR_set);
}

int netisrs = 0;

#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
void dm9Ka_isr_wrap(void *context)
{
  netisrs++;
  dm9000a_isr((int)context);
}
#else
void dm9Ka_isr_wrap(void *context, u_long intnum)
{
  netisrs++;
  dm9000a_isr((int)context);
}
#endif

int dm9ka_init(int iface)
{
  int err;
  DM9KA dm9ka;
  printf("[DM9000A] dm9ka_init() called. Hardware reset starting...\n");
  dm9ka = (DM9KA)nets[iface]->n_local;
  err = dm9000a_reset(dm9ka->mac_addr);
  printf("[DM9000A] Hardware reset finished. Return code: %d\n", err);
  
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
  err = alt_ic_isr_register(0, dm9ka->intnum, (void*)dm9Ka_isr_wrap, (void *)iface, NULL);
#else
  err = alt_irq_register(dm9ka->intnum, (void *)iface, dm9Ka_isr_wrap);
#endif

  if (err) {
    printf("[DM9000A] FAILED to register IRQ! Error code: %d\n", err);
    return (err);
  }
  printf("[DM9000A] IRQ registered successfully.\n");

  nets[iface]->n_mib->ifAdminStatus = 1;
  nets[iface]->n_mib->ifOperStatus = 1;
  return (0);
}

int dm9ka_close(int iface)
{
  DM9KA dm9ka;
  printf("dm9ka_close\n");
  nets[iface]->n_mib->ifAdminStatus = 2;
  dm9ka = (DM9KA)nets[iface]->n_local;
  dm9000a_iow(NCR, 0x03);
  usleep(20);
  dm9000a_iow(NCR, 0x00);
  dm9000a_iow(NCR, 0x03);
  usleep(20);
  dm9000a_iow(NCR, 0x00);
  dm9000a_iow(IMR, 0x00);
  dm9000a_iow(RCR, 0x00);
  dm9000a_iow(0x0F, 0x00);
  nets[iface]->n_mib->ifOperStatus = 2;
  return 0;
}

void dm9ka_stats(void * pio, int iface)
{
  DM9KA dm9ka;
  printf("dm9ka_stats\n");
  dm9ka = (DM9KA)(nets[iface]->n_local);
  return;
}

extern void irq_Mask(void);
extern void irq_Unmask(void);

int dm9ka_pkt_send(PACKET pkt)
{
  unsigned int rv, slen;
  DM9KA dm9ka = (DM9KA)pkt->net->n_local;
  slen = pkt->nb_plen - ETHHDR_BIAS;
  if(slen < 64) slen = 64;
  rv = TransmitPacket(pkt->nb_prot + ETHHDR_BIAS, slen);
  if(rv == DMFE_SUCCESS) {
    dm9ka->netp->n_mib->ifOutOctets += (u_long)pkt->nb_plen;
    if(*pkt->nb_prot & 0x80)
      dm9ka->netp->n_mib->ifOutNUcastPkts++;
    else
      dm9ka->netp->n_mib->ifOutUcastPkts++;
  }
  if(pkt) pk_free(pkt);
  return (0);
}