#include <stdio.h>

int main(int argc, const char *argv[])
{
    int number, right_digit, result, exponent, tmpnumber;
    int negative = 0;

    printf("Enter an integer: \n");
    scanf("%d", &number);

    tmpnumber = number;

    if (number < 0)
    {
        number *= -1;
        negative = 1;
    }

    exponent = 0;
    result = 0;

    do {
        right_digit = tmpnumber % 10;
        printf ("%i", right_digit);
        tmpnumber = tmpnumber / 10;

        ++exponent;

    } while (tmpnumber != 0);

    printf("Exponent: %d\n", exponent);

    for (int i = exponent - 1; i >= 0; --i) {

        right_digit = number % 10;

        int multiplier = 10;

        for (int j = i; j > 0; --j) {
            multiplier *= 10;
        }

        result += right_digit * multiplier;
        
        number = number / 10;
    }

        
    if (negative == 1)
        printf("-");

    printf("%d", result / 10);
    printf("\n"); 

    return 0;
}
