def break_words(stuff):
    """This function will break up words for us. """
    words = stuff.split('')
    return words

def sort_words(words):
    """Sorts the words"""
    return sorted(words)

def print_first_words(words):
    """Prints the first word after popping it off"""
    word = words.pop(0)
    print word


def print_last_word(words):
    """Prints the last word pop"""
    print words.pop(-1)

def sort_sentence(sentence):
    """Takes in a full sentence, returns sorted words"""
    words = break_words(sentence)
    return sort_words(words)

def print_first_and_last(sentence):
    """Prints first and last words of sentence"""
    words = break_words(sentence)


    # screw this, im way past this
