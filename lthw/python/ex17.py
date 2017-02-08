# interesting, why are we importing only some modules/functions
# or whatever they are called? Would importing all from sys or os
# introduce some overhead?
from sys import argv
# so this is where the exists comes from. Nice
from os.path import exists

# The ultimate oneliner.
# open(argv[2], 'w').write(open(argv[1]).read())


script, from_file, to_file = argv

print "Copying from %s to %s" % (from_file, to_file)

# We could do it on one line too, only I wonder whether it stays open
# somehow there just hanging in the air. How do we close it? Or its auto?
# k, Zed clarified that its closed by Python
indata = open(from_file).read()
in_file = open(from_file)
indata = in_file.read()

# Cool, we can print the size of our data in bytes
print "The input file is %d bytes long" % len(indata)


print "Does the output file exist? %r" % exists(to_file)
print "Ready, hit RETURN to continue, CTR+C to abort"
raw_input("?")

out_file = open(to_file, 'w')
out_file.write(indata)

print "Alright, all done!"

out_file.close()
in_file.close()

