/* 
Divide and conquer - reduce the search area by half each time, trying to find a target number.
The array must be sorted to leverage this. 

Pseudocode:
- Repeat until the (sub)array is of size 0:
    - Calculate the middle point of the current (sub)array
    - If the target is at the middle, stop
    - Otherwise if the target is less than what is at the middle, repeat, changing the end point to be just to the left of the middle
    - Otherwise, if targer is greater than what is at the middle, repeat, changing the start point to tbe just the right of the middle
    
    binarySearch(key, array[], min max) 
    if (max < min):
        return -1
    else:
        midpoint = findMidPoint(min,max)
        
        if (array[midpoint] < key):
            binarySearch(key, array, midpoint + 1, max)
        else if (array[midpoint] > key):
            binarySearch(key, array, min, midpoint - 1)
        else:
            return midpoint
*/

#include <stdio.h>
#include <stdlib.h>

int main(void) {
    
}