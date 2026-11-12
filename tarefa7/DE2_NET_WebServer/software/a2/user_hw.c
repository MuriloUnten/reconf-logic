#include "user_hw.h"
#include "io.h"
#include "../a2_bsp/system.h"

void user_hw_transform(const unsigned char *in, unsigned char *out, int len)
{
    int i;

    for (i = 0; i < len; i++) {
        IOWR_8DIRECT(USER_HW_0_BASE, i, in[i]);
    }
    for (i = 0; i < len; i++) {
        out[i] = IORD_8DIRECT(USER_HW_0_BASE, i);
    }
}
