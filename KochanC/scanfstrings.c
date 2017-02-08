#include <stdio.h>

int main(int argc, const char *argv[])
{
    char string1[20];
    char string2[20];
    char string3[20];

    printf("Gimme one argument \n");
    scanf("%s", string1);

    // This one automatically continues from the place
    // it left off, if you supplied 2 args when setting string1
    // i.e. 2nd argument will be assigned to string 2
    scanf("%s", string2);

    printf("Gimme one argument \n");
    scanf("%s", string3);

    printf("string1: %s\n", string1);
    printf("string2: %s\n", string2);
    printf("string3: %s\n", string3);
}
