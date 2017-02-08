#include <stdio.h>
#include <cs50.h>


int main(void) {
    
    int cents, coins, quarters, dimes, nickels, pennies;
    float sum = -1.0;
    
    
    do {
        printf("O hai! How much change is owed?\n");
        sum = GetFloat();
    } while (sum < 0);
    
    
    // + 0.5 to get rid of edge cases like 4.20, where (int) 419.999 -> 419
    cents =  (int) (sum * 100 + 0.5);
    
    quarters = (int) (cents / 25.0);
    dimes = (int) (cents % 25 / 10.0);
    nickels = (int) (cents % 25 % 10 / 5.0);
    pennies = (int) (cents % 25 % 10 % 5);
    
    coins = quarters + dimes + nickels + pennies;
    
    printf("%d\n", coins);
    
}