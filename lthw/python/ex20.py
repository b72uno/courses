from sys import argv

script, input_file = argv

def print_all(f):
    print f.read()

# at least something new, yay!
# if text file, only offsets returned by tell(), what??
# if arbitrary value is used, behaviour is undefined. uhm...
def rewind(f):
    f.seek(0)

def print_a_line(line_count, f):
    print line_count, f.readline()

current_file = open(input_file)

print "First the whole file: \n"

print_all(current_file)

print "Rewind go go."

rewind(current_file)

print "Printing three lines"

current_line = 1
print_a_line(current_line, current_file)
print current_file.tell()

current_line += 1
print_a_line(current_line, current_file)
print current_file.tell()

current_line += 1
print_a_line(current_line, current_file)
print current_file.tell()
