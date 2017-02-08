# importing argv module from sys library
from sys import argv

# unpacking args
script, filename = argv

# warning user
print "We're going to erase %r." % filename
print "If you don't want that, hit CTRL-C."
print "IF you do want that, hit return"

# asking for raw input, any input would suffice
# that doesnt raise EOF error
raw_input("?")


print "Opening the file..."
# opening the file in write mode
target = open(filename, "w")

# Really no need for this in w mode
# print "Truncating the file. Goodbye!"
# # truncates, basically empties the file if no arguments supplied
# target.truncate()

print "Now I'm going to ask you for three lines"

# 3 raw input strings, assigning to args
line1 = raw_input("line 1: ")
line2 = raw_input("line 2: ")
line3 = raw_input("line 3: ")

print "I'm going to write these to the file"

# writing to file 3 inputs saved before
target.write(line1 + "\n" + line2 + "\n" + line3 + "\n")

print "And finally, we close the file"
# closing the file
target.close()

print "Would you like to reopen the file?"
answer = raw_input("y/n: ")

if answer == "y":
    target = open(filename, "r")
    print "You wrote:"
    print target.read()
else:
    print "Bye!"


# Note: Update modes + will open file in both read and write modes, and
# depending on the character use, position the file in different ways.
# What now? I didnt get that last part wery well.

# also 'r' mode is default when no args to open() are specified

