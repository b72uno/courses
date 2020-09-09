import math


def stdev(selection, compensation=0):
    """compensation - enter 1 in case you dont have data
    about all population"""
    x = selection
    n = len(x)
    temp = 0
    x[0] = float(x[0])
    avg = sum(x) / n
    for i in range(0,len(x)):
        temp += (avg - x[i])**2
    dispersion = temp / (n - compensation)
    stdev = math.sqrt(dispersion)
    print("variance:", dispersion)
    print("avg:", avg, "stdev:", stdev)
    return

def nndzscore(sample, mean, stdev):
    """enter sample, mean and standard deviation as csv-s"""
    answer = (sample - mean) / stdev
    print(answer)
    return

def ndprob(sample, mean, stdev):
    """enter sample, mean and standard deviation as csv-s"""
    z1 = 0.68
    z2 = 0.97
    z3 = 0.995
    """ to be continued ...."""
    return






