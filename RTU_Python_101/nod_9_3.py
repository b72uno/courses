#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 3. Vai ir pangramma?
# uzrakstīt funkciju is_pangram, kas atgriež True, kad mytext parametrs satur visus burtus kas padoti a alfabetā.
# Savadāk atgriežam False.
# pangramma - teikums,vārdu virkne, kas satur visus alfabeta burtus - https://en.wikipedia.org/wiki/Pangram
# Atstarpes ignorējam,un uzskatam ka lielais burts ir tikpat derīgs kā mazais, t.i. šeit A un a -> a


def is_pangram(mytext, a='abcdefghijklmnopqrstuvwxyz'):
    return set(a).issubset(set(mytext.lower()))


print(is_pangram("abcd foo"))
print(is_pangram("The quick brown fox jumps over the lazy dog"))
print(is_pangram("The five boxing wizards jump quickly"))
