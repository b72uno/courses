# fibonacci : n -> n
# to produce nth fibonacci number
def fibonacci(n):
    if n == 0:
        return 0
    else:
        i = 2
        fib = [0,1]
        while i <= n:
            fib.append(fib[-1]+fib[-2])
            i = i + 1
        return fib[n]

def recursive_fibonacci(n):
    if n < 2:
        return n
    else:
        return (recursive_fibonacci(n-1)+recursive_fibonacci(n-2))
