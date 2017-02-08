/*
 * Write a function invert(x, p, n), that returns x with the n bits that begin
 * at point p inverted, leaving the others unchanged. 
 * This problem is easy if we know how to do the last one.
 * We need to change only 2 things:
 * We use x instead of y to get the bits we need and we do not
 * invert them, so the targeted bits get inverted instead.
 *
 * UPDATE:  I've run into a corner case. When we invert bits starting from
 * the most significant digit on the left end, something somewhere goes wrong.
 * I dont know what or why. Should probably work it out by hand to understand.
 *
 * UPDATE 2: Figured it out. I was always getting rightmost n bits from
 * x, when I should have gotten the ones starting at position p!
 * Working things out by hand helped, but this one I should have figure out
 * without that.
 *
 * UPDATE 3: Found a solution online. It was broken. Fixed it. Now its shorter
 * and simpler than mine. Also made clear that xoring with ones at that position
 * will invert the bits. No need for all that bullshit I did with setting 
 * bits in x to ones, could have just shifted and xored. Thats about it.
 * Turns out this solution checking online, after getting mine to work, pays
 * off. I learned something.
 */


#include <stdio.h>

unsigned inverted(unsigned x, int p, int n);

int main(int argc, const char *argv[])
{

    printf("inverted(373, 5, 3) should be 361 \n");
    printf("Result: %i\n", inverted(373, 5, 3));
    printf("Following should be 160 \n");
    printf("Result: %i\n", inverted(175, 4, 4));
    printf("Following should be 805 \n");
    printf("Result: %i\n", inverted(853, 7, 3));

    printf("Following should be 47 \n");
    printf("Result: %i\n", inverted(215, 8, 5));
    printf("Following should be 125 \n");
    printf("Result: %i\n", inverted(141, 8, 4));

    printf("Following should be 149 \n");
    printf("Result: %i\n", inverted(341, 9, 3));

    printf("Following should be 217 \n");
    printf("Result: %i\n", inverted(289, 9, 6));

    printf("Yay!\n");
    return 0;
}

unsigned inverted(unsigned x, int p, int n)
{
    return (x | ~(~0 << n) << (p - n)) ^ (x >> (p - n) & ~(~0 << n)) << (p - n); 

    // Again online found this solution which doesnt seem to work at all. I dont
    // even ... hmm
    // get n 1s at the beginning and shift them at p position
    // then xor with x?? It will change every 0 at that position to 0
    // and every 1 will go to 0. Sounds like it should work.
    /* return x ^ (~(~0U << n) << p); */
    // There, I fixed it. Actually this is simpler and better than mine.
    // Mine now seems like something coded by 1000 monkeys. :D 
    // Should have started from scratch and not with the previous exercise.
    /* return x ^ (~(~0U << n) << (p - n)); */
}

