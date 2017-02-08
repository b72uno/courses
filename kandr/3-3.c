/* 
 * Write a function expand(s1,s2) that expands shorthand notations like, a-z
 * in the string s1 into equivalent complete list abc xyz in s2. Allow for
 * letters of either case and digits, and be prepared to handle cases like
 * a-b-c and a-z0-9 and -a-z. Arange that a leading or trailing - is taken
 * literally.
 */

/* Now this is fun! */

#include <stdio.h>
#define MAXLENGTH 1000

int main(int argc, const char *argv[])
{
    void expand(char s[], char t[]);
    
    char array[MAXLENGTH];

    expand("a-z0-9", array);
    printf("a-z0-9 Expanded into %s\n", array);
    
    expand("-b-x", array);
    printf("-b-x Expanded into %s\n", array);

    expand("--b-x", array);
    printf("--b-x Expanded into %s\n", array);

    expand("--bb-x", array);
    printf("--bs-z Expanded into %s\n", array);

    expand("k&r0-9", array);
    printf("k&r0-9 Expanded into %s\n", array);

    expand("0-9-", array);
    printf("0-9- Expanded into %s\n", array);

    expand("0-9-z", array);
    printf("0-9-z Expanded into %s\n", array);

    expand("0-9-", array);
    printf("0-9- Expanded into %s\n", array);

    return 0;
}

// It will handle 1 trailing and 1 leading '-', to expand values you have
// to provide them in pairs a-b or 0-9. Something like a-z-9 will result
// in a-z being expanded and z-9 taken literally.
void expand(char s[], char t[])
{
    // Assumes t is large enough to hold stuff requested in it
    // I dont want to use strlen, without that, this code is buggy i.e.
    // if you provide an array with '-' right after \0, it will gladly plow
    // ahead, thats what I think, at least. Haven't tried.

    int i, j, k;
    i = j = 0;
    

    while (s[i] != '\0') // while current char is not null
    {

        if (s[i+1] != '-') // in case the next character is not -
        {
            // take it literally
            t[j++] = s[i++];
        }
        else if (s[i+2] != '\0') // otherwise if next char is not '\0'
        {

            // append whats inbetween them (inclusive)
            // man, I feel this is way too cryptic, hard to follow it
            for (k = s[i]; k <= s[i+2]; k++)
                t[j++] = k;
            i += 3;
            
        }
        else // its a trailing -
        {
            t[j++] = s[i];
            t[j++] = '-';
        }
    }

    // Suddenly I feel like this would have been way easier with a for loop
    // all those ++ are obscuring the readability.

    t[j] = '\0';
}
