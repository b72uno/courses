from decimal import Decimal, getcontext

from vector import Vector

getcontext().prec = 30


class Line(object):

    NO_NONZERO_ELTS_FOUND_MSG = 'No nonzero elements found'

    def __init__(self, normal_vector=None, constant_term=None):
        self.dimension = 2

        if not normal_vector:
            all_zeros = ['0'] * self.dimension
            normal_vector = Vector(all_zeros)
        self.normal_vector = Vector(normal_vector)

        if not constant_term:
            constant_term = Decimal('0')
        self.constant_term = Decimal(constant_term)

        self.set_basepoint()

    def is_parallel_to(self, line):
        v1 = self.normal_vector
        v2 = line.normal_vector

        return v1.is_parallel_to(v2)

    def set_basepoint(self):
        try:
            n = self.normal_vector.coordinates
            c = self.constant_term
            basepoint_coords = ['0'] * self.dimension

            initial_index = Line.first_nonzero_index(n)
            initial_coefficient = n[initial_index]

            # Ax + By = k
            # if B =/= 0, take x = 0, y = k/B, baseoint is (0, k/B)
            # if A =/= 0, take y = 0, x = k/A, basepoint is (k/A, 0)
            basepoint_coords[initial_index] = c / Decimal(initial_coefficient)
            self.basepoint = Vector(basepoint_coords)

        except Exception as e:
            if str(e) == Line.NO_NONZERO_ELTS_FOUND_MSG:
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
            initial_index = Line.first_nonzero_index(n)
            terms = [write_coefficient(n[i], is_initial_term=(i==initial_index)) + \
                     'x_{}'.format(i+1)
                     for i in range(self.dimension) if round(n[i], num_decimal_places) != 0]
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


    @staticmethod
    def first_nonzero_index(iterable):
        for k, item in enumerate(iterable):
            if not MyDecimal(item).is_near_zero():
                return k
        raise Exception(Line.NO_NONZERO_ELTS_FOUND_MSG)


    def __eq__(self, line2):

        if self.normal_vector.is_zero():
            if not line2.normal_vector.is_zero():
                return False
            else:
                diff = self.constant_term - line2.constant_term
                return MyDecimal(diff).is_near_zero()
        elif line2.normal_vector.is_zero():
            return False

        if not self.is_parallel_to(line2):
            return False

        # get vector connecting both basepoints
        v1 = self.basepoint
        v2 = line2.basepoint

        basepoint_difference = v1.subtract(v2)

        n = self.normal_vector

        # no need to check both lines as they are parallel
        return basepoint_difference.is_orthogonal_to(n)


    def intersection_with(self, line):
        if not self.is_parallel_to(line):
            try:
                l1 = self
                l2 = line
                v1 = self.normal_vector.coordinates
                v2 = line.normal_vector.coordinates

                k1 = l1.constant_term
                k2 = l2.constant_term
                A = Decimal(v1[0])
                B = Decimal(v1[1])
                C = Decimal(v2[0])
                D = Decimal(v2[1])

                x = (D * k1 - B * k2) / (A * D - B * C)
                y = ((-1 * (C * k1)) + A * k2) / (A * D - B * C)

                return (x,y)

            except ZeroDivisionError:
                if self == line:
                    return self
                else:
                    return None
        else:
            return False


class MyDecimal(Decimal):
    def is_near_zero(self, eps=1e-10):
        return abs(self) < eps
