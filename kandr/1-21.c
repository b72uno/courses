/**
 * Write a program entab that replaces strings of blanks by the minimum
 * number of tabs and blanks to achieve the same spacing. Use the same tab stops
 * as for detab. When either a tab on single blank would suffice to reach a tab
 * stop, which would be given preference?
 **/

/**
 * A: A single blank would be preferable?! 
 * What is a blank? A tab, space or both??
 * Not sure what is "use the same tab stops as for detab"? Same amount or the
 * same way it was declared? I'll assume both.
 **/



#include <stdio.h>
/* #define TABSTOPWIDTH 4  // symbolic constant */

void entab(int tabwidth);

int main(int argc, const char *argv[])
{
    
    // call detab with tabwidth 4
    entab(4);
    return 0;
}

void entab(int tabwidth)
{
    int c, i, j, justblanks;

    i = 0, j = 0;

    // get line
    while ((c = getchar()) != EOF && c != '\n')
    {
        // if we run into a space
        if (c == ' ')
        {
            // add to the blank total
            j += 1;
            justblanks = 1;

        } else {
           
            // character right after blanks
            if (justblanks)
            {
                //put appropriate amount of tabs / spaces
                int tabs;
                for (tabs = j / tabwidth; tabs > 0; --tabs)
                    putchar('\t');
                for (j %= tabwidth; j > 0; --j)
                    putchar(' ');
                
                // reset blank flag
                // dont forget the char we just read
                putchar(c);
                justblanks = 0;
                j = 0;

            } else { // character after another character
            // just put in what we read
            putchar(c);
            // increment our position
            ++i; // this is completely useless
            }
        }

    }
}

/* comparing with solutions online */

/******************************************************
   KnR 1-21
   --------
   Write a program "entab" which replaces strings of 
   blanks with the minimum number of tabs and blanks 
   to achieve the same spacing.

   Author: Rick Dearman
   email: rick@ricken.demon.co.uk

******************************************************/
/* #include <stdio.h> */
/*  */
/* #define MAXLINE 1000 #<{(| max input line size |)}># */
/* #define TAB2SPACE 4 #<{(| 4 spaces to a tab |)}># */
/*  */
/* char line[MAXLINE]; #<{(|current input line|)}># */
/*  */
/* int getline(void);  #<{(| taken from the KnR book. |)}># */
/*  */
/*  */
/* int */
/* main() */
/* { */
/*   int i,t; */
/*   int spacecount,len; */
/*  */
/*   while (( len = getline()) > 0 ) */
/*     { */
/*       spacecount = 0; */
/*       for( i=0; i < len; i++) */
/* 	{ */
/* 	  if(line[i] == ' ') */
/* 	    spacecount++; #<{(| increment counter for each space |)}># */
/* 	  if(line[i] != ' ') */
/* 	    spacecount = 0; #<{(| reset counter |)}># */
/* 	  if(spacecount == TAB2SPACE) #<{(| Now we have enough spaces */
/* 				      ** to replace them with a tab */
/* 				      |)}># */
/* 	    { */
/* 	      #<{(| Because we are removing 4 spaces and */
/* 	      ** replacing them with 1 tab we move back  */
/* 	      ** three chars and replace the ' ' with a \t */
/* 	      |)}># */
/* 	      i -= 3; #<{(| same as "i = i - 3" |)}># */
/* 	      len -= 3; */
/* 	      line[i] = '\t'; */
/* 	      #<{(| Now move all the char's to the right into the */
/* 	      ** places we have removed. */
/* 	      |)}># */
/* 	      for(t=i+1;t<len;t++) */
/* 		line[t]=line[t+3]; */
/* 	      #<{(| Now set the counter back to zero and move the  */
/* 	      ** end of line back 3 spaces */
/* 	      |)}># */
/* 	      spacecount = 0; */
/* 	      line[len] = '\0';  */
/* 	    } */
/* 	} */
/*       printf("%s", line); */
/*     } */
/*   return 0; */
/* } */
/*  */
/*  */
/* #<{(| getline: specialized version |)}># */
/* int getline(void) */
/* { */
/*   int c, i; */
/*   extern char line[]; */
/*    */
/*   for ( i=0;i<MAXLINE-1 && ( c=getchar()) != EOF && c != '\n'; ++i) */
/*     line[i] = c; */
/*   if(c == '\n')  */
/*     { */
/*       line[i] = c; */
/*       ++i; */
/*     } */
/*   line[i] = '\0'; */
/*   return i; */
/*  */
/* } */
/*  */
/*  */
