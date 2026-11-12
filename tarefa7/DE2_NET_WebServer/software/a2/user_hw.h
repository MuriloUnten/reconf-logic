#ifndef __USER_HW_H__
#define __USER_HW_H__

/* Maximum string length accepted by the assignment (100 chars). The
 * User_HW Avalon slave exposes 128 one-byte registers (7-bit address),
 * which comfortably covers that limit.
 */
#define USER_HW_MAX_LEN 100

/* Writes 'len' bytes from 'in' into the User_HW register file, then reads
 * them back transformed: each byte is incremented by 1, except 0xF7 which
 * is mapped to 0x00 (done by the hardware itself, see ip/User_HW/User_HW.vhd).
 */
void user_hw_transform(const unsigned char *in, unsigned char *out, int len);

#endif /* __USER_HW_H__ */
