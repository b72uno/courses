/*
 * Write a function rightrot(x,n) that returns the value of the integer x
 * rotated to the right by n positions.
 */

#include <stdio.h>

unsigned rightrot(unsigned x, int n);

int main(int argc, const char *argv[])
{

    printf("Should be 948582538. \n");
    printf("%u\n", rightrot(1192314641,3));
    return 0;
}

unsigned rightrot(unsigned x, int n)
{
    // found this one on stack overflow, while looking what right shift means
    // and which way am I supposed to do the shift. I am lazy, yes.
    // At least I can try to understand what it does, because I know a
    // way to implement it differently, from the book Programming in C.
    // x << 32 - n will shift rightmost n bits to the very end of x
    // then rightshifting x by n will shift everything to the right by n
    // and because x is unsigned, 0s will be shifted in on the
    // left side. Where for signed it would be machine dependent.
    // And because there are 0s, we can OR it with our previous value
    // effectively setting the bits to what we wanted.
    // For left rotation we would just have to flip the signs
    return (x >> n) | (x << (sizeof(int) * 8 - n));

    // solution I found online, lets see what this one does
    // while n
    while (n > 0) {
        // if least significant digit of x is 1
        if ((x & 1) == 1)
            // rightshift x by 1 and or it with a value where 1 is the most
            // significant digit and the rest are 0s, OR that with our
            // righshifted x, effectively doing the same we did above - setting
            // msb to 1, just here we do it incrementally.
            x = (x >> 1) | ~(~0U >> 1);
        else
            // otherwise the lsd is 0 and as 0 is going to be shifted in anyway,
            // we can ignore it and rightshift the x
            x = (x >> 1);
        n--;
    }
    return x;

}




