#include <stdio.h>

/* count digits, white space chars and others */

int main(int argc, const char *argv[])
{
    int c, i, nwhite, nother;
    int ndigit[10];

    nwhite = nother = 0;

    // initializing array vals to 0 (occurences)
    for (i = 0; i < 10; i++) {
        ndigit[i] = 0;
    }

    while ((c = getchar()) != EOF) {
        if (c >= '0' && c <= '9') 
            // counting the occurence of digits
            // by indexing into each number, and incrementing 
            // I guess [] has higher precedence than ++
            ++ndigit[c-'0'];
        else if (c == ' ' || c =='\n' || c == '\t')
            ++nwhite;
        else
            ++nother;
    }

    printf("digits =");
    for (i = 0; i < 10; i++) 
        printf(" %d", ndigit[i]);

    printf(", white space = %d, other = %d\n", nwhite, nother);

    return 0;
}
