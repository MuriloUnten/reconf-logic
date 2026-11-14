#include <stdio.h>
#include <alt_types.h>
#include <alt_iniche_dev.h>
#include "ipport.h"
#include "tcpport.h"
#include "network_utilities.h"

int get_mac_addr(NET net, unsigned char mac_addr[6]) {
    mac_addr[0] = 0x00;
    mac_addr[1] = 0x07;
    mac_addr[2] = 0xED;
    mac_addr[3] = 0xFF;
    mac_addr[4] = 0xCD;
    mac_addr[5] = 0x15;
    return 0;
}

int get_ip_addr(alt_iniche_dev *p_dev, ip_addr* ipaddr, ip_addr* netmask, ip_addr* gw, int* use_dhcp) {
    *ipaddr  = htonl(0xC0A801EA);
    *netmask = htonl(0xFFFFFF00);
    *gw      = htonl(0xC0A80101);

#ifdef DHCP_CLIENT
    *use_dhcp = 1;
#else
    *use_dhcp = 0;
#endif

    return 1;
}