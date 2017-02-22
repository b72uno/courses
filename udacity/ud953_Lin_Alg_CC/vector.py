import math
from decimal import Decimal, getcontext

getcontext().prec = 30

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

    CANNOT_NORMALIZE_ZERO_VECTOR_MSG = 'Cannot normalize Zero vector'

    def sum(self):
        return sum(self.coordinates)

    def average(self):
        return self.sum() / Decimal(len(self.coordinates))

    def add(self, v):
        return Vector([x + y for x,y in zip(self.coordinates, v.coordinates)])


    def subtract(self, v):
        return Vector([x - y for x,y in zip(self.coordinates, v.coordinates)])


    def scale(self, s):
        return Vector([x * Decimal(s) for x in self.coordinates])


    def magnitude(self):
        return Decimal(math.sqrt(sum([x**2 for x in self.coordinates])))


    def normalized(self):
        try:
            magnitude = self.magnitude()
            return self.scale(Decimal('1.0')/magnitude)
        except ZeroDivisionError:
            raise Exception(self.CANNOT_NORMALIZE_ZERO_VECTOR_MSG)


    def dot(self, v):
        return sum([x * y for x,y in zip(self.coordinates, v.coordinates)])


    def theta(self, v, in_degrees=False):
        try:
            u1 = self.normalized()
            u2 = v.normalized()
            dot = u1.dot(u2)
            if abs(abs(dot) - 1) < 1e-10:
                if dot < 0:
                    angle_in_rad = math.acos(-1)
                else:
                    angle_in_rad = math.acos(1)
            else:
                angle_in_rad = math.acos(u1.dot(u2))

            if in_degrees:
                degrees_per_rad = 180. / math.pi
                return angle_in_rad * degrees_per_rad
            else:
                return angle_in_rad

        except Exception as e:
            if str(e) == self.CANNOT_NORMALIZE_ZERO_VECTOR_MSG:
                raise Exception('Cannot compute an angle with the zero vector')
            else:
                raise e

    def is_zero(self, tolerance=1e-10):
        return self.magnitude() < tolerance

    def is_parallel_to(self, v):
        return (self.is_zero() or v.is_zero() or self.theta(v) == 0 or self.theta(v) == math.pi)

    def is_orthogonal_to(self, v, tolerance=1e-10):
        return abs(self.dot(v))  < tolerance



print(Vector([1.12,2.13,3.14,4.15]).sum())
print(Vector([1.12,2.13,3.14,4.15]).average())
print('--------------')
print(Vector([8.218, -9.341]).add(Vector([-1.129, 2.111])))
print(Vector([7.119, 8.215]).subtract(Vector([-8.223, 0.878])))
print(Vector([1.671, -1.012, -0.318]).scale(7.41))
print('--------------')
print(Vector([-0.221, 7.437]).magnitude())
print(Vector([8.813, -1.331, -6.247]).magnitude())
print(Vector([5.581, -2.136]).normalized())
print(Vector([1.996, 3.108, -4.554]).normalized())
print('--------------')
print(Vector([7.887, 4.138]).dot(Vector([-8.802, 6.776])))
print(Vector([-5.955, -4.904, -1.874]).dot(Vector([-4.496, -8.755, 7.103])))
print(Vector([3.183, -7.627]).theta(Vector([-2.668, 5.319]), in_degrees=False))
print(Vector([7.35, 0.221, 5.188]).theta(Vector([2.751, 8.259, 3.985]), in_degrees=True))
print('--------------')
print(Vector([-7.579, -7.88]).is_parallel_to(Vector([22.737, 23.64])))
print(Vector([-7.579, -7.88]).is_orthogonal_to(Vector([22.737, 23.64])))
print(Vector([-2.029, 9.97, 4.172]).is_parallel_to(Vector([-9.231, -6.639, -7.245])))
print(Vector([-2.029, 9.97, 4.172]).is_orthogonal_to(Vector([-9.231, -6.639, -7.245])))
print(Vector([-2.328, -7.284, -1.214]).is_parallel_to(Vector([-1.821, 1.072, -2.94])))
print(Vector([-2.328, -7.284, -1.214]).is_orthogonal_to(Vector([-1.821, 1.072, -2.94])))
print(Vector([2.118, 4.827]).is_parallel_to(Vector([0, 0])))
print(Vector([2.118, 4.827]).is_orthogonal_to(Vector([0, 0])))
print('--------------')
