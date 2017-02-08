#include <stdio.h>

#define IN 1 /* inside a word */
#define OUT 0 /* outside a word */ 

/* count lines, words, and characters in input */

int main(int argc, const char *argv[])
{
    int c, n1, nw, nc, state;

    state = OUT;
    // This is interesting, never seen initializing
    // stuff to 0 like this before 
    n1 = nw = nc =0;

    while ((c = getchar()) != EOF) {
        ++nc;
        if (c == '\n')
            ++n1;
        if (c == ' ' || c == '\n' || c == '\t')
        {
            state = OUT;
        }
        else if (state == OUT)
        {
            state = IN;
            ++nw;
        }
    }

    printf("%d %d %d\n", n1, nw, nc);


    return 0;
}

// Test input space, with empty file, a file with tabs new line chars
// and spaces between words

// to write a program that prints 1 word per line, just print an \n
// when second if statement from the program above evaluates to true
