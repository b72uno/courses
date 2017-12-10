from plane import *

print('Plane tests ---------------')
plane1 = Plane(Vector([-0.412, 3.806, 0.728]), -3.46)
plane2 = Plane(Vector([1.03, -9.515, -1.82]), 8.65)

plane3 = Plane(Vector([2.611, 5.528, 0.283]), 4.6)
plane4 = Plane(Vector([7.715, 8.306, 5.342]), 3.76)

plane5 = Plane(Vector([-7.926, 8.625, -7.212]), -7.952)
plane6 = Plane(Vector([-2.642, 2.875, -2.404]), -2.443)

print('Plane 1 is parallel to Plane 2')
print(plane1.is_parallel_to(plane2))
print('Plane 3 is parallel to Plane 4')
print(plane3.is_parallel_to(plane4))
print('Plane 5 is parallel to Plane 6')
print(plane5.is_parallel_to(plane6))

print('Plane 1 is equal to Plane 2')
print(plane1 == plane2)

print('Plane 3 is equal to Plane 4')
print(plane3 == plane4)

print('Plane 5 is equal to Plane 6')
print(plane5 == plane6)
