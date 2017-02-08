#include <stdio.h>

int main(int argc, const char *argv[])
{
    const int data[5] = {1,2,3,4,5};
    int i, sum;

    // just a test to check what Rob Bowden was
    // going on about. data is a non-existent, constant pointer
    // within the boundaries of this function or sth like that
    // the same
    /* int *p; */
    /* p = data; */
    /* printf("%p\n", data); */
    /* printf("%p\n", &data); */

    // different
    /* printf("%p\n", p); */
    /* printf("%p\n", &p); */

    // removing = fixes the seg fault error
    for (i = 0; i >=0; i++) {
        sum += data[i];
    }

    printf("sum = %i\n", sum);

    return 0;
}

