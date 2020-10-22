#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 1. Min, Avg, Max
# ==================
# Uzrakstiet funkciju get_min_avg_max(sequence), kas atgriež tuple ar trīs vērtībām attiecīgi mazāko, aritmētisko vidējo un lielāko vērtību no virknes.
# get_min_avg_max([0,10,1,9]) -> (0,5,10)
# ienākošā sequence var būt tuple vai list ar skaitliskām vērtībām.
# 1b tiem, kas pieredzējušāki

# Uzrakstiet funkciju get_min_med_max(sequence), kas atgriež tuple ar trīs vērtībām attiecīgi mazāko, medianu un lielāko vērtību no virknes.
# Median vērtība ir vērtiba, kas sakartotā virknē ir paša vidū. Ja virknes skaits ir pāra tad vidū ir divas vērtības.
# No vidus vērtībām tad ņem vidējo.
# get_min_med_max([1,5,8,4,3]) -> (1,4,8)
# get_min_med_max([2,2,9,9,4,3]) -> (2,3.5,9)
# get_min_med_max("baaac") -> ('a','a','c')
# # ar string var būt interesanti rezultāti pie pāra skaita ņemot vidējo, tāpēc labak dot abus vidējos
# get_min_med_max("faaacb") -> ('a', 'ab', 'f')
# ienākošā sequence var būt tuple vai list ar vienāda tipa vērtībām, vai pat string.


# %%
def get_min_avg_max(s):
    avg = int(sum(s) / len(s))
    return (min(s), avg, max(s))


print(get_min_avg_max([0, 10, 1, 9]))


# %%
def get_min_med_max(s):
    ls = len(s)

    mid = ls // 2
    s = sorted(s)

    if ls % 2 != 0:
        median = s[mid]
    else:
        try:
            median = ((int(s[mid - 1])) + int(s[mid])) / 2
        except ValueError:
            median = s[mid - 1] + s[mid]

    return (min(s), median, max(s))


print(get_min_med_max([1, 5, 8, 4, 3]))
print(get_min_med_max([2, 2, 9, 9, 4, 3]))
print(get_min_med_max("baaac"))
print(get_min_med_max("faaacb"))
