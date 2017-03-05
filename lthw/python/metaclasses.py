
print "* * * * * * * * * *  Classes as objects * * * * * * * * * * "

# Before understanding metaclasses, one needs to master classes in Python
# In most languages, classes are just a piece of code that describe how to
# produce an object.


class ObjectCreator(object):
    pass

my_object = ObjectCreator()
print my_object

# But in python classes are objects too. Yes, objects.
# As soon as you use the keyword class, Python executes it and creates an
# OBJECT. The instruction class ObjectCreator(object): pass
# creates in memory an object with the name ObjectCreator

# This object (the class) is itself capable of creating objects (the
# instances), and this is why it's a class.

# But because it's an object, you can:
# - assign it to a variable
# - you can copy it
# - you can add attributes to it
# - you can pass it as a function parameter


print ObjectCreator  # you can print a class because it's an object


def echo(o):
    print o

echo(ObjectCreator)  # you can pass a class as a parameter

print hasattr(ObjectCreator, 'new_attribute')
# >> False

ObjectCreator.new_attribute = 'foo'  # you can add attributes to a class

print hasattr(ObjectCreator, 'new_attribute')
# >> True

ObjectCreatorMirror = ObjectCreator  # you can assign a class to a variable
print ObjectCreatorMirror.new_attribute
# >> foo

print ObjectCreatorMirror()

print "* * * * * * * * * *  Creating classes dynamically  * * * * * * * * * * "

# Since classes are objects you can create them on fly like any object


# First you can create a class in a function using class
def choose_class(name):
    if name == 'foo':
        class Foo(object):
            pass
        return Foo  # return the class, not an instance
    else:
        class Bar(object):
            pass
        return Bar

MyClass = choose_class('foo')
print MyClass  # the function returns a class, not an instance
print MyClass()  # you can create an object from this class


# But it's not so dynamic, since you still have to write the whole class
# yourself.

# Since classes are objects, they must be generated by something.

# WHen you use the class keyword, Python creates this object automatically. But
# as with most things in Python, it gives you a way to do it manually.

# Remember the function type? The good old function lets you know what type an
# objects is.
print type(1)
# >> <type 'int'>

print type("1")
# >> <type 'str'>

print type(ObjectCreator)
# >> <type 'type'>

print type(ObjectCreator())
# >> <class '__main__.ObjectCreator'>

# Type has a completely different ability, it can also create classes on the
# fly. Type can take the description of a class as params and return a class.
# This is for some backward compatibility reasons.

# type works this way:
# type(name of the class,
#      tuple of the parent class (for inheritance, can be empty),
#      dictionary containing attributes names and values)

# e.g. class MyShinyClass(object): pass can be created manually this way:
MyShinyClass = type('MyShinyClass', (), {})  # returns a class object
print MyShinyClass
# >> <class '__main__.MyShinyClass'>
print MyShinyClass()  # create an instance with the class
# >> <__main__.MyShinyClass object at 0xxxxxx>

# type accepts a dictionary to define the attributes of the class. So:
# class Foo(object):
#     bar = True
# can be translated to:
Foo = type('Foo', (), {'bar': True})
# and used as a normal class
print Foo
# <class '__main__.Foo'>
print Foo.bar
# True
f = Foo()
print f
# <__main__.Foo object at 0x8a9b84c>
print f.bar
# True

# And of course you can inherit from it so
# class FooChild(Foo):
#     pass
# would be:
FooChild = type('FooChild', (Foo,), {})
print FooChild
# >> <class '__main__.FooChild'>
print FooChild.bar  # bar is inherited from Foo
# >> True


# Eventually you will want to add methods to your class. Just defina a function
# with the proper signature and assign it as an attribute.
def echo_bar(self):
    print self.bar

FooChild = type('FooChild', (Foo,), {'echo_bar': echo_bar})
print hasattr(Foo, 'echo_bar')  # False
print hasattr(FooChild, 'echo_bar')  # True

my_foo = FooChild()
my_foo.echo_bar()  # >> True

# In Python, classes are objects, and you can create a class on the fly
# dynamically. This is what python does when you use keyword class, and it does
# so by using a metaclass.

print "* * * * * * * * * *  What are metaclasses * * * * * * * * * * "

# Metaclasses are the "stuff" that creates classes
# You can picture classes' classes (aka metaclasses) this way:
# MyClass = MetaClass()
# MyObject = MyClass()

# Before we've seen that type lets one do something like this:
# MyClass = type('MyClass', (), {})

# It is because the function type is in fact a metaclass. type is the metaclass
# Python uses to create all classes behind the scenes.

# Why its in lowercase, then? Well, it's probably a matter of consistency with
# str, the class that creates strings objects and int - the class that creates
# integer objects. type is just eh class that creates class objects.

# You see that by checking the __class__ attribute.

# Everything, and I mean everything, is an object in Python. This in cludes
# ints, strings, functions and classes. All of them are objects. And all of
# them have been created from a class.
age = 35
print age.__class__
# >> <type 'int'>

name = 'bob'
print name.__class__
# >> <type 'str'>


def foo():
    pass
print foo.__class__
# >> <type 'function'>


class Bar(object):
    pass
b = Bar()
print b.__class__
# >> <class '__main__.Bar'>

# Now what is the class of any class?
print age.__class__.__class__
print foo.__class__.__class__
print b.__class__.__class__
# >> <type 'type'>
# So, a metaclass is just the stuff that creates class objects.
# You can call it a 'class factory' if you wish
# type is the built-in metaclass Python uses, but of course, you can create
# your own metaclass.

# print "* * * * * * * * * *  The __metaclass__ attribute * * * * * * * * * * "

# You can add a __metaclass__ attribute when you write a class:
# class Foo(object):
#     __metaclass__ = something...
#     [...]

# If you do so, Python will use the metaclass to create the class Foo.
# Careful, it's tricky
# You write class Foo(object) first, but the class object Foo is not created in
# memory yet. Python will look for __metaclass__ in the class definition. If it
# finds it, it will use it to create the object class Foo. If it doesn't, it
# will use type to create the class.

# So when you do :
# class Foo(Bar):
#     pass

# Python does the following:

# Is there a __metaclass__ attribute in Foo?

# If yes, create in memory a class object ( I said a class objecy, stay with me
# here), with the name Foo by using what is in __metaclass__

# If python can't find __metaclass__, it will look for a metaclass in Bar (the
# parent class), and try to do the same.

# If python can't find __metaclass__ in any parent, it will look for a
# __metaclass__ at the MODULE level, and try to do the same

# Then if it can't find any __metaclass__ at all, it will use type to create
# the class object.

# Now the big question is, what can you put in __metaclass__??

# The answer - something that can create a class. And what is that? type, or
# anything that subclasses or uses it.


print "* * * * * * * * * *  Custom metaclasses * * * * * * * * * * "

# The main purpose of a metaclass is to change the class automatically, when it
# is created. You usually do this for APIs, where you want to create classes
# matching the current context.

# Imagine a stupid example, where you decide that all classes in your module
# should have their attributes written in uppercase. There are several ways to
# do this, but one way is to set __metaclass__ at the module level.

# This way, all classes of this module will be created using this metaclass,
# and we just have to tell the metaclass to turn all attributes to uppercase.

# Luckily, __metaclass__ can actually be any callable. It doesn't need to be a
# formal class (I know, something with 'class' in its name doesn't need to be a
# class, go figure... but it's helpful)

# Simple example, using a function:


# the metaclass will automatically get passed the same argument
def upper_attr(future_class_name, future_class_parents, future_class_attr):
    """
    Return a class object, with the list of its attribute turned
    into uppercase
    """

    # pick up any attribute that doesn't start with '__'
    attrs = ((name, value) for name, value in future_class_attr.items()
             if not name.startswith('__'))

    # turn them into uppercase
    uppercase_attr = dict((name.upper(), value) for name, value in attrs)

    # let 'type' do the class creation
    return type(future_class_name, future_class_parents, uppercase_attr)


__metaclass__ = upper_attr  # this will affect all classes in the module


class Foo():  # global __metaclass__ won't work with "object" though
    # but we can define __metaclass__ here instead to affect only this class
    # and this will work with object children
    bar = 'bip'

print hasattr(Foo, 'bar')
# >> False
print hasattr(Foo, 'BAR')
# True

f = Foo()
print f.BAR


# Now let's do exactly the same but using a real class for a metaclass

# remember that 'type' is actually a class like 'str' and 'int'
# so you can inherit from it
class UpperAttrMetaclass(type):
    # __new__ is the method called before __init__
    # it's the method that creates the object and returns it
    # while __init__ just initializes the object passed as parameter
    # you rarely use __new__, except when you want to control how the object
    # is created.
    # here the created object is the class, and we want to customize it
    # so we override __new__
    # you can do some stuff in __init__ too if you wish
    # some advanced use involves overriding __call__ as well, but we won't
    # see this
    def __new__(upperattr_metaclass, future_class_name,
                future_class_parents, future_class_attr):

        # pick up any attribute that doesn't start with '__'
        attrs = ((name, value) for name, value in future_class_attr.items()
                 if not name.startswith('__'))

        # turn them into uppercase
        uppercase_attr = dict((name.upper(), value) for name, value in attrs)

        # let 'type' do the class creation
        # return type(future_class_name, future_class_parents, uppercase_attr)
        # but this is not really OOP. We call type directly and we don't
        # override the parent __new__. Let's do it.
        return type.__new__(upperattr_metaclass, future_class_name,
                            future_class_parents, uppercase_attr)

# Notice the extra argument upperattr_metaclass. There is nothing
# special about it: a method always receives the current instance as
# first parameter. Just like you have self for ordinary methods.


# Of course, the names used here are long for the sake of clarity, but like
# for self, all the arguments have convential names. So a real production
# metaclass would look like:

class UpperAttrMetaclass(type):

    def __new__(cls, name, bases, dct):

        attrs = ((name, value) for name, value in dct.items() if not name.startswith('__'))
        uppercase_attr = dict((name.upper(), value) for name, value in attrs)

        return type.__new__(cls, name, bases, uppercase_attr)


# We can make it even cleaner by using super, which will ease inheritance
# (because yes, you can have metaclasses, inheriting from metaclasses,
# inheriting from type

class UpperAttrMetaclass(type):

    def __new__(cls, name, bases, dct):

        attrs = ((name, value) for name, value in dct.items() if not
                 name.startswith('__'))
        uppercase_attr = dict((name.upper(), value) for name, value in attrs)

        return super(UpperAttrMetaclass, cls).__new__(cls, name, bases,
                                                      uppercase_attr)


# That's it, there is really nothing more about metaclasses.
# The reason behind the complexity of the code using metaclasses is not because
# of metaclasses, it's because you usually use metaclasses to do twisted stuff
# relying on introspection, manipulating inheritance, vars such as __dict__,
# etc.
#
# Indeed, metaclasses are especially useful to do black magic, and therefore
# complicated stuff. But by themselves, they are simple:
#
# intercept a class creation
# modify the class
# return the modified class


# Why would you use metaclasses classes instead of functions?  Since
# __metaclass__ can accept any callable, why would you use a class since it's
# obviously more complicated?
#
# There are several reasons to do so:
#
# The intention is clear. When you read UpperAttrMetaclass(type), you know
# what's going to follow You can use OOP. Metaclass can inherit from metaclass,
# override parent methods. Metaclasses can even use metaclasses.  You can
# structure your code better. You never use metaclasses for something as
# trivial as the above example. It's usually for something complicated. Having
# the ability to make several methods and group them in one class is very
# useful to make the code easier to read.  You can hook on __new__, __init__
# and __call__. Which will allow you to do different stuff. Even if usually you
# can do it all in __new__, some people are just more comfortable using
# __init__.  These are called metaclasses, damn it! It must mean something!
# Why the hell would you use metaclasses?  Now the big question. Why would you
# use some obscure error prone feature?
#
# Well, usually you don't.
# The main use case for metaclass is creating an API. A typical example of this
# is the Django ORM
#
# Everything is an object in Python, and they are all either instances of
# classes or instances of metaclasses.
#
# Except for type.
#
# type is actually its own metaclass. This is not something you could reproduce
# in pure Python, and is done by cheating a little bit at the implementation
# level.
#
# Secondly, metaclasses are complicated. You may not want to use them for very
# simple class alterations. You can change classes by using two different
# techniques:
#
# monkey patching class decorators 99% of the time you need class alteration,
# you are better off using these.
#
# But 99% of the time, you don't need class alteration at all :-)
