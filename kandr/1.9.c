/* # Character arrays and what not */

#include <stdio.h>

/* pseudocode for program that reads a set of text lines and prints the longest */

/* while (there's another line) */
/*     if (its longer than previous) */
/*         (save it) */
/*         (save its length) */
/* print longest line */

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
        if (len > max) {
            max = len;
            copy(longest, line);
        }

    if (max > 0) /* there was a line */
        printf("%s", longest);

    return 0;
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
