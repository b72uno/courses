#include <stdio.h>

int main(int argc, const char *argv[])
{
    // given that ~0 produces an int that contains all 1s
    unsigned short testsubject = ~0;
    int bitcount = 0;

    // returns the number of bits cotnained in an int on this machine
    while (testsubject & 1 != 0)
    {
        testsubject >>= 1;
        ++bitcount;
    }

    printf("Bits in int: %i\n", bitcount);

    return 0;
}


