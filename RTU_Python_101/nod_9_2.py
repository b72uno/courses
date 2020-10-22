#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 2. Kopējie Elementi
# Uzrakstiet funkciju,kas atgriež tuple ar kopējiem elementiem trijās virknēs. Virknes var būt list,tuple,string.
# get_common_elements(seq1,seq2,seq3)
# get_common_elements("abc",['a','b'],('b','c')) -> ('b',) # tuple are vienu element šim elementam seko komats
# # atceramies, ka mēs varam pārveidot virknes uz set ar set(virkne), un set uz tuple ar tuple(myset)
# PS Tiem, kas nav pirmo reizi ar pīpi uz jumta, padomāsim, vai varam uztaisīt funkciju, kas spēj apstrādat patvalīgu skaitu virkņu


# %%
def get_common_elements(s1, s2, s3):
    return tuple(set(s1) & set(s2) & set(s3))


print(get_common_elements("abc", ['a', 'b'], ('b', 'c')))


