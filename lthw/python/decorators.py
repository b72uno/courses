# A decorator is a function that expects another function as an input


def my_shiny_new_decorator(a_function_to_decorate):

    # Inside, the decorator defines a function on the fly
    # This f is going to be wrapped around the original function
    # so it can execute code before and after it
    def the_wrapper_around_the_original_function():

        # Put here code to execute BEFORE
        print "Before the function runs"

        # Call the function here (using parentheses)
        a_function_to_decorate()

        # Put the code to execute AFTER
        # the function is called
        print "After the function runs"

    # At this point a_function_to_decorate() HAS NEVER BEEN CALLED
    # We return the wrapper function we've just created
    # The wrapper contains the function and the code to execute before
    # and after. Its ready to use
    return the_wrapper_around_the_original_function


def a_stand_alone_function():
    print "I am a stand alone function, dont you dare to modify me"


@my_shiny_new_decorator
def another_stand_alone_function():
    print "Leave me alone"

a_stand_alone_function = my_shiny_new_decorator(a_stand_alone_function)
a_stand_alone_function()

# The 2nd definition is the same as first, just the syntax different
another_stand_alone_function()

print "-------- Passing args to the decorated function --------"

# Its not black magic, have to let the wrapper pass the argument


def a_decorator_passing_arguments(function_to_decorate):
    def a_wrapper_accepting_arguments(arg1, arg2):
        print "I got args! Look:", arg1, arg2
        function_to_decorate(arg1, arg2)
    return a_wrapper_accepting_arguments

# Since when you are calling the functions returned by the dec,
# you are calling the wrapper, passing args to the wrapper will let it pass
# them to the decorated function


@a_decorator_passing_arguments
def print_full_name(first_name, last_name):
    print "My name is", first_name, last_name

print_full_name("Peter", "Venkman")

print "-------- Method Friendly Decorators --------"

# Whats great with python is that methods and f are really the same, except
# methods expect their first parameter to be a reference to the current object
# (self). It means you can build a decorator for methods the same way, just
# remember to take in self consideration:


def method_friendly_decorator(method_to_decorate):
    def wrapper(self, lie):
        lie = lie - 3  # very friendly, decrease age even more :))
        return method_to_decorate(self, lie)
    return wrapper


class Lucy(object):

    def __init__(self):
        self.age = 32

    @method_friendly_decorator
    def sayYourAge(self, lie):
        print "I am %s, what did you think?" % (self.age + lie)
l = Lucy()
l.sayYourAge(-3)


print "-------- Passing arbitrary args --------"


def a_decorator_passing_arbitrary_arguments(function_to_decorate):
    # THe wrapper accepts any args
    def a_wrapper_accepting_arbitrary_arguments(*args, **kwargs):
        print "Do I have args?:"
        print args
        print kwargs
        # Then you unpack the arguments, here *args, *kwargs
        function_to_decorate(*args, **kwargs)
    return a_wrapper_accepting_arbitrary_arguments


@a_decorator_passing_arbitrary_arguments
def function_with_no_argument():
    print "Python is cool, no argument here."

function_with_no_argument()


@a_decorator_passing_arbitrary_arguments
def function_with_arguments(a, b, c):
    print a, b, c

function_with_arguments(1, 2, 3)


@a_decorator_passing_arbitrary_arguments
def function_with_named_arguments(a, b, c, platypus="Why not?"):
    print "Do %s, %s and %s like platypus? %s" % \
        (a, b, c, platypus)

function_with_named_arguments("Bill", "Linus", "Steve", platypus="Indeed")


class Mary(object):

    def __init__(self):
        self.age = 31

    @a_decorator_passing_arbitrary_arguments
    def sayYourAge(self, lie=-3):
        print "I am %s, what did you think?" % (self.age + lie)

m = Mary()
m.sayYourAge()

print "-------- Passing arguments to the decorator --------"

# Decorators are ORDINARY functions


def my_decorator(func):
    print "I am a ordinary function"

    def wrapper():
        print "I am function returned by the decorator"
        func()

    return wrapper

# Therefore you can call it without any "@"


def lazy_function():
    print "zzzzzzzzz"

decorate_function = my_decorator(lazy_function)
# outputs: I am a ordinary function

# When you are @my_decorator, you are telling Python to call the function
# 'labeled by the variable "my_decorator"' It is important, because the label
# you give can point directly to the decorator ... or not!


def decorator_maker():
    print "I make decorators! I am executed only once " +\
        "when you make me create a decorator."

    def my_decorator(func):

        print "I am a decorator! I am executed only when \
            you decorate a function!"

        def wrapped():
            print ("I am wrapper around the decorator function. "
                   "I am called when you call the decorated function. "
                   "As the wrapper, I return the RESULT of decorated function")
            return func()

        print "As the decorator, I return the wrapped function."

        return wrapped
    print "As a decorator maker, I return a decorator"
    return my_decorator

# Let's create a decorator. It's just a new function after all.
new_decorator = decorator_maker()
# Outputs
# I make decorators! I am executed only once: when you make me create a
# decorator
# As a decorator maker, I return a decorator

# Then we decorate the function


def decorated_function():
    print "I am the decorated function."

decorated_function = new_decorator(decorated_function)
# outputs:
# I am a decorator! I am executed only when you decorate a function.
# As the decorator, I return the wrapped function.

# Let's call the function:
decorated_function()
# outputs:
# I am the wrapper around the decorated function. I am called when you call the
# decorated function. As the wrapper, I return the RESULT of the decorated
# function.
# I am the decorated function.

# No surprise, but lets do the same thing, but skipping intermediate variables.


def decorated_function():
    print "I am the decorated function"

decorated_function = decorator_maker()(decorated_function)
# outputs:
# I make decorators! I am executed only once: when you make me create a
# decorator.
# As a decorator maker, I return a decorator.
# I am a decorator! I am executed only when you decorate a function.
# As the decorator I return the wrapped function.

# Finally
decorated_function()
# outputs:
# I am the wrapper around the decorated function. I am called when you called
# the decorated function. As the wrapper, I return the RESULT of the decorated
# function
# I am the decorated function

# Lets do it AGAIN, even shorter


@decorator_maker()
def decorated_function():
    print "I am the decorated function."

# Outputs everything as before just not the last step
# which is
decorated_function()
# Which does what expected.
# We used a function call with the @ syntax here. What? Better sleep on it.
# If we can use functions to generate decorator on the fly, we can pass
# arguments to that function too, right?


def decorator_maker_with_arguments(decorator_arg1, decorator_arg2):

    print "I make decorators! And I accept arguments:", decorator_arg1, decorator_arg2

    def my_decorator(func):
        # The ability to pass arguments here is a gift from closures.
        # If you are not comfortable with closures, you can assume it's ok,
        # or read: http://stackoverflow.com/questions/13857/can-you-explain-closures-as-they-relate-to-python
        print "I am the decorator. Somehow you passed me arguments:", decorator_arg1, decorator_arg2

        # Don't confuse decorator arguments and function arguments!
        def wrapped(function_arg1, function_arg2) :
            print ("I am the wrapper around the decorated function.\n"
                  "I can access all the variables\n"
                  "\t- from the decorator: {0} {1}\n"
                  "\t- from the function call: {2} {3}\n"
                  "Then I can pass them to the decorated function"
                  .format(decorator_arg1, decorator_arg2,
                          function_arg1, function_arg2))
            return func(function_arg1, function_arg2)

        return wrapped

    return my_decorator


# @decorator_maker_with_arguments("Leonard", "Sheldon")
# def decorated_function_with_arguments(function_arg1, function_arg2):
#     print ("I am the decorated function and only knows about my args :{0}"
#            " {1}".format(function_arg1, function_arg2))

# decorated_function_with_arguments("Rajesh", "Howard")
#outputs:
#I make decorators! And I accept arguments: Leonard Sheldon
#I am the decorator. Somehow you passed me arguments: Leonard Sheldon
#I am the wrapper around the decorated function.
#I can access all the variables
#   - from the decorator: Leonard Sheldon
#   - from the function call: Rajesh Howard
#Then I can pass them to the decorated function
#I am the decorated function and only knows about my arguments: Rajesh Howard


# Arguments can be set as variable
c1 = "Penny"
c2 = "Leslie"


@decorator_maker_with_arguments("Leonard", c1)
def decorated_function_with_arguments(function_arg1, function_arg2):
    print("I am the decorated function and only knows about my arguments:"
          "{0} {1}".format(function_arg1, function_arg2))

decorated_function_with_arguments(c2, "Howard")

# REMEMBER: Decorators are called ONLY ONCE. Just when Python imports the
# script. You can not dynamically set the arguments afterwards. When you do
# import x, the function is already decorated, so you can't change anything.


print "-------- A decorator to decorate a decorator --------"


def decorator_with_args(decorator_to_enhance):
    """
    This function is supposed to be used as a decorator. It must decorate
    another function, that is inteded to be used as a decorator
    Take a cup of coffee.
    It will allow any decorator to accept arbitrary number of arguments,
    saving you the headache to remember how to do that every time.
    """

    # We use the same trick we did to pass args
    def decorator_maker(*args, **kwargs):

        # We create on the fly a decorator that accepts only a function
        # bit keeps the passed arguments from the maker
        def decorator_wrapper(func):

            # We return the result of the original decorator, which, after all,
            # IS JUST AN ORDINARY FUNCTION (which returns a function)
            # Only pitfall: the decorator must have this specific signature or
            # it wont work.
            return decorator_to_enhance(func, *args, **kwargs)

        return decorator_wrapper

    return decorator_maker

# Above can be used as follows:
# Create the function you will use as a decorator. Then stick a decorator on it
# Don't forget, the signature is decorator(func, *args, **kwargs)


@decorator_with_args
def decorated_decorator(func, *args, **kwargs):
    def wrapper(function_arg1, function_arg2):
        print "Decorated with", args, kwargs
        return func(function_arg1, function_arg2)
    return wrapper

# Then you decorate the functions you wish with your brand new decorated
# decorator
@decorated_decorator(42, 404, 1024)
def decorated_function(function_arg1, function_arg2):
    print "Hello", function_arg1, function_arg2

decorated_function("Universe and", "everything")

# THINGS TO KEEP IN MIND:
# They are new as of Python 2.4 so be sure thats what your code is running on.
# Decorators slow down the function call. Keep that in mind.
# You can not un-decorate a function. There are hacks to create decorators that
# can be removed but nobody uses them. So once a function is decorated, it's
# done. For all the code.
# Decorators wrap functions, which can make them hard to debug.


# Some practical uses
def benchmark(func):
    """
    A decorator that prints the time a function takes to execute
    """
    import time

    def wrapper(*args, **kwargs):
        t = time.clock()
        res = func(*args, **kwargs)
        print func.__name__, time.clock() - t
        return res
    return wrapper


def logging(func):
    """
    A decorator that logs the activity of the script
    (it actually just prints it, but it could be logging!)
    """
    def wrapper(*args, **kwargs):
        res = func(*args, **kwargs)
        print func.__name__, args, kwargs
        return res
    return wrapper


def counter(func):
    """
    A decorator that counts and prints the number of times a function has been
    executed
    """
    def wrapper(*args, **kwargs):
        wrapper.count = wrapper.count + 1
        res = func(*args, **kwargs)
        print "{0} has been used: {1}x".format(func.__name__, wrapper.count)
        return res
    wrapper.count = 0
    return wrapper


@counter
@benchmark
@logging
def reverse_string(string):
    return str(reversed(string))

print reverse_string("Able was I ere I saw Elba")
print reverse_string("A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!")


@counter
@benchmark
@logging
def get_random_futurama_quote():
    import httplib
    conn = httplib.HTTPConnection("slashdot.org:80")
    conn.request("HEAD", "/index.html")
    for key, value in conn.getresponse().getheaders():
        if key.startswith("x-b") or key.startswith("x-f"):
            return value
    return "No, I'm ... doesn't!"

print get_random_futurama_quote()
print get_random_futurama_quote()

