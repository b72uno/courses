#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 2. Kubu tabula
# ================
# Lietotājs ievada sākumu (veselu skaitli) un beigu skaitli.
# Izvads ir ievadītie skaitļi un to kubi
# Piemēram: ievads 2 un 5 (divi ievadi)
# Izvads
# 2 kubā: 8
# 3 kubā: 27
# 4 kubā: 64
# 5 kubā: 125
# Visi kubi: [8,27,64,125]
# PS teoretiski varētu iztikt bez list, bet ar list būs ērtāk

sakuma_sk = int(input("Ievadiet veselu skaitli - sākuma skaitli: "))
beigu_sk = int(input("Ievadiet veselu skaitli - beigu skaitli: "))

print(f"Visi kubi: {[i**3 for i in range(sakuma_sk, beigu_sk+1)]}")
