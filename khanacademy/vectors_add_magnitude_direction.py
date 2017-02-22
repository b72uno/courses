from math import sin, cos, atan, sqrt, degrees, radians

class Vector(object):
    def __init__(self, magnitude, direction):
        self.magnitude = magnitude
        self.direction = direction

    def __str__(self):
        return 'Vector with magnitude {} and direction {}'.format(self.magnitude, self.direction)

    @classmethod
    def add_two(self, vm1, vd1, vm2, vd2):
        x_component = vm1*cos(radians(vd1)) + vm2*cos(radians(vd2))
        y_component = vm1*sin(radians(vd1)) + vm2*sin(radians(vd2))

        fix = 0

        if x_component < 0:
            fix = 180
        else:
            if y_component < 0:
                fix = 360

        print(x_component)
        print(y_component)
        print(fix)
        print(degrees(atan(y_component / x_component)))

        magnitude = sqrt(x_component**2 + y_component**2)
        direction = degrees(atan(y_component / x_component)) + fix
        return Vector(magnitude, direction)
