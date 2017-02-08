/* 
 * Write the function any(s1, s2), which returns the first location in a string
 * s1 where any character from string s2 occurs or -1 if s1 contains no
 * characters from s2. 
 */


#include <stdio.h>

int any(char s[], char c[]) 
{
    int i;
    int isin(int x, char s[]);

    for (i = 0; s[i] != '\0'; i++)
        if (isin(s[i], c))
            return i;
    return -1;
}

int main(int argc, const char *argv[])
{
    int any(char s[], char c[]);

    printf("This should be 0: %i\n", any("abacus", "abc"));
    printf("This should be 5: %i\n", any("python", "amen"));
    printf("This should be 3: %i\n", any("grizzly", "zen"));
    printf("This should be -1: %i\n", any("tesla", "info"));
    printf("This should be -1: %i\n", any("tesla", ""));
    printf("This should be -1: %i\n", any("", ""));
    printf("This should be -1: %i\n", any("", "wat"));

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

/* Compared my shaite code to solutions online. 
 * Some people seem to use a whole bunch of words, around 20 to test
 * their program. Seems like a waste of time to me. All you need is to check your
 * input space - first string empty, second string empty, both empty,
 * char at the beginning, char in the middle, char in the end, same goes for
 * the second string. Thats it. Making more tests with more words wont change a
 * thing. Somebody correct me if I'm wrong.
 */
