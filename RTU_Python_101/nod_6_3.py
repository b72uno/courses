#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 3. Apgrieztie vārdi
# ======================
# Lietotājs ievada teikumu.
# Izvadam visus teikuma vārdus apgrieztā formā.
# Alus kauss -> Sula ssuak
# PS Te varētu noderēt split un join operācijas.

ievads = input("Ievadiet teikumu: \n")
print(" ".join([i[::-1] for i in ievads.split(" ")]).capitalize())
