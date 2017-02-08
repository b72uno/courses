name = "Bruno"
age = 24
height = 187 #cm
weight = 78 #kg
eyes = 'Blue'
teeth = 'Could be better'
hair = 'Blondish'

print "Lets talk about %s." % name
print "He's %d cm tall." % height
print "He's %r pounds heavy." % weight
print "Actually its ok."
print "He's got %s eyes and %s hair." % (eyes, hair)
print "His teeth are usually %s depending on the coffee and cake" % teeth

# This line is supposed to be tricky
print "If I add %d, %d, and %d I get %d" % (age, height, weight, \
                                            import pdb; pdb.set_trace() ### XXX BREAKPOINT
                                            age + height + weight)
