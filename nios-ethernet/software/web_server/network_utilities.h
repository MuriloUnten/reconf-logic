#ifndef __NETWORK_UTILITIES_H__
#define __NETWORK_UTILITIES_H__

#include <alt_iniche_dev.h>
#include "ipport.h"

int get_mac_addr(NET net, unsigned char mac_addr[6]);
int get_ip_addr(alt_iniche_dev *p_dev, ip_addr* ipaddr, ip_addr* netmask, ip_addr* gw, int* use_dhcp);

#endif