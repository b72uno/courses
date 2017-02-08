#include <stdio.h>

struct time
{
    int hours;
    int minutes;
    int seconds;
};

int elapsed_time(struct time time1, struct time time2);
int abs(int x);

int main(int argc, const char *argv[])
{
    struct time time1 = { .hours = 3, .minutes = 45, .seconds = 15 };
    struct time time2 = { .hours = 9, .minutes = 44, .seconds = 3 };

    int elapsed = elapsed_time(time1, time2);

    int seconds = elapsed % 60;
    elapsed /= 60;
    int minutes = elapsed % 60;
    elapsed /= 60;
    int hours = elapsed % 60;

    printf("Elapsed: %i hours %i minutes and %i seconds\n", hours, minutes, seconds);
    
    return 0;
}

int elapsed_time(struct time time1, struct time time2)
{
    int seconds1 = time1.hours * 60 * 60 + time1.minutes * 60 + time1.seconds;
    int seconds2 = time2.hours * 60 * 60 + time2.minutes * 60 + time2.seconds;

    return abs(seconds2 - seconds1);
}

int abs(int x)
{
    return (x < 0) ? (x * -1) : x;
}

