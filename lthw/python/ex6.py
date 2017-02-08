# %d - digit, providing one after the line
x = "There are %d types of people." % 10
# what to explain here?
binary = "binary"
# using ' inside "", perfectly valid
do_not = "don't"
# printing 2 strings with % s, providing a tuple of integers
y = "Those who know %s and those who %s." % (binary, do_not)

# printing x
print x
# printing y
print y

# hmm printing something as %r... k %r displays raw contents of a variable
# therefore it should be used when debugging, otherwise %s
print "I said: %r." % x
# see above, %r for debugging, other formats for users
print "I also said: '%s'." % y

# boolean value
hilarious = False

# setting up the print statement
joke_evaluation = "Isn't that joke so funny!? %r"

# this is real nice
# if you dont provide a variable, it just prints %r
print joke_evaluation % hilarious

# first string
w = "This is the left side of..."
# second string
e = "a string with a right side."

# concatenating strings. How / why it works?
print w + e

z = 'a'
c = 'b'

print z + c
