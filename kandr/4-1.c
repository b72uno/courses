/*
 * Write the function strindex(s, t), which returns the position of the
 * rightmost occurence of t in s, or -1 if there is none.
 */

#include <stdio.h>
#include <string.h>

/* strindex : return index of rightmost t in s, -1 if none */
int strindexlm(char s[], char t[])
{
    int i, j, k;

    for (i = strlen(s) - 1; i > 0 ; i--)
    {
        for (j = i, k = 0; t[k] != '\0' && s[j] == t[k]; j++, k++)
            ;
        if (k > 0 && t[k] == '\0')
            return i;
    }
    return -1;
}


