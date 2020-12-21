#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd

from random import randrange
from collections import Counter
from matplotlib import pyplot as plt

# 6 kaulini
dice = [sum([randrange(1, 7) for _ in range(6)]) for _ in range(100000)]
dice = Counter(dice)
plt.bar(dice.keys(), dice.values())
plt.show()

# Ceesis
c = pd.read_csv("kopa_cesu_pils_valstis_pa_gadiem_menesiem.csv", sep=";")
print(c.columns)
