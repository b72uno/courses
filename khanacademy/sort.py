
# sort : lon -> lon
# to sort some piece of shit list of numbers
def insertion_sort(lon):
    for index in range(1, len(lon)):
        value = lon[index]
        i = index - 1
        while i>=0:
            if value < lon[i]:
                lon[i+1],lon[i] = lon[i],lon[i+1]
                i = i - 1
            else:
                break


# now looking back at this code 9 months later, all I have to say is:
# Insertion sort? If the data set is small, its pretty efficient. Good choice!
 
