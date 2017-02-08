# we need to go deeper!
formatter = "%r %r"

formatter = formatter + "%r %r"


print formatter % (1,2,3,4)
print formatter % ("one", "two", "three", "four")
print formatter % (True, False, False, True)
print formatter % (formatter, formatter, formatter, formatter)
print formatter % (


    # Does vertical white space matter?


    "I had this thing",
    "That you could type up right.",
    # single quotes , double quotes.
    # makes no difference to me....
    # and to python either.
    'Bud it didnt sit tight.',
    "So I said goodnight."


    # nope
)

# notice that pyton prints out strings with single quotes.
# Zed writes that python will print strings in the most
# efficient way it can, not replicate the way they were written

