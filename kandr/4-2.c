/*
 * Extend atof to handle scientific notation of the form
 * 123.45e-6
 * where a floating-point number may be followed by e or E and an optionally
 * signed exponent
 */

#include <stdio.h>
#include <ctype.h>
#define MAXLINE 100

/* atof: convert string s to double */
double atof(char s[])
{
    double val, power, base, e;
    int i, sign, epower;

    for (i = 0; isspace(s[i]); i++) /* skip white space*/
        ;

    // if - then sign in negative
    sign = (s[i] == '-') ? -1 : 1;

    // skip the sign if there is one
    if (s[i] == '+' || s[i] == '-')
        i++;

    // get the integral part
    for (val = 0.0; isdigit(s[i]); i++)
        val = 10.0 * val + (s[i] - '0');

    // skip the comma
    if (s[i] == '.')
        i++;

    // get the fractional part
    for (power = 1.0; isdigit(s[i]); i++)
    {
        val = 10.0 * val + (s[i] - '0');
        power *= 10;
    }

    // skip e or E denoting exponent
    if (s[i] == 'e' || s[i] == 'E')
        i++;

    // set base depending on e
    base = (s[i] == '-') ? 0.1 : 10;

    // skip the esign if there is one
    if (s[i] == '+' || s[i] == '-')
        i++;

    // get the power for exponent
    for (epower = 0; isdigit(s[i]); i++)
    {
        epower = 10 * epower + (s[i] - '0');
    }

    // set e to base^epower
    for (e = 1.0; epower > 0; epower--)
    {
        e *=  base;
    }

    return (sign * (val / power)) * e;

}

int main(int argc, const char *argv[])
{
    char line[MAXLINE];

    double sum, atof(char []);
    int getline(char line[], int max);

    sum = 0;
    while (getline(line, MAXLINE) > 0)
        printf("\t%g\n", sum += atof(line));


    return 0;
}

int getline(char s[], int maxline)
{
    int c, i;

    for (i = 0; (c = getchar()) != EOF && c != '\n'; i++)
        s[i] = c;

    if (c == '\n')
        s[i++] = '\n';

    s[i] = '\0';

    return i;
}

