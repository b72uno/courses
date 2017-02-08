#include <stdio.h>

struct entry
{
    int value;
    struct entry *nextStruct;
};

void removeEntry(struct entry *listPtr);

int main(int argc, const char *argv[])
{
    struct entry e1;
    struct entry e2;
    struct entry e3;
    struct entry e4;
    
    struct entry *insertPtr;
    insertPtr = &e4;

    e1.value = 0;
    e1.nextStruct = &e2;
    
    e2.value = 100;
    e2.nextStruct = &e3;

    e3.value = 200;
    e3.nextStruct = &e4;

    e4.value = 300;
    e4.nextStruct = (struct entry *) 0;

    removeEntry(&e2);

    struct entry *startPtr;
    startPtr = &e1;

    while (startPtr)
    {
        printf("Value: %i\n", startPtr->value);
        startPtr = startPtr->nextStruct;
    }

    
    return 0;
}

void removeEntry(struct entry *listPtr)
{
    listPtr->nextStruct = listPtr->nextStruct->nextStruct;
}
