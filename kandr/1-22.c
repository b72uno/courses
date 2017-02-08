/**
 * Write a program to "fold" long input lines into two or more shorter lines
 * after the last non-blank character that occurs before the n-th column of
 * input. Make sure your program does something very intelligent with very long
 * lines and if there are no blanks or tabs before the specified column
 **/

/**
 * A: A single blank would be preferable?! 
 * What is a blank? A tab, space or both??
 * Not sure what is "use the same tab stops as for detab"? Same amount or the
 * same way it was declared? I'll assume both.
 *
 **/


#include <stdio.h>
#define TABWIDTH 4

void fold(int foldwidth);

int main(int argc, const char *argv[])
{
    
    fold(10);
    return 0;
}

// There is nothing intelligent about this and long input lines, it simply 
// continues the text on a new line if foldwidth is reached. No consideration
// about where to break the text up whatsoever.

void fold(int foldwidth)
{
    int c, i, newline, nextcharwidth;

    i = 0, newline = 0; nextcharwidth = 1; // taking out the trash

    // get char
    while ((c = getchar()) != EOF && c != '\n')
    {
        if (c == '\t')
            nextcharwidth = 4;
        else
            nextcharwidth = 1;

        // if we hit the foldwidth
        if ((i + nextcharwidth) >= foldwidth)
        {
            newline = 1;
            putchar(c);
            putchar('\n');
            putchar('\r');

            // reset counter
            i = 0;
        } else { 

            // if we just got on new line
            if (newline)
            {
                // ignore prefixed spaces
                if (!(c == '\t' || c == ' '))
                {
                    putchar(c);
                    newline = 0;
                }
            } else {
                // just put in what we read
                putchar(c);
            }
        }
        
        // increment our position
        /* if we hit a tab, increment by tabwidth */
        if (c == '\t')
            i += TABWIDTH;
        else
            ++i; 
    }
        
}



