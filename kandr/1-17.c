/* Write a program to print all input lines that are longer than 80 characters */
/* Prints immediately after you've written a line if its longer than 80 chars.
 * The upper limit of 100 chars program can output is still in effect */

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

        if (len > 80) {
            max = len;
            copy(longest, line);


    if (max > 80) /* there was a line longer than 80 */
        printf("%s\n", longest);
                 
}
}

/* getline : read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; i++) 
        s[i] = c;
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
