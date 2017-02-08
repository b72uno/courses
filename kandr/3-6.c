/*
 * Write a version of itoa that accepts instead three arguments of two. The third
 * argument is minimum field width; the converted number must be padded with
 * blanks on the left if necessary to make it wide enough.
 */

/* sounds like something you would do when scaling a bitmap. */

/* itoa : convert n to characters in s */
#include <stdio.h>
#include <string.h>
#include <limits.h>

void itoa(int n, char s[], int f)
{
    int i, j, d, k, sign;

    // MODIFIED
    sign = (n < 0) ? -1 : 1; /* record the sign */

    // count the digits, assuming base 10
    d = 0;
    k = n;
    while (k /= 10)
        ++d;

    i = 0;
    do {                       /* generate digits in reverse order */
        // MODIFIED
        s[i++] = (n % 10) * sign + '0'; /* get the next digit */
    } while (((n /= 10) * sign) > 0) ;    /* delete it */

    // append zeros
    for (j = (f - d); j > 0 ;j--)
        s[i++] = '0';

    if (sign < 0)
        s[i++] = '-';

    s[i] = '\0';



}

int main(void)
{
    char s[1000];
    int c, fw;

    /* printf("Enter your thing: "); */
    /* scanf("%i", &c); */

    c = INT_MIN;
    fw = 3;

    void itoa(int n, char s[], int f);
    void reverse(char s[]);

    itoa(c, s, fw);

    reverse(s);

    printf("%i is : %s\n", c, s);

    return 0;
}


void reverse(char s[])
{
    int i, j;

    for (i = 0, j = strlen(s) - 1; i < j; i++, j--)
    {
        s[i] ^= s[j];
        s[j] ^= s[i];
        s[i] ^= s[j];
    }
}


