/*
 * Rwerite the function lower which converts uppercase letters to lowercase
 * with a conditional expression instead of if-else
 */

#include <stdio.h>

int main(int argc, const char *argv[])
{
    
    int lower(char c);
    int upper(char c);

    printf("Converting A to lower %c\n", lower('A'));
    printf("Converting F to lower %c\n", lower('F'));
    printf("Converting Z to lower %c\n", lower('Z'));
    printf("Feeding wrong input to lower %c\n", lower('a'));

    printf("Converting a to upper %c\n", upper('a'));
    printf("Converting x to upper %c\n", upper('x'));
    printf("Converting z to upper %c\n", upper('z'));
    printf("Feeding wrong input to upper %c\n", upper('B'));
    return 0;
}

int lower(char c)
{
    // for converting the other way, from lower to upper
    // we would have to & c with ~32
    return (c >= 'A' && c <= 'Z') ? c | 32 : c;
}

int upper(char c)
{
    return (c >= 'a' && c <= 'z') ? c & ~32 : c;
}
