#include <stdio.h>

void substring(const char source[], int start, int count, char result[]);

int main(int argc, const char *argv[])
{
    char source[] = { "two words" };
    char result[80];
    int start, count;


    start = 4;
    count = 20;

    substring(source, start, count, result);

    printf("%s\n", result);

    return 0;

}

void substring(const char source[], int start, int count, char result[])
{
    int i,j;
    for (i = start, j = 0; i - start < count && source[i] != '\0'; ++i, ++j)
    {
        result[j] = source[i];
    }

    result[j+1] = '\0';
    
    return;
}




