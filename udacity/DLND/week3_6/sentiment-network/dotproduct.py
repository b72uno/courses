import numpy as np

m1 = np.array([[1, 0, 3],
               [4, 0, 6],
               [1, 8, 9]])

m2 = np.array([[1, 2],
               [3, 4],
               [5, 6]])

m3 = np.dot(m1,m2)
print(m3)

m4 = np.zeros((3,2))

def dot2(m1, m2):
    for i, row in enumerate(m1):
        for j, column in enumerate(m2.T):
            t =
            for x in row:
                for y in column:
                    t.append(x*y)

            sum([x*y for x,y in zip(row,column)])

            m4[i][j] += t
            print("added {} at position {}".format(t, (i,j)))
dot2(m1,m2)

print(m4)

