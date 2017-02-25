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


    def v_perp(self, basis_v):
        return self.subtract(self.v_parallel(basis_v))


    def v_parallel(self, basis_v):
        return (basis_v.normalized()).scale(self.dot(basis_v.normalized()))


    def cross_product(self, vector):
        v = self.coordinates
        w = vector.coordinates

        assert(len(v) == 3 and len(w) == 3)

        return Vector([v[1] * w[2] - w[1] * v[2],
                -(v[0] * w[2] - w[0] * v[2]),
                v[0] * w[1] - w[0] * v[1]])


    def parallelogram(self, vector):
        return self.cross_product(vector).magnitude()

    def triangle(self, vector):
        return Decimal(0.5) * self.parallelogram(vector)
