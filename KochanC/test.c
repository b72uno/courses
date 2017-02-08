#include <stdio.h>


int main(int argc, const char *argv[])
{
    // leading 0 = octal base
    unsigned int w1 = 0525u, w2 = 0707u, w3 = 0122u;

    /* printf("%o ", w1 & w2); */
    /* printf("%o ", w1 & w1); */
    /* printf("%o ", w1 & w2 & w3); */
    /* printf("%o\n", w1 & 1); */

    printf("w1 = %o, w2 = %o, w3% = %o\n", w1, w2, w3);

    printf("\n");
    printf("All together now: \n");
    printf("w1&w2: %o\t w1|w2: %o\t w1^w2: %o\n", w1 & w2, w1 | w2, w1 ^ w2);

    printf("\n");
    printf("Complement away!: \n");
    printf("~w1: %o\t ~w2: %o\t ~w3: %o\n", ~w1, ~w2, ~w3);

    printf("\n");
    printf("Dat precedence!: \n");
    printf ("w1^w1: %o\t w2&~w2: %o\t w1|w2|w3: %o\n", w1 ^ w1, w1 & ~w2, w1 | w2 | w3);
    printf ("w1|w2&w3: %o\t w1|w2&~w3: %o\n", w1 | w2 & w3, w1 | w2 & ~w3);

    printf("\n");
    printf("DeMorgan's rule!: \n");
    printf ("w1|w2: %o\t w1&w2: %o\n", w1|w2, w1&w2);
    printf ("~(~w1&~w2): %o\t ~(~w1|~w2): %o\n", ~(~w1 & ~w2), ~(~w1 | ~w2));


    printf("\n");
    printf("Swapping values!: \n");
    w1 ^= w2;
    w2 ^= w1;
    w1 ^= w2;

    printf("w1 = %o, w2 = %o, w3% = %o\n", w1, w2, w3);

    return 0;
}
