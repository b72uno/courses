/**
 * Write a program to remove all comments from a C program.
 * Dont forget to handle quoted strings and character constants properly.
 * C comments dont nest.
 **/

/**
 * Havent covered enough file i/o at this point yet to do this with files, 
 * I'll just use getchar and putchar, check input for // and skip everything
 * after until line break and check for \/\* and skip anything in between.
 * "Dont forget to handle quoted strings and character constants properly" What
 * those have to do with comments??
 **/

#include <stdio.h>

void removecomments(void);

int main(int argc, const char *argv[])
{
    removecomments();
    return 0;
}

void removecomments(void)
{

    int c, starflag, slashflag, blockcomment, linecomment;
    starflag = 0, slashflag = 0, blockcomment = 0, linecomment = 0;

    // get char
    while ((c = getchar()) != EOF && c != '\n')
    {

    /* if we are in a block comment
     * if we encounter star
     * set startflag, its not getting output anyway
     * if we encounter sth else and starflag is set, reset it
     * if we encounter slash and starflag is set, get out of blockcomment
     * reset values and continue with next iteration*/

        if (blockcomment)
        {
            // if comment ends
            if (starflag && c == '/')
            {
                // if starflag is set we exit comment
                blockcomment = 0;
                starflag = 0;
                slashflag = 0;
            }
            // doesnt matter whether its already set, only next character
            // will determine whether comment will end **/
            if (c == '*')
            {
                starflag = 1;
            }
            // if we got this far, we can keep looking
            continue; // loop again skipping the rest of the code
        }

    /* if we are in a linecomment mode
     * if we encounter \n or \r, break out of linecomment mode
     * and no, you can not escape them, with \ or ??/ or with some other magic,
     * no need to get overly complicated here, get off my lawn.
     */
        if (linecomment)
        {
            if (c == '\r' || c == '\n') 
            {
                linecomment = 0;
                slashflag = 0;
            }
            // if we got this far, we can keep looking
            continue; // loop again skipping the rest of the code
        }


    /* otherwise we are in normal mode and we can check for char to outpout */

    /* if we encounter slash, might be for 1st or 2nd time 
     * do not print it. */
        if (c == '/')
        {
            /* else if second time (slashflag = 1), it is start of a linecomment 
             * enter linecomment state */
            if (slashflag)
            {
                linecomment = 1;
                continue; // loop again skipping the rest of the code
            }

            /* if first time (slashflag = 0), set slashflag to 1 */
            slashflag = 1;
            continue; // loop again skipping the rest of the code
        }


    /* if we encounter star * and 
     *  - slashflag is set, its a start of a blockcomment, enter block state */
        if (c == '*')
        {
            if (slashflag)
            {
                blockcomment = 1;
                continue; // loop again skipping the rest of the code
            }
        }

    /* if not slash and slashflag is set, reset flag, and output
     * slash and c to compensate for previously not outputing it.
    */

        // if we got this far, its neither second / nor * and we are not going
        // to enter the comment mode
        if (slashflag)
        {
            // reset flag and print to compensate for previous loss of '/'
            slashflag = 0;
            putchar('/');
            putchar(c);

        } else { // slashflag was not set and its just a simple char, print it
            putchar(c);
        }

    }
}
        
