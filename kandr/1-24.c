/**
 * Write a program to check a C program for rudimentary syntax errors like
 * unmatched parentheses, brackets and braces. Dont forget about quotes, both
 * single and double, escape sequences and comments. This problem is hard if you
 * do it in full generality.
 **/

/**
 * How am I to implement something like this at this point? 
 * Parentheses, brackets and braces, single, double quotes are ok but escape 
 * sequences and comments? Come on!
 * And yes, I am ignoring the full generality, which, I assume, is escape
 * sequences and comments. 
 **/

#include <stdio.h>
#define MAXLINE 1000 /* maximum input line size */

char line[MAXLINE]; /* current input line */

int checksyntax(void);
int getline(void);


int main(int argc, const char *argv[])
{

    int val;

    val = checksyntax();

    switch(val)
    {
        case 1:
            printf("Check your parantheses!\n");
            break;
        case 2:
            printf("Check your square brackets!\n");
            break;
        case 3:
            printf("Check your curly braces!\n");
            break;
        case 4:
            printf("Check your single quotes!\n");
            break;
        case 5:
            printf("Check your double quotes!\n");
            break;
        default:
            printf("You seem to be ok.\n");
    }
    
    return 0;
}


int checksyntax(void)
{
    int i, parens, parensc, squares, squaresc, curlies, curliesc; 
    int singles, doubles;
    parens = 0, squares = 0, curlies = 0, singles = 0, doubles = 0;
    squaresc = 0, parensc = 0, curliesc = 0;

    int len = getline();
    extern char line[];


    // iterate over the line
    for (i = 0; i < len; ++i)
    {
        switch(line[i])
        {
            // if we find opening parentheses, look for the other one
            case '(':
                parensc = 1;
                break;
            case ')':
                if (parensc)
                    parens = 0;
                else
                    parens = 1;
                break;
            // if we find opening brackets, look for the other one
            case '[':
                squaresc = 1;
                break;
            case ']':
                if (squaresc)
                    squares = 0;
                else
                    squares = 1;
                break;
            // if we find opening curlies, look for the other one
            case '{':
                curliesc = 1;
                break;
            case '}':
                if (curliesc)
                    curlies = 0;
                else
                    curlies = 1;
                break;
            // if we find opening single quote, look for the other one
            case '\'':
                if (singles)
                    singles = 0;
                else
                    singles = 1;
                break;
            // if we find opening double quote, look for the other one
            case '"':
                if (doubles)
                    doubles = 0;
                else
                    doubles = 1;
                break;
        }

    }
    if (parens) return 1;
    if (squares) return 2;
    if (curlies) return 3;
    if (singles) return 4;
    if (doubles) return 5;
    return 0;
}

int getline(void)
{
    int c, i;

    extern char line[];

    for (i = 0; i < MAXLINE - 1 && (c = getchar()) != EOF && c != '\n'; ++i)
        line[i] = c;

    if (c = '\n')
    {
        line[i] = c;
    }

    line[i] = '\0';
    return i;
}


