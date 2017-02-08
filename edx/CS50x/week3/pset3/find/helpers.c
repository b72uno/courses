/**
 * helpers.c
 *
 * Computer Science 50
 * Problem Set 3
 *
 * Helper functions for Problem Set 3.
 */
       
#include <cs50.h>
#include <stdio.h>
#include "helpers.h"


/**
 * Returns true if value is in array of n values, else false.
 */
bool search(int value, int values[], int n)
{
    // TODO: implement a searching algorithm
     //linear_search(value, values, n);
     return binary_search(value, values, 0, n);
    
}

/**
 * Sorts array of n values.
 */
void sort(int values[], int n)
{
    // TODO: implement an O(n^2) sorting algorithm
    
    /* 
Find the smallest unsorted element and add it to the end of the sorted list.

Selection sort pseudocode:
- Repeat until no unsorted elements remain:
    - Search the unsorted part of the data to find the smallest value
    - Swap the smallest found value with the first element of the unsorted part
*/

    for (int i = 0, smallest = values[i]; i < n; i++, smallest = values[i]) {
        
        int pos = i;
        
        for (int j = i; j < n; j++) {
            if (values[j] < smallest) {
                smallest = values[j];
                pos = j;
            }
        }
        
        if (i != pos) {
            values[i] = values[i] ^ values[pos];
            values[pos] = values[pos] ^ values[i];
            values[i] = values[i] ^ values[pos];
        }
        
    }
    
    return;
    
}


bool linear_search(int value, int values[], int n) {
    for (int i = 0; i < n; i++) {
        if (value == (int) values[i])
            return true;
    }
    return false;
}

/* 
Binary search
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
bool binary_search(int value, int values[], int min, int max) {
    if (max < min) {
        return false;
    } else {
        int midpoint = min + ((max - min) / 2);
        if (values[midpoint] < value) {
            return binary_search(value, values, midpoint + 1, max);
        } else if (values[midpoint] > value) {
            return binary_search(value, values, min, midpoint - 1);
        } else {
            return true;
        }
    }
    return false;
}