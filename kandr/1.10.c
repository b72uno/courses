/* External Variables and Scope */

/**
 * Each local variable in function comes into existence when f is called
 * and disappears when exited, hence they are called automatic variables.
 * Other case is static variables, which do retain their values between calls.
 **/

/**
 * External var must be defined exactly once, outside of any function, this sets
 * aside storage for it. The variable must also be declared in each function
 * that wants to access it, this states the type of the var. The declaration may
 * be an explicit EXTERN statement or may be implicit from context.
 **/


#include <stdio.h>

#define MAXLINE 1000 /* maximum input line size */

int max; /* maximum length seen so far */
char line[MAXLINE]; /* current input line */
char longest[MAXLINE]; /* longest line saved here */

int getline(void);
void copy(void);

/* print longest input line; specialized version */

int main(int argc, const char *argv[])
{
    int len;
    extern int max;
    extern char longest[];

    max = 0;
    while ((len = getline()) > 0)
        if (len > max) {
            max = len;
            copy();
        }

    if (max > 0) /* there was a line */
        printf("%s\n", longest);
    return 0;
}

/* getline : specialized version */
int getline(void)
{
    int c, i;
    extern char line[];

    for (i = 0; i < MAXLINE - 1
            && (c = getchar()) != EOF && c != '\n'; ++i)
        line[i] = c;

    if (c == '\n') 
    {
        line[i] = c;
        ++i;
    }

    line[i] = '\0';
    return i;
}


/* copy : specialized version */
void copy(void)
{
    int i;
    extern char line[], longest[];

    i = 0;
    while ((longest[i] = line[i]) != '\0')
        ++i;
}

/**
 * In certain circumstances, the extern declaration can be omitted. If the
 * definition of the external variable occurs in the source file before its use
 * in a particular function then there is no need for an extern declaration in
 * the function. THe extern declarations in main, getline and copy are thus
 * redundant. In fact, common practice is to place definitions of all external
 * variables at the beginning of the source files, and then omit all extern
 * declarations. 
 **/

/**
 * Definition and declaration - definition refers to the place where the
 * variable is define. Declaration refers to places where the nature of variable
 * is stated but no storage is allocated.
 **/


