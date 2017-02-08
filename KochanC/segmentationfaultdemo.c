#include <stdio.h>

// the sort algorithm is fucked up,
// j and i are refering to some garbage
// learn gdb and save time

struct entry
{
    char word[15];
    char definition[50];
};


int compareStrings(const char s1[], const char s2[])
{
    int i = 0;
    int answer;

    // While both are the same and 1st one not null char
    while (s1[i] == s2[i] && s1[i] != '\0')
        ++i;

    if (s1[i] < s2[i]) // The first is smaller
        answer = -1;
    else if (s1[i] == s2[i])
        answer = 0; // They are equal
    else
        answer = 1; // The 2nd is smaller

    return answer;
}

void bubblesort(struct entry entries[])
{
    int i, j, k, swaps;
    
    // iteration count (sorted items)
    k = 0;
    i = 0;
    j = 1;
    swaps = 1;

    // while still swapping
    while (swaps > 0)
    {
        i = i + k;
        j = j + k;

        printf("i: %i and j: %i\n", i, j);

        swaps = 0;

        // while havent reached the end
        while (entries[i].word != '\0') // null string? 
        {
            // if 2nd value is smaller
           if (compareStrings(entries[i].word, entries[j].word) ==  1)
           {
               // swap them
               printf("i: %i and j: %i\n", i, j);
               printf("%s and %s\n", entries[j].word, entries[i].word);
               struct entry tmp = entries[j];
               entries[j] = entries[i];
               entries[i] = tmp;
               ++swaps;
           }
           ++i;
           ++j;
        }
    }
    return;
}

int main(int argc, const char *argv[])
{
    int i;

    struct entry dictionary[100] =
    { { "aardvark", "a burrowing African mammal" },
        { "acumen", "mentally sharp; keen" },
        { "abyss", "a bottomless pit" },
        { "aerie", "a high nest" },
        { "addle", "to become confused" },
        { "agar", "a jelly made from seaweed" },
        { "ahoy", "a nautical call of greeting" },
        { "aigrette", "an ornamental cluster of feathers" },
        { "affix", "to append; attach" },
        { "ajar", "partially opened" } };


     // Bite me, I could have gone with bogosort
    bubblesort(dictionary);


     for (i = 0; i < 10; i++) {
         printf("%s\n", dictionary[i].word);
     }

    return 0;
}


