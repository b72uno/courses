from vector import *

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


         #ntoes #%win #fans
weights = [[0.1, 0.1, -0.3],# hurt?
           [0.1, 0.2, 0.0], # win?
           [0.0, 1.3, 0.1]] # sad?


