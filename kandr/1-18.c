/**
 * Write a program to remove trailing blanks and tabs from each line of input
 * and to delete entirely blank lines.
 * I dont quite get that last line part. Blank lines wont be printed out, if
 * thats the case. len > 0 cond
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

        /* just print the line */
        if (len > 0) {
            max = len;
            copy(longest, line);


        printf("%s\n", longest);
                 
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
