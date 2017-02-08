#include <stdio.h>


    /* read a character */
    /*     while (char is not end of file) */
    /*         output the char just read */
    /*         read a character */


/* copy input to output; 1st version */
int copyio(void)
{
    int c;

    c = getchar();
    while (c != EOF)
        putchar(c);
        c = getchar();
    return 0;
}

/* copy input to output; 2nd version */
/* centralized version, only one reference to getchar */
/* notice the precedence of != is higher than = */

int copyio2(void)
{
    int c;
    while ((c = getchar()) != EOF)
        putchar(c);
}


/* count lines in input */
 countlines(void)
{
    int c, n1;

    n1 = 0;

    while ((c = getchar()) != EOF)
        if (c == '\n') {
            ++n1;
        }

    printf("Lines: %d\n", n1);
}

/* count blanks in input */
void countblanks(void)
{
    int c, n1;

    n1 = 0;

    while ((c = getchar()) != EOF)
        if (c == 32) {
            ++n1;
        }

    printf("Blanks: %d\n", n1);
}
                   
/* count tabs in input */
void counttabs(void)
{
    int c, n1;

    n1 = 0;

    while ((c = getchar()) != EOF)
        if (c == 9) {
            ++n1;
        }

    printf("Tabs: %d\n", n1);
}


/* copy input to output, replacing string of one or more blanks by a single */
/* blank */
void replaceblanks(void)
{
    int c,prev;
    prev = 0;

    while ((c = getchar()) != EOF)
    {
        
        if (c == 0x20)
        {
            if (prev)
            { 
                ;
            } else {

                putchar(c);
                prev = 1;
            }
        } else {
            putchar(c);   
            prev = 0;
        }
    }

}

/* replace each tab by \t, replace each backspace by \b and backslash by \\ */
void replacestuff(void)
{
    int c,prev;
    prev = 0;

    while ((c = getchar()) != EOF)
    {
        
        if (c == 9)
        {
            putchar('\\');
            putchar('t');
        }
        else if (c == 8)
        {
            putchar('\\');
            putchar('b');
        }
        else if (c == 92)
        {
            putchar('\\');
            putchar('\\');
        }else {
            putchar(c);
        }
        
    }
}

int main(void)
{

    /* ; - null statement */

    /* counttabs(); */
    /* countblanks(); */
    /* countlines(); */

    /* replaceblanks(); */
    replacestuff();

    /* printing the value of EOF */
    printf("%d\n", EOF);
    return 0;
}



