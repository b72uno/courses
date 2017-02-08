#include <stdio.h>

void removeString(char string[], int index, int count);

int main(int argc, const char *argv[])
{
    char text[] = "The Wrong Son";

    removeString(text, 4, 6);

    printf("%s\n", text);
    
    return 0;
}

void removeString(char string[], int index, int count)
{
    int i,j;
    int offset = index + count;
    // should make sure that we are not overreaching 
    // offset should be less than strlen(string)

    // starting from the index, replace letters with letters from offset on
    for (i = index, j = offset; string[j] != '\0'; ++i, ++j) {
        string[i] = string[j];
    }

    string[i] = '\0';

    // not sure what we do with the rest of array? leave it for the dead?

    return;
}
