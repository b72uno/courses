#!/usr/bin/env python3
# -*- coding: utf-8 -*-

f = open("test.txt", encoding="utf-8")

for x in f:
    print(x.rstrip("\n"))

f.close()
