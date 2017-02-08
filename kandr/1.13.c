#include <stdio.h>

#define MAXWORDLENGTH 50
/* Print a histogram of the lengths of words in its input */

int main(int argc, const char *argv[])
{

    int c, i, wlen, wordends;
    wlen = wordends = 0;

    int wordlengths[MAXWORDLENGTH];

    // initializing lengths array
    for (i = 0; i < MAXWORDLENGTH; i++) {
        wordlengths[i] = 0;
    }


    // while not at the end of file
    while ((c = getchar()) != EOF)
    {
        // if word ends, dont count 
        if (c == ' ' || c == '\t' || c == '\n')
        {
            wordends = 1;
            if (wlen)
                ++wordlengths[wlen+1];
            wlen = 0;

        } else 
        { /* continue counting chars */
            ++wlen;
        }

    }

    i = 0;
    // print the bloody histogram
    for (i = 1; i < MAXWORDLENGTH; i++) {
        for(int j = wordlengths[i]; j > 0; --j)
            printf("#");
        if (wordlengths[i])
        {
            printf("%5d\n", i);
            printf("\n");
        }
    }
}

// More challenging version is a vertical orientation
// You would have to create a loop which loops for as many times as the
// highest value in wordlengths array. Check whether each occurence entry
// is less than i, if so, print a space, otherwise print whatever you use
// to stack your histogram bar. Decrement i.

// 1.14 - write a program to print a histogram of the frequencies of different
// characters in its input. Same stuff as here, just create
// an array of ASCII table and then index into it, increment occurences,
// print out character frequencies that are occuring > 0;
// Same thing as above if we wanted a vertical orientation of histogram.
