/*
 * Given the basic framework, it's straightforward to extend the calculator. Add
 * the modulus % operator and provisions for negative numbers
 */

/* reverse Polish calculator */
#include <stdio.h>
#include <stdlib.h> /* for atof() */

#define MAXOP 100 /* max size of operand or operator */
#define NUMBER '0' /* signal that a number was found */

int getop(char[]);
void push(double);
double pop(void);



int main(int argc, const char *argv[])
{
    int type;
    double op1, op2;
    char s[MAXOP];

    while ((type = getop(s)) != EOF)
    {
        switch(type)
        {
            case NUMBER:
                push(atof(s));
                break;
            case '+':
                push(pop() + pop());
                break;
            case '*':
                push(pop() * pop());
                break;
            case '-':
                op2 = pop();
                push(pop() - op2);
                break;
            case '/':
                op2 = pop();
                if (op2 != 0.0)
                    push(pop() / op2);
                else
                    printf("error: zero divisor\n");
                break;
            case '\n':
                printf("\t%.8g\n", pop());
                break;
            case '%':
                op2 = pop();
                if (op2 != 0.0)
                    push( (int) pop() % (int) op2);
                else
                    printf("error: zero divisor\n");
                break;
            default:
                printf("error: unknown command %s\n", s);
                break;
        }
    }

    return 0;
}

#define MAXVAL 100  /* maximum depth of stack val */

int sp = 0;  /* next free stack position */
double val[MAXVAL];  /* value stack */

/* push : push f onto value stack */
void push(double f)
{
    if (sp < MAXVAL)
        val[sp++] = f;
    else
        printf("error: stack full, can't push %g\n", f);
}

/* pop : pop and return top value from stack */
double pop(void)
{
    if (sp > 0)
        return val[--sp];
    else
    {
        printf("error: stack empty\n");
        return 0.0;
    }
}


#include <ctype.h>

int getch(void);
void ungetch(int);

/* getop : get next operator or numeric operand */
int getop(char s[])
{
    int i, c;

    // skip whitespace
    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;

    // if the next character is not a digit or a hexadecimal point
    // then return it. Otherwise collect a string of digits and return NUMBER


    // why this???
    // if we don't write anything to s, then we need our nullchar to mark the
    // end of the string
    s[1] = '\0';

    // if not a digit, nor a radix point nor a negative unary op
    if (!isdigit(c) && c != '.' && c != '-')
        return c;  /* not a number */

    // if we're at this point, we are going to overwrite s[1]

    i = 0;

    // if unary -
    if (c == '-')
    {
        // get the char after
        int nextchar = getch();
        // if the following char is not radix pt and is not a digit
        // then its an op, return it
        if(!isdigit(nextchar) && nextchar != '.')
            return c;
        // skip to numbers
        c = nextchar;
    }
    else
    {
        // if its not -, its gotta be .
        c = getch();
    }

    // if c is ., this wont run
    // notice, that its copying it to string here, while checking for cond
    while (isdigit(s[++i] = c))
        c = getch();
            ;

    // but this will
    if (c == '.') /* collect fraction part */
        while (isdigit(s[++i] = c = getch()))
            ;

    s[i] = '\0';
    if (c != EOF)
        ungetch(c);

    return NUMBER;
}

#define BUFSIZE 100

char buf[BUFSIZE]; /* buffer for ungetch */
/* Notice that bufp name suggests it is a pointer when it is not. Just index. */
int bufp = 0; /* next free position in buf */

int getch(void) /* get a (possibly pushed-back) character */
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c) /* push character back on input */
{
    if (bufp >= BUFSIZE)
        printf("ungetch: too many characters\n");
    else
        buf[bufp++] = c;
}
