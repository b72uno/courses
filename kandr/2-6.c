/*
 * Write a function setbits(x, p, n, y) that returns x with the n bits that 
 * begin at position p set to the rightmost n bits of y leaving other
 * bits unchanged.
 */

/* for ease of coding, here's the previous getbits fn
 * getbits : get n bits from position p
 * unsigned getbits(unsigned x, int p, int n)
 * {
 *      return (x >> (p + 1 - n)) & ~(~0 << n);
 * }
 * x >> (p + 1 - n) moves the desired field to the right of the word.
 * What I dont get is, what that 1 is for. It seems to me that we are losing a
 * bit there. I know I am wrong, but I dont see how.
 * 8 bit int 00001101 we want 3(n) bits starting from 4th(p) bit. If we do
 * that, then 00001101 >> (4 + 1 - 3) == 00001101 >> 2 -> 00000011 
 * we lose one bit, you see. Are bits 0 indexed here????
 * ~(~0 << n) places zeros in the rightmost n bits
 * Mask? Lets say we got an 8 bit int. 00000000 -> 11111111 << 3 -> 11111000
 * ~ that and -> 00000111 Ok. But I dont get that -1 part.
 */

#include <stdio.h>

unsigned setbits(unsigned x, int p, int n, unsigned y);

int main(int argc, const char *argv[])
{


    printf("setbits(700, 6, 4, 0) should be 640 \n");
    printf("Result: %i\n", setbits(700, 6, 4, 0));
    printf("Following should be 349 \n");
    printf("Result: %i\n", setbits(341, 7, 4, 75));
    printf("Following should be 129 \n");
    printf("Result: %i\n", setbits(255, 7, 6, 0));
    printf("Following should be 1016 \n");
    printf("Result: %i\n", setbits(0, 10, 7, 127));
    printf("Following should be 250 \n");
    printf("Result: %i\n", setbits(138, 8, 4, 31));
    printf("Following should be 143 \n");
    printf("Result: %i\n", setbits(138, 4, 4, 31));
    return 0;
}

unsigned setbits(unsigned x, int p, int n, unsigned y)
{
    // if we shift them too far, we are losing bits, no rotation here
    /* return  x | (~(~0 << n) << (p - n)); // setting n bits at p pos to 1 */
    /* return (~y & ~(~0 << n)) << (p - n); // inverting y so I can ^ those bits with x */
    return (x | ~(~0 << n) << (p - n)) ^ (~y & ~(~0 << n)) << (p - n); // << has higher precedence so we're good 

    //          UPDATE: THIS SOLUTION IS WRONG AS CAKE
    // here's some solution I found online after having done mine. Not sure what
    // it does
    //          shifts in p 0s
    //          | them with ones shifted in 1 p + 1 - n positions
    //          & and them with x
    //          then it | them with 
    //          n y values shifted p + 1 - n bits.
    //          I still dont get it why do we need that + 1???? what the actual
    //
    /* return (x & ((~0 << (p + 1)) | (~(~0 << (p + 1 - n))))) | ((y & ~(~0 << n)) << (p + 1 - n)); */


}

