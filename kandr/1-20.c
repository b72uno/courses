/**
 * Write a program detab that replaces tabs in the
 * input with the proper number of blanks to space to the
 * next tab stop. Assume a fixed set of tab stops, say every
 * n columns. Should n be a variable or a symbolic parameter?
 **/

/**
 * Symbolic constant - #define STH, they are not variables, so
 * they do not appear in declarations. Conventionally are written in uppercase. 
 *
 * It should be variable. People tend to use tab stops with different width?
 **/

#include <stdio.h>
/* #define TABSTOPWIDTH 4  // symbolic constant */

void detab(int tabwidth);

int main(int argc, const char *argv[])
{
    
    // call detab with tabwidth 4
    detab(4);
    return 0;
}

void detab(int tabwidth)
{
    int c, i, j;

    i = 0;

    // get line
    while ((c = getchar()) != EOF && c != '\n')
    {
        // if we run into a tab
        if (c == '\t')
        {
            // insert appropriate amount of spaces depending on our position
            j = (tabwidth - (i % tabwidth));

            for (; j > 0; --j)
            {
                putchar(' ');
            }

        } else {
            // just put in what we read
            putchar(c);
        }

        // increment our position
            ++i;
    }
}

