/**
 * Write a function reverse(s) that reverses the character string s. Use it to
 * write a program that reverses its input a line at a time
 * Still gonna use this as a base. Just gonna modify the print statement
 * and it should be all dandy.
 **/

#include <stdio.h>
#define MAXLINE 100 /* maximum input length */

int getline(char line[], int maxline);
void copy(char to[], char from[]);

/* print the longest input line */
int main(int argc, const char *argv[])
{
    int len; /* current line height */
    int max; /* maximum length seen so far */
    char line[MAXLINE]; /* current input line */
    char longest[MAXLINE]; /* longest line saved here */

    max = 0;
    while ((len = getline(line, MAXLINE)) > 0)

        if (len > 0) {
            max = len;
            copy(longest, line);

            /* so we start from first char not from \0 */
            /* I dont really see it though, might be an artifact from  */
            /* stripping whitespaces */
            --len;

            /* print it in reverse */
            while (len > 0)
            {
                --len;
                putchar(longest[len]);
            }

            printf("\n");

}
}

/* getline : read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; i++) 
        s[i] = c;

    // while last char before EOF or \n is whitespace, back up
    int pos = i - 1;
    while (s[pos] == ' ' || s[pos] == '\t' || s[pos] == '\v' || s[pos] == '\f' || s[pos] == '\r' || s[pos] == '\n')
        --pos;

    i = pos + 1;

    if (c == '\n')
    {
        s[i] = '\0';
        ++i;
    }
    
    s[i] = '\0';
    return i;
}

/* copy: copy 'from' into 'to' assume to is big enough */
void copy(char to[], char from[])
{
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0') {
        ++i;
    }
}
