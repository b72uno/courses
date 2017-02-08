/*
 * Write a program to determine the ranges of char, short, int and long
 * variables, both signed and unsigned, by printing appropriate values from
 * standard headers and by direct computation. Harder if you compute them:
 * determining the various ranges of floating-point types.
 */

/*
 * Not sure how to do direct computation. If I am allowed to use sizeof, I could
 * just take two to the power of bits - 1 (0) for unsigned,
 * and /2  min signed and /2 - 1 (0) for max signed 
 * UPDATE: Doesnt seem to work on ints and longs which are of the same size 
 * some kind of overflow going on, not sure where or why. I suck.
 * Will have to keep this in mind and come back later if I find the reason why
 * this happened.
 * UPDATE 2: Same for long double. Some kind of overflow, or I am not formatting
 * the numbers correctly in printf statement, I dont know. Also, those values
 * seem to be machine dependent. (Duh!)
 * UPDATE 3: My machine at work (Win XP) uses MinGW, which apparently is
 * broken regarding long double. In windows double and long double is the
 * same. However, in MinGW long double is larger than double, hence it can print
 * only the long double of MS Windows, that is the double.
 * So much for long double. I suspect but I am not sure, whether the same
 * goes for integral types. At least printing int should do the right thing.
 * UPDATE 4: Useful fact - direction or  truncation for / and the sign of the
 * result for % are machine dependent for negative operands, as is the action
 * taken on overflow and underflow.
 */

#include <stdio.h>
#include <float.h>
#include <limits.h>

unsigned long int exp(int base, int power);
      
int main(int argc, const char *argv[])
{
    printf("Testing testing...\n");

    printf("* * * * * CHAR * * * * * \n");
    printf("Printing char bits from limits.h: %i\n", CHAR_BIT);
    printf("Printing char bytes with sizeof: %i\n", sizeof(char));
    printf("Printing min signed char value from limits.h: %i\n", SCHAR_MIN);
    printf("Printing max signed char value limits.h: %i\n", SCHAR_MAX);
    printf("Printing max unsigned char value limits.h: %i\n", UCHAR_MAX);
    printf("Computing using sizeof...\n");
    printf("min signed char: -%i\n", (exp(2, sizeof(char) * 8) / 2));
    printf("max signed char: %i\n", exp(2, sizeof(char) * 8) / 2 - 1);
    printf("max unsigned char: %i\n", exp(2, sizeof(char) * 8) - 1);
    printf("\n");

    printf("* * * * * SHORT * * * * * \n");
    printf("Printing short bytes with sizeof: %i\n", sizeof(short));
    printf("Printing min signed short value from limits.h: %i\n", SHRT_MIN);
    printf("Printing max signed short value limits.h: %i\n", SHRT_MAX);
    printf("Printing max unsigned short value limits.h: %i\n", USHRT_MAX);
    printf("Computing using sizeof...\n");
    printf("min signed short: -%i\n", (exp(2, sizeof(short) * 8) / 2));
    printf("max signed short: %i\n", exp(2, sizeof(short) * 8) / 2 - 1);
    printf("max unsigned short: %i\n", exp(2, sizeof(short) * 8) - 1);
    printf("\n");

    printf("* * * * * INT * * * * * \n");
    printf("Printing int bytes with sizeof: %i\n", sizeof(int));
    printf("Printing min signed int value from limits.h: %i\n", INT_MIN);
    printf("Printing max signed int value limits.h: %i\n", INT_MAX);
    printf("Printing max unsigned int value limits.h: %u\n", UINT_MAX);
    printf("Computing using sizeof...\n");
    printf("min signed int:%li\n", (long int) exp(2, sizeof(int) * 8) / (long int)2);
    printf("max signed int: %li\n", (long int) exp(2, sizeof(int) * 8) / (long int) 2 - 1);
    printf("max unsigned int: %lu\n", (unsigned long int) exp(2, sizeof(int) * 8) - 1);
    printf("\n");

    printf("* * * * * LONG * * * * * \n");
    printf("Printing long bytes with sizeof: %i\n", sizeof(long));
    printf("Printing min signed long value from limits.h: %i\n", LONG_MIN);
    printf("Printing max signed long value limits.h: %i\n", LONG_MAX);
    printf("Printing max unsigned long value limits.h: %u\n", ULONG_MAX);
    printf("Computing using sizeof...\n");
    printf("min signed long: -%li\n", (long int) exp(2, sizeof(long) * 8) / 2);
    printf("max signed long: %li\n", (long int) exp(2, sizeof(long) * 8) / 2 - 1);
    printf("max unsigned long: %lu\n", (unsigned long int) exp(2, sizeof(long) * 8) - 1);
    printf("\n");

    printf("* * * * * FLOAT * * * * * \n");
    printf("Base for all floating-point types float, double and long double: %i\n", FLT_RADIX);
    printf("Minimum exponent for normalized float: %i\n", FLT_MIN_EXP);
    printf("Maximum exponent that generates a normalized fp number: %i\n", FLT_MAX_EXP);
    printf("Minimum base 10 exponent for normalized float: %i\n", FLT_MIN_10_EXP);
    printf("Maximum base 10 exponent that generates a normalized fp number: %i\n", FLT_MAX_10_EXP);
    printf("Minumum finite representable floating point number: %g\n", FLT_MIN);
    printf("Maximum finite representable floating point number: %g\n", FLT_MAX);
    printf("Difference between 1 and least value greater than 1 that is representable: %g\n", FLT_EPSILON);
    printf("\n");

    printf("* * * * * DOUBLE * * * * * \n");
    printf("Base for all floating-point types float, double and long double: %i\n", FLT_RADIX);
    printf("Minimum exponent for normalized double: %i\n", DBL_MIN_EXP);
    printf("Maximum exponent that generates a normalized fp number: %i\n", DBL_MAX_EXP);
    printf("Minimum base 10 exponent for normalized double: %i\n", DBL_MIN_10_EXP);
    printf("Maximum base 10 exponent that generates a normalized fp number: %i\n", DBL_MAX_10_EXP);
    printf("Minumum finite representable double: %g\n", DBL_MIN);
    printf("Maximum finite representable double: %g\n", DBL_MAX);
    printf("Difference between 1 and least value greater than 1 that is representable: %g\n", DBL_EPSILON);
    printf("\n");

    printf("* * * * * LONG DOUBLE * * * * * \n");
    printf("Base for all floating-point types float, double and long double: %i\n", FLT_RADIX);
    printf("Minimum exponent for normalized long double: %i\n", LDBL_MIN_EXP);
    printf("Maximum exponent that generates a normalized fp number: %i\n", LDBL_MAX_EXP);
    printf("Minimum base 10 exponent for normalized long double: %i\n", LDBL_MIN_10_EXP);
    printf("Maximum base 10 exponent that generates a normalized fp number: %i\n", LDBL_MAX_10_EXP);
    printf("Minumum finite representable long double: %Lf\n", LDBL_MIN);
    printf("Maximum finite representable long double: %Lf\n", LDBL_MAX);
    printf("Difference between 1 and least value greater than 1 that is representable: %Lf\n", LDBL_EPSILON);
    printf("\n");
}

unsigned long int exp(int base, int power)
{
    if (power == 0)
        return 1;

    return base * exp(base, --power);
}
