#include <stdio.h>
#include <string.h>

#define BEEF 0xbeef


// void itoa(int n, char s[])
// {
//     int i, sign;
//
//     if ((sign = n) < 0) /* record sign */
//         n = -n;         /* make n positive */
//
//     i = 0;
//
//     do {                       /* generate digits in reverse order */
//         s[i++] = n % 10 + '0'; /* get the next digit */
//     } while ((n /= 10) > 0);    /* delete it */
//
//     if (sign < 0)
//         s[i++] = '-';
//     s[i] = '\0';
//
//     reverse(s);
// }

/* In a two's complement number representation, our version of itoa does not
 * handle the largest negative number, that is, the value of n equal to
 * -(2^wordsize-1). Explain why not. Modify it to print that value correctly,
 *  regardless of the machine on which it runs.
 */

/* Because in two's complement system your cannot get positive of that number.
 * If wordsize is 8 we can display numbers from -128 to 127. -2^8-1 to (-2^8-1)+1
 * Why? Because thats a peculiarity of twos complement system. Complementing
 * 128 results in 10000000 -> 01111111 + 1 -> 10000000, you see.
 * I really know no correct way going * about this. Gonna check at stack overflow.
 *
 * Update 1:  Solution is pretty simple. We do this one bit at a time not
 * taking absolute value of the whole thing. While % behaviour AFAIK is not
 * machine dependent, it is programming language dependent.
 */


/* itoa : convert n to characters in s */
void itoa(int n, char s[])
{
    int i, sign;

    // MODIFIED
    sign = (n < 0) ? -1 : 1; /* record the sign */

    i = 0;

    do {                       /* generate digits in reverse order */
        // MODIFIED
        s[i++] = (n % 10) * sign + '0'; /* get the next digit */
    } while (((n /= 10) * sign) > 0) ;    /* delete it */

    if (sign < 0)
        s[i++] = '-';

    s[i] = '\0';

}

int main(void)
{
    char s[BEEF];
    int c;

    /* printf("Enter your thing: "); */
    /* scanf("%i", &c); */

    c = -2147483648;

    void itoa(int n, char s[]);
    void reverse(char s[]);

    itoa(c, s);
    reverse(s);

    printf("You enterde %s\n", s);


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



