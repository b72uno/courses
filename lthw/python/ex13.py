# importing modules aka libraries
from sys import argv

raw_input("Gimme something ")

# argv = argument variable
# take whatever is in argv, unpack it and assign to all vars in order
script, first, second, third = argv


print "The script is called", script
print "Your first varialbe is:", first
print "Your second variable is:", second
print "Your third variable is:", third

# combining with more raw inpu
userinput = raw_input("Gimme gimme more! ")


