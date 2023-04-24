#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  4 10:00:00 2018

Task 1:
Make a shopping list of five things you need at the grocery store. Put each
item on it's own line in  a cell. Remember to use quotes! Use print() so that
each of your items displays (try it first without).

Task 2:
Your groceries ring up as 9.42, 5.67, 3.25, 13.40 and 7.50 respectively.
Use python as a handy calculator to add up these amounts.

Task 3:
But wait! You decide you want to buy five of the last item. Re-calculate
your total.
"""

shopping_list = ['milk', 'eggs', 'bread', 'cheese', 'butter']

for item in shopping_list:
    print(item)

print(9.42 + 5.67 + 3.25 + 13.40 + 7.50)

print(9.42 + 5.67 + 3.25 + 13.40 + 7.50 * 5)
