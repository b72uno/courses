/* Revise the main routine of the longest-line program so it will correctl print  */
/* the length of arbitrary long input lines and as much as possible of the text */
/* The main routine? Not sure whether that is a limitation or not. Can I modify
 * the getline function or not?? */ 
/* Dynamic memory allocation hasnt yet been introduced, will have to check the */
/* solution for this one, cause besides just increasing limit of max line length */
/* I see no other way how to solve this. Spent good 30 mins thinking about it. */


#include <stdio.h>
#include <stdlib.h>
#define MAXLINE 100 /* maximum input length */

int getline(char line[], int maxline);
void copy(char to[], char from[]);

/* print the longest input line */
int main(int argc, const char *argv[])
{
    int len; /* current line height */
    int max; /* maximum length seen so far */
    char * line, longest;
    line = malloc(MAXLINE * sizeof(char)); /* current input line */
    longest = malloc(MAXLINE * sizeof(char)); /* current input line */

    max = 0;
    while ((len = getline(line, MAXLINE)) > 0)
    {
        if (len >= MAXLINE)
        {
            // realloc??
        }

        if (len > max) {
            max = len;
            copy(longest, line);
        }
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
