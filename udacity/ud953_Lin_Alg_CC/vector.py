import math

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
            self.coordinates = tuple(coordinates)
            self.dimension = len(coordinates)

        except ValueError:
            raise ValueError('The coordinates must be nonempty')

        except TypeError:
            raise TypeError('The coordinates must be an iterable')

    def __str__(self):
        return 'Vector: {}'.format(self.coordinates)

    def __eq__(self, other):
        return self.coordinates == other.coordinates

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
            return Vector([x * s for x in v.coordinates])

        except ValueError:
            raise ValueError('Input must be a vector and a number (float/int)')

    @classmethod
    def magnitude(self, v):
        try:
            if not isinstance(v, self):
                raise ValueError
            
            return math.sqrt(sum([x**2 for x in v.coordinates]))

        except ValueError:
            raise ValueError('Input must be a vector')

    @classmethod
    def normalize(self, v):
        try:
            return self.scale(v, 1/self.magnitude(v))

        except ZeroDivisionError:
            raise Exception('Cannot normalize the zero vector')


print(Vector.add(Vector([8.218, -9.341]), Vector([-1.129, 2.111])))
print(Vector.subtract(Vector([7.119, 8.215]), Vector([-8.223, 0.878])))
print(Vector.scale(Vector([1.671, -1.012, -0.318]), 7.41))
print('--------------')
print(Vector.magnitude(Vector([-0.221, 7.437])))
print(Vector.magnitude(Vector([8.813, -1.331, -6.247])))
print(Vector.normalize(Vector([5.581, -2.136])))
print(Vector.normalize(Vector([1.996, 3.108, -4.554])))
print('--------------')
