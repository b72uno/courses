import math
from decimal import Decimal, getcontext

getcontext().prec = 30

def isanumber(a):
    bool_a = True
    try:
        bool_a = float(repr(a))
    except:
        bool_a = False
    return bool_a

class Vector(object):
    def __init__(self, coordinates):
        try:
            if not coordinates:
                raise ValueError
            self.coordinates = tuple([Decimal(x) for x in coordinates])
            self.dimension = len(self.coordinates)

        except ValueError:
            raise ValueError('The coordinates must be nonempty')

        except TypeError:
            raise TypeError('The coordinates must be an iterable')

    def __str__(self):
        return 'Vector: {}'.format(self.coordinates)

    def __eq__(self, other):
        return self.coordinates == other.coordinates


    @classmethod
    def sum(self, v):
        try:
            if not isinstance(v, self):
                raise ValueError
            return sum(v.coordinates)

        except ValueError:
            raise ValueError('The input must be a vector')


    @classmethod
    def average(self, v):
        try:
            if not isinstance(v, self):
                raise ValueError
            return self.sum(v) / Decimal(len(v.coordinates))

        except ValueError:
            raise ValueError('The input must be a vector')


    @classmethod
    def add(self, v1, v2):
        try:
            if not isinstance(v1, self) and isinstance(v2, self):
                raise ValueError
            return Vector([x + y for x,y in zip(v1.coordinates, v2.coordinates)])

        except ValueError:
            raise ValueError('Both inputs must be vectors')


    @classmethod
    def subtract(self, v1, v2):
        try:
            if not isinstance(v1, self) and isinstance(v2, self):
                raise ValueError
            return Vector([x - y for x,y in zip(v1.coordinates, v2.coordinates)])

        except ValueError:
            raise ValueError('Both inputs must be vectors')


    @classmethod
    def scale(self, v, s):
        try:
            if not isinstance(v, self) and isanumber(s):
                raise ValueError
            return Vector([x * Decimal(s) for x in v.coordinates])

        except ValueError:
            raise ValueError('Input must be a vector and a number (float/int)')


    @classmethod
    def magnitude(self, v):
        try:
            if not isinstance(v, self):
                raise ValueError

            return Decimal(math.sqrt(sum([x**2 for x in v.coordinates]))

        except ValueError:
            raise ValueError('Input must be a vector')


    @classmethod
    def normalize(self, v):
        try:
            return self.scale(v, Decimal('1.0')/self.magnitude(v))

        except ZeroDivisionError:
            raise Exception('Cannot normalize the zero vector')


    @classmethod
    def dot(self, v1, v2):
        try:
            if not isinstance(v1, self) and isinstance(v2, self):
                raise ValueError
            elif self.magnitude(v1) == 0 or self.magnitude(v2) == 0:
                return 0
            return sum([x * y for x,y in zip(v1.coordinates, v2.coordinates)])

        except ValueError:
            raise ValueError('Both inputs must be vectors')


    @classmethod
    def theta(self, v1, v2):
        try:
            v1 = self.normalize(v1)
            v2 = self.normalize(v2)
            return math.acos(self.dot(v1, v2) / self.magnitude(v1) * self.magnitude(v2))

        except ZeroDivisionError:
            raise Exception('Cannot ?? the zero vector')


    @classmethod
    def theta_deg(self, v1, v2):
        return math.degrees(self.theta(v1, v2))


    @classmethod
    def isparallel(self, v1, v2):
        if abs(math.cos(self.theta(v1, v2))) - 1 < 0.001:
            return True
        else:
            return False


    @classmethod
    def isorthogonal(self, v1, v2):
        if abs(self.dot(v1, v2)) - 0 < 0.001:
            return True
        else:
            return False


print(Vector.sum(Vector([1.12,2.13,3.14,4.15])))
print(Vector.average(Vector([1.12,2.13,3.14,4.15])))
print('--------------')
print(Vector.add(Vector([8.218, -9.341]), Vector([-1.129, 2.111])))
print(Vector.subtract(Vector([7.119, 8.215]), Vector([-8.223, 0.878])))
print(Vector.scale(Vector([1.671, -1.012, -0.318]), 7.41))
print('--------------')
print(Vector.magnitude(Vector([-0.221, 7.437])))
print(Vector.magnitude(Vector([8.813, -1.331, -6.247])))
print(Vector.normalize(Vector([5.581, -2.136])))
print(Vector.normalize(Vector([1.996, 3.108, -4.554])))
print('--------------')
print(Vector.dot(Vector([7.887, 4.138]), Vector([-8.802, 6.776])))
print(Vector.dot(Vector([-5.955, -4.904, -1.874]), Vector([-4.496, -8.755, 7.103])))
print(Vector.theta(Vector([3.183, -7.627]), Vector([-2.668, 5.319])))
print(Vector.theta_deg(Vector([7.35, 0.221, 5.188]), Vector([2.751, 8.259, 3.985])))
print('--------------')
print(Vector.isparallel(Vector([-7.579, -7.88]), Vector([22.737, 23.64])))
print(Vector.isorthagonal(Vector([-7.579, -7.88]), Vector([22.737, 23.64])))
print(Vector.isparallel(Vector([-2.029, 9.97, 4.172]), Vector([-9.231, -6.639, -7.245])))
print(Vector.isorthagonal(Vector([-2.029, 9.97, 4.172]), Vector([-9.231, -6.639, -7.245])))
print(Vector.isparallel(Vector([-2.328, -7.284, -1.214]), Vector([-1.821, 1.072, -2.94])))
print(Vector.isorthagonal(Vector([-2.328, -7.284, -1.214]), Vector([-1.821, 1.072, -2.94])))
print(Vector.isparallel(Vector([2.118, 4.827]), Vector([0, 0])))
print(Vector.isorthagonal(Vector([2.118, 4.827]), Vector([0, 0])))
