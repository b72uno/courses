#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep  7 11:00:00 2017

Task 6:
Challenge: Run dir('any string'). Pick two methods that sound interesting
and run help('any string'.interesting_method) for both of them. Can you figure
out how to use these methods?
'''
"""

dir('any string')
# help('any_string'.maketrans)
# help('any_string'.zfill)

translation_table = 'any_string'.maketrans('any', 'xyz')
print('any_string'.translate(translation_table))

print('any_string'.zfill(20))
