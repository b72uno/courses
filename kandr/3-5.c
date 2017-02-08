/*
 * write a function itob(n, s, b) that converts the integer n into a base b
 * character repersentation in the string s. In particular itob(n, s, 16)
 * formats s as a hexadecimal integer in s
 */

/* For negative numbers it will do nothing but plug - before them */
/* Will support up to base 36 if you're not comfortable with whatever follows in
 * ascii table. Also no base 0 or 1, pretty please.
 */

#include <stdio.h>
#include <string.h>

#define STRSIZE 1000

int main(void)
{
    int c, base;
    char s[STRSIZE];

    void itob(int n, char s[], int base);

    itob(435, s, 36);
    printf("435 in base 36 is %s\n", s);

    itob(435, s, 16);
    printf("435 in hexadecimal is %s\n", s);

    itob(435, s, 10);
    printf("435 in decimal is %s\n", s);

    itob(435, s, 8);
    printf("435 in octal is %s\n", s);

    itob(435, s, 2);
    printf("435 in binary is %s\n", s);


    return 0;
}

void itob(int n, char s[], int base)
{

    int i, sign, c;
    i = 0;

    int abs(int n);
    void reverse(char s[]);

    sign = (n < 0) ? -1 : 1;

    do {
        c = (n % base) * sign;
        s[i++] = (c > 10) ? ((c - 10) + 'A') : c + '0';
    } while (abs(n /= base));

    if (sign < 0)
        s[i++] = '-';

    s[i] = '\0';

    reverse(s);
}

int abs(int n)
{
    return (n < 0) ? (n * -1) : n;
}

void reverse(char s[])
{
    int i,j;

    for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {

        s[i] ^= s[j];
        s[j] ^= s[i];
        s[i] ^= s[j];
    }
}

