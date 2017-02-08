/*
 * Write a function escape(s,t) that converts characters like newline and tab
 * into visible escape sequences like \n and \t as it copies the string t to
 * s. Use a switch. Write a function for the other direction as well, converting
 * sequences into the real character.
 */

/* *mumbles* ugh ... 
 */

#include <stdio.h>
#define MAXLENGTH 100

int main(int argc, const char *argv[])
{
    void escape(char s[], char t[], int reverse);

    char fromstring[MAXLENGTH] = "Would you a \t tab? \n New line, perhaps? \r ";
    char tostring[MAXLENGTH];

    printf("Our beatiful string: %s\n", fromstring);
    printf("\n");

    escape(fromstring, tostring, 0);
    printf("Converted to: %s\n", tostring);
    printf("\n");

    escape(fromstring, tostring, 1);
    printf("And converted back to: %s\n", fromstring);

    return 0;
}

void escape(char s[], char t[], int reverse)
{
    // Assumes s[] is large enough to hold T and vice versa + enough spaces
    // for additional characters created by conversion process.
    // Also assumes that if the reverse flag is present, the s string contains
    // converted escape sequences
   
    char *from = s;
    char *to = t;

    int i, j;

    // do the copy pasta
    for (i = 0, j = 0; from[i] != '\0'; i++, j++) 
    {
        if (reverse)
        { // convert visible escape sequences back
          switch(from[j])
          {
              case '\\':
                  switch (from[j+1])
                  {
                      case 't':
                          t[j++] = '\t';
                          break;

                      case 'n':
                          t[j++] = '\n';
                          break;

                      case 'r':
                          t[j++] = '\r';
                          break;
                  }

              default:
                    t[j] = s[i];
                    break;
          }

        } else {
          // convert from invisibles to visible escape sequences
          switch(from[j])
          {
              case '\t':
                  t[j++] = '\\';
                  t[j] = 't';
                  break;
              case '\r':
                  t[j++] = '\\';
                  t[j] = 'r';
                  break;
              case '\n':
                  t[j++] = '\\';
                  t[j] = 'n';
                  break;
              default:
                  t[j] = s[i];
                  break;
          }
        }
    }

    t[j] = '\0';

}
