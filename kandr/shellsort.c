/* Shell sort (by D.L. Shell in 1959) in early stages compares far-apart
 * elements instead of adjacent ones, therefore elimitaing large amounts of
 * disorder quickly, so later stages have less work to do. The interval between
 * compared elements is gradually decreased to one, at which point the sort
 * effectively becomes an adjacent interchange method.
 *
 *
 * Shellsort : sort v[0] ... v[n-1] into increasing order
 */

#include <stdio.h>

void shellsort(int v[], int n)
{
    int gap, i, j, temp;

    // this thing controls gap between compared elements
    // by shrinking it from n/2 by a factor of two each pass
    // until it becomes zero
    // Basically, when gap has become 1, its just like any other adjacent
    // interchange sort at that point
    for (gap = n / 2; gap > 0; gap /= 2)
        // this one steps along the elements.
        for (i = gap; i < n; i++)
            // this beauty compares each pair of elements that is separated by
            // gap and reverses any that are out of order. Since gap is
            // eventually reduced to one, all elements are eventually ordered
            // correctly.
            for ( j = i - gap; j >= 0 && v[j] > v[j+gap]; j -= gap )
            {
                temp = v[j];
                v[j] = v[j+gap];
                v[j+gap] = temp;
            }
}

// Having not seen this code for 3 weeks, I do not understand how shell sort
// works any more. I get it that it compares elements with a gap between them.
// But I can not picture it. Will try to comment more clarity into this now,
// after I will have worked it out on paper with a small set of numbers.
//
// Ok. It is what I had picture before, but wasn't completely sure of it.
// Adjacent interchange sort with a gap in between, that gets reduced by a
// factor of 2 with each pass.

// What baffled me waht the "v[j] and v[j+gap]; j-= gap" part. Basically, if it
// makes a swap, it backpedals by gap to previous value and compares that with
// the value we just swapped in the jth place.

int main(int argc, const char *argv[])
{

    // yeye hardcoding is bad.
    int i;
    int sortme[10] = {2, 3, 4, 9, 0, 7, 6, 13, 62, 43};

    shellsort(sortme, 10);

    printf("Sorted array:\n");
    for (i = 0; i < 10; i++) {
        printf("%i\n", sortme[i]);
    }

    return 0;
}
