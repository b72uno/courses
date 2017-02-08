# escape all the quotes!!! allthe.jpg

"I am 6'2\" tall." # escape double-quote inside string
'I am 6\'2" tall.' # escape single-quote inside string

# the third way is to use triple quotes
# isit


tabby_cat = "\tI'm tabbed in."
persian_cat = "I'm split \non a line. Sick!"
backslash_cat = "I'm \\ a \\ cat."


fat_cat = """
I'll do a list:
\t* Cat food
\t* Fishes
\t* Catnip\n\t* Black\fjack and Hookers
"""

print tabby_cat
print persian_cat
print backslash_cat
print fat_cat

# comparing %s and %r
# print "A cat says: %s " % tabby_cat
# print "A cat says: %r " % tabby_cat
# print "A cat says: %s " % backslash_cat
# print "A cat says: %r " % backslash_cat
# print "A cat says: %s " % fat_cat
# print "A cat says: %r " % fat_cat

# a more complex format you say?
formatter = "%s \t %s"
print formatter % (tabby_cat, backslash_cat)

# \f - formfeed wat
# \b - backspace
# \a - bell
# \N - character named name unicode only
# \r ASCII carriage return
# \t ASCII horizontal tab
# \uxxxx character 16bit hex
# \Uxxxxxxxx character 32 bit hex
# \v ASCII vertical tab
# \ooo octal value
# \xhh character with hex value xx


# while True:
#     for i in ["/", "-", "|", "\\", "|"]:
#         print "%s\r" % i,
