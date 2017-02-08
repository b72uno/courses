#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, const char *argv[])
{
    /* char test[] = {"wutderpshoe"}; */
    /* int c = 5; */
    /* while (--c == 1 || --c == 3 || --c == 2) */
    /* { */
    /*     printf("%s\n", "iterating"); */
    /*     printf("C is %d\n", c); */
    /*     printf("EOF is %d\n", EOF); */
    /*     printf("Tabs are %d\n", sizeof('\t')); */
    /*     printf("Spaces are %d\n", sizeof(' ')); */
    /*     printf("Digraphs are very <: <% %> %: cool\n"); */
    /*     printf("Trigraphs are they worse ??= ??/ ??' ??! ??< ??> ??-\n"); */
    /*     printf("diAgraphs triAgraphs are not spelled that way, mkeii?! You stupid idiot!\n"); */
    /* } */

    /* printf("%i\n", sizeof(test)); */

    char s[] = "-25";
    char z[] = "22";

    printf("Can we do this or not???\n");
    printf("%s is equal to %f\n", s, atof(s));
    printf("%s is equal to %f\n", z, atof(z));
    printf("And the answer is %f\n", atof(s) + atof(z));

    return 0;
}
