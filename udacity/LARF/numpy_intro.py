import numpy as np

a = np.array([0, 1, 2, 3]) # a vector
b = np.array([4, 5, 6, 7]) # another vector
c = np.array([[0, 1, 2, 3],
              [4, 5, 6, 7]]) # a matrix

d = np.zeros((2,4)) # 2x4 matrix of zeroes
e = np.random.rand(2,5) # random 2x5 matrix
# with all numbers between 0 and 1

print( a )
print( b )
print( c )
print( d )
print( e )

print(a * 0.1) # multiplies every number in matrix 'a' by 0.1
print(c * 0.2) # multiplies every number in matrix 'c' by 0.2
print(a * b) # multiplies elementwise between a and b (columns paired up)
print(a * b * 0.2) # elementwise multiplication then multiplied by 0.2
print(a * c) # since 'c' has the same number of columns as 'a', this performs elementwise multiplication on every row of the matrix 'c'

# print(a * e) # since a and e dont have the same number of columns, this would throw a ValueError

a = np.zeros((1,4)) # vector of length 4
b = np.zeros((4,3)) # matrix with 4 rows and 3 columns

c = a.dot(b)
print(c.shape) # outputs (1,3)

a = np.zeros((2,4))
b = np.zeros((4,3))

c = a.dot(b)
print(c.shape) # outputs (2,3)

e = np.zeros((2,1)) # matrix with 2 rows and 1 column
f = np.zeros((1,3)) # matrix with 1 row and 3 columns
g = e.dot(f)
print(g.shape) # outputs (2,3)


h = np.zeros((5,4)).T # ".T" transposes the matrix - flips the rows and columns
i = np.zeros((5,6))
j = h.dot(i)
print(j.shape) # outputs (4,6)
