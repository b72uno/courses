#!/usr/bin/env python3
# -*- coding: utf-8 -*-"

# 1. Uzrakstiet programmu, kas pārbauda lietotāja temperatūru.
# ==============================================================
# Ja lietotājs ievada zem 35, tad prasiet vai "nav par aukstu"
# Ja no 35 līdz 37 (ieskaitot), izvadiet "viss kārtībā"
# Ja ir pāri 37, tad izvadiet "iespējams drudzis"

print("\n\n1.uzdevums")
print("----------------------------------")

temp = int(input("Ievadiet temperatūru:"))

if temp < 35:
    print("Vai nav par aukstu?")
elif 35 <= temp < 37:
    print("Viss kārtībā!")
else:
    print("Iespējams drudzis.")


#  2. Firma apsolījusi Ziemassvētku bonusu 15% apjomā no mēneša algas par KATRU nostrādāto gadu virs 2 gadiem.
# ==============================================================
# Uzdevums. Noprasiet lietotājam mēneša algas apjomu un nostrādāto gadu skaitu.
# Izvadiet bonusu.
# Piemērs 5 gadu stāžs, 1000 Eiro alga, bonuss būs 450 Eiro.
print("\n\n2.uzdevums")
print("----------------------------------")

alga = int(input("Ievadiet mēneša algas apjomu:"))
gadi = int(input("Ievadiet nostrādāto gadu skaitu:"))

print("Bonuss būs: ", int(0 if gadi <= 2 else (gadi-2)*0.15*alga))

# 3. Noprasiet lietotājam ievadīt 3 skaitļus, izvadiet tos sakārtotā secībā.
# ==============================================================
# Piezīme: pagaidām šo uzdevumu risinam tikai ar if, elif, else darbībām
# Pastāv arī risinājums izmantojot kārtošanu un list struktūru, kuru vēl neesam skatījuši.

print("\n\n3.uzdevums")
print("----------------------------------")

a = int(input("Ievadiet skaitli #1:"))
b = int(input("Ievadiet skaitli #2:"))
c = int(input("Ievadiet skaitli #3:"))

if a >= b:
    if b >= c:
        print(a,b,c)
    else:
        print(a,c,b)
elif b >= c:
    if a >= c:
        print(b,a,c)
    else:
        print(b,c,a)
else:
    if b >= a:
        print(c,b,a)
    else:
        print(c,a,b)




