#include <stdio.h>

/* print Fahrenheit-Celsius table */
/*     for fahr = 0, 20, .., 300 */

int main(void)
{
    float fahr, celsius;
    float lower, upper, step;

    lower = 0; /* lower limit of temperature scale  */
    upper = 300; /* something something */
    step = 20; /* step size */

    /* Printing C->F */
    printf("F -> C\n");
    printf("========\n");
    fahr = lower;
    while (fahr <= upper) 
    {
        /* celsius = 5 * (fahr-32) / 9; */
        celsius = 5/9.0 * (fahr-32);
        printf("%3.0f %6.1f\n", fahr, celsius);
        fahr = fahr + step;
    }

    /* Printing F->C */
    printf("C -> F\n");
    printf("========\n");
    celsius = lower;
    while (celsius <= upper) 
    {
        /* celsius = 5 * (celsius-32) / 9; */
        fahr = 9/5.0 * (celsius+32);
        printf("%3.0f %6.1f\n", celsius, fahr);
        celsius = celsius + step;
    }
    return 0;
}
