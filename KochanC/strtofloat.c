#include <stdio.h>

float strToFloat(char floatstr[]);

int main(int argc, const char *argv[])
{
    
    float result = strToFloat("-867.6921");
     // can I do .4f for rounding??
    printf("%.4f\n", result);

    return 0;
}

float strToFloat(char floatstr[])
{

    int i, negative, num, pastRadix;
    float result;

    i = 0;
    result = 0;
    negative = 1;

    if (floatstr[0] == '-')
    {
        i = 1;
        negative = -1;
    }

    // while havent reached the end of string or at the radix point
    while (floatstr[i] != '\0' && floatstr[i] != '.')
    {
        
        // convert to number
        num = floatstr[i] - '0';
        result = result * 10 + num;
        ++i;
    }

    int k = 1;
    float fract = 0;

    // if we've hit the radix point
    if (floatstr[i] == '.')
    {

        ++i; 
        // continue
        while (floatstr[i] != '\0')
        {
            num = floatstr[i] - '0';
            fract = fract * 10 + num;
            ++k;
            ++i;
        }

        // divide number into fraction
        for (; k > 1; --k) {
            fract = fract / 10;
        }
    }
    
    return (result + fract) * negative;
}
