/*
 * Write a function htoi(s) which converts a string of hexadecimal digits
 * (including an optional 0x or 0X) into its equivalent integer value. The
 * allowable digits are 0 through 9, a through f and A through F.
 */

/* Yes, you can feed it some invalid inputs as well. For example a mixed type
 * hex where it consists of both uppercase and lowercase letters. Other than
 * that, it works. Too lazy to try to improve upon this now. Sue me.
 */

// Also interesting fact: In K&R atoi never checks explicitly for '\0'
// Why is that? My only guess is that '\0' is represented with a smaller integer
// than '0' and s[i] >= '0' will evaluate to false, ending the loop.

#include <stdio.h>
#include <string.h>

int htoi(char s[]);

int main(int argc, const char *argv[])
{
    
    printf("From hex 0x6f to decimal: %i [111]\n", htoi("0x6f"));
    printf("From hex 0XB8 to decimal: %i [184]\n", htoi("0XB8"));
    printf("This should be -1 : %i\n", htoi("gobbligduu"));
    printf("This should be -1 : %i\n", htoi("xacasdwe"));
    printf("This should be -1 : %i\n", htoi("0xaljdkasld"));
    printf("This should be -1 : %i\n", htoi("axdwzasdasd"));
    // should we allow this?
    printf("Should this be -1? 0XaBcD : %i\n", htoi("0XaBcD")); 
    printf("No prefix FA: %i [250]\n", htoi("FA"));

    return 0;
}

int htoi(char s[])
{
    int i = 0;
    int result = 0;
    int capital = 0;

    // if 2nd character is x
    if (s[1] == 'x')
    {
        if (s[0] != '0')
            return -1;
        // skip the x
        i = 2;
    }
    else if (s[1] == 'X')
    {
        if (s[0] != '0')
            return -1;
        i = 2;
        capital = 1;
    }

    for (; i < strlen(s), s[i] != '\0'; i++) 
    {
        int tmp;

        // digit
        if (s[i] >= '0' && s[i] <= '9')
        {
            result = result * 16 + (s[i] - '0');
        }
        // hex letters
        else if ((s[i] >= 'A' && s[i] <= 'F') || (s[i] >= 'a' && s[i] <= 'f'))
        {
            switch(s[i])
            {
                case 'a':
                case 'A':
                    tmp = 10;
                    break;
                case 'b':
                case 'B':
                    tmp = 11;
                    break;
                case 'c':
                case 'C':
                    tmp = 12;
                    break;
                case 'd':
                case 'D':
                    tmp = 13;
                    break;
                case 'e':
                case 'E':
                    tmp = 14;
                    break;
                case 'f':
                case 'F':
                    tmp = 15;
                    break;
            }

            result = result * 16 + tmp;
        }
        // invalid input
        else 
        {
            return -1;
        }
    }

    return result;
}
