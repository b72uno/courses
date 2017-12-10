from decimal import Decimal, getcontext

from vector import Vector

getcontext().prec = 30

class Plane(object):

    NO_NONZERO_ELTS_FOUND_MSG = 'No nonzero elements found'

    def __init__(self, normal_vector=None, constant_term=None):
        self.dimension = 3

        if not normal_vector:
            all_zeros = ['0'] * self.dimension
            normal_vector = Vector(all_zeros)

        self.normal_vector = normal_vector

        if not constant_term:
            constant_term = Decimal('0')
        self.constant_term = Decimal(constant_term)

        self.set_basepoint()

    def set_basepoint(self):
        try:
            n = self.normal_vector.coordinates
            c = self.constant_term

            basepoint_coords = ['0'] * self.dimension

            initial_index = Plane.first_nonzero_index(n)
            initial_coefficient = Decimal(n[initial_index])

            basepoint_coords[initial_index] = c / initial_coefficient
            self.basepoint = Vector(basepoint_coords)

        except Exception as e:
            if str(e) == Plane.NO_NONZERO_ELTS_FOUND_MSG:
                self.basepoint = None
            else:
                raise e

    def __str__(self):

        num_decimal_places = 3

        def write_coefficient(coefficient, is_initial_term=False):
            coefficient = round(coefficient, num_decimal_places)
            if coefficient % 1 == 0:
                coefficient = int(coefficient)

            output = ''

            if coefficient < 0:
                output += '-'
            if coefficient > 0 and not is_initial_term:
                output += '+'

            if not is_initial_term:
                output += ' '

            if abs(coefficient) != 1:
                output += '{}'.format(abs(coefficient))

            return output

        n = self.normal_vector.coordinates

        try:
            initial_index = Plane.first_nonzero_index(n)
            terms = [write_coefficient(n[i], is_initial_term=(i==initial_index)) + \
                     'x_{}'.format(i+1) for i in range(self.dimension) if \
                     round(n[i], num_decimal_places) != 0]
            output = ' '.join(terms)

        except Exception as e:
            if str(e) == self.NO_NONZERO_ELTS_FOUND_MSG:
                output = '0'
            else:
                raise e

        constant = round(self.constant_term, num_decimal_places)
        if constant % 1 == 0:
            constant = int(constant)
        output += ' = {}'.format(constant)

        return output

    def __eq__(self, plane):
        if self.normal_vector.is_zero():
            if not plane.normal_vector.is_zero():
                return False
            else:
                diff = self.constant_term - plane.constant_term
                return MyDecimal(diff).is_near_zero()

        if plane.normal_vector.is_zero():
            return False

        if not self.is_parallel_to(plane):
            return False

        # get vector connecting both basepoints
        p1 = self.basepoint
        p2 = self.basepoint

        # find a line between two basepoints
        connecting_vector = p1.subtract(p2)

        n = self.normal_vector

        # no need to check both, as they are parallel
        return connecting_vector.is_orthogonal_to(n)


    @staticmethod
    def first_nonzero_index(iterable):
        for k, item in enumerate(iterable):
            if not MyDecimal(item).is_near_zero():
                return k
        raise Exception(Plane.NO_NONZERO_ELTS_FOUND_MSG)

    def is_parallel_to(self, plane):
        v1 = self.normal_vector
        v2 = plane.normal_vector

        return v1.is_parallel_to(v2)

    def intersection_with(self, plane):
        if not self.is_parallel_to(plane):
            try:
                p1 = self
                p2 = plane
                u = p1.normal_vector.coordinates
                v = p2.normal_vector.coordinates

                k1 = p1.constant_term
                k2 = p2.constant_term

                # Cross product
                s1 = u[2]*v[3] - u[3]*v[2]
                s2 = u[3]*v[1] - u[1]*v[3]
                s3 = u[1]*v[2] - u[2]*v[1]

                return Vector([s1, s2, s3])

            except ZeroDivisionError as e:
                if self == plane:
                    return self
                else:
                    return None
        else:
            return False

class MyDecimal(Decimal):
    def is_near_zero(self, eps=1e-10):
        return abs(self) < eps
