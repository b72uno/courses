/* Write an alternative version of squeeze(s1, s2) that deletes each character
 * in s1 that matches any character in the string s2. Squeeze:
 */

/* squeeze: delete all c from s */
/* void squeeze(char s[], int c) */
/* { */
/*     int i, j; */
/*     for (i = j = 0; s[i] != '\0'; i++) */
/*         if (s[i] != c) */
/*             s[j++] = s[i]; */
/*     s[j] = '\0'; */
/* } */

#include <stdio.h>

void squeeze2(char s[], char c[]) 
{
    int i, j;
    int isin(int x, char s[]);

    for (i = j = 0; s[i] != '\0'; i++)
        if (!isin(s[i], c))
            s[j++] = s[i];
        s[j] = '\0';
}

int main(int argc, const char *argv[])
{
    void squeeze2(char s[], char c[]);

    char string1[] = "booyaka";
    char string2[] = "boo";

    squeeze2(string1, string2);

    printf("Booyaka boo. %s?\n", string1);

    return 0;
}

int isin(int c, char s[])
{
    int i;

    for (i = 0; s[i] != '\0'; i++)
        if (c == s[i])
            return 1;
    return 0;
}



