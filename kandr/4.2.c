#include <stdio.h>
#include <ctype.h>
#define MAXLINE 100

/* atof: convert string s to double */
double atof(char s[])
{
    double val, power;
    int i, sign;

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


    return sign * val / power;

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
