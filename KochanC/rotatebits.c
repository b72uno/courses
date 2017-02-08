#include <stdio.h>

int main(int argc, const char *argv[])
{
    unsigned int w1 = 0xabcdef00u, w2 = 0xffff1122u;
    unsigned int rotate(unsigned int value, int n);

    printf("%x\n", rotate(w1, 8));
    printf("%x\n", rotate(w1, -16));
    printf("%x\n", rotate(w2, 4));
    printf("%x\n", rotate(w2, -22));
    printf("%x\n", rotate(w1, 0));
    printf("%x\n", rotate(w1, 44));

    return 0;
}


// function to rotate unsigned bits left or right
unsigned int rotate(unsigned int value, int n)
{
    unsigned int result, bits;

    // scale down the shift count to a defined range

    if (n > 0) 
        n = n % 32;
    else
        n = -(-n % 32);

    if (n == 0) // return as is

        result = value;

    else if (n > 0) { // left rotate

        // the n leftmost bits of value extracted
        // and shifted to the right
        bits = value >> (32 - n);
        // shift value n bits to the left
        // and OR the extracted bits back in
        result = value << n | bits;

    } else { // right rotate

        n = -n;
        bits = value << (32 - n);
        result = value >> n | bits;
    }

    return result;

}



