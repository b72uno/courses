/*
 * Write a loop equivalent to the for loop above:
 * for (i = 0; i < lim - 1 && (c = getchar()) != '\n' && c != EOF; ++i)
 * without using && or ||
 */

#include <stdio.h>

int main(void)
{
    int i;
    int c;
    int lim = 10;

    //doesnt really work
    /* for (i = 0; i < lim - 1, c = getchar(), c != '\n', c != EOF; ++i) */
    /*     printf("%d\n", i); */

    // equivalent
    for (i = 0; i < lim - 1, c = getchar(); ++i)
    {
        if (c == '\n')
            break;
        if (c == EOF)
            break;
        printf("%d\n", i);
    }

    for (i = 0; i < lim - 1 && (c = getchar()) != '\n' && c != EOF; ++i)
        printf("%d\n", i);

    return 0;
}
