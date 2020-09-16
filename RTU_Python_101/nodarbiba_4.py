#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 1. FizzBuzz
# =============
# Izdrukāt virknīti 1,2,3,4,Fizz,6,Buzz,8,.....34,FizzBuzz,36,....līdz  97,Buzz, 99,Fizz
# Tātad ja skaitlis dalās ar 5 tad Fizz
# Ja dalās ar 7 tad Buzz,
# Ja dalās ar 5 UN 7 tad Fizzbuzz
# savādāk pats skaitlis
# Piezīme: šads uzdevums kļuva populārs kā pirmais uzdevums, ko uzdot, lai noteiktu vai cilvēks vispār zina par programmēšanu :)
print("\n\n1.uzdevums:")
print("--------------------------")

virkne = ["FizzBuzz" if i % 5 == 0 and i % 7 == 0 else
          "Fizz" if i % 5 == 0 else
          "Buzz" if i % 7 == 0 else
          str(i) for i in range(1,101)]
print(",".join(virkne))

# 2. Eglīte
# ===========
# Ievadiet eglītes augstumu
# Izdrukājiet eglīti:
# Piem. augstums == 3
# Izdruka būtu:
#  *
# ***
# *****
# Piezīme: atceramies, ka vairākus simbolus var izdrukāt piemēram šādi: print(" "*10+"*"*6)
print("\n\n2.uzdevums:")
print("--------------------------")

augstums = int(input("Ievadiet eglītes augstumu: \n"))

for i in range(1, augstums+1):
    pad = " "*(augstums - i)
    print(pad + "*"*(i*2-1) + pad)


# 3. Pirmskaitlis
# =================
# Atrodiet vai ievadītais veselais pozitīvais skaitlis ir pirmskaitlis.
# Pirmskaitlis ir skaitlis, kas dalās bez atlikuma tikai pats ar sevi un 1.
# Piezīme: šo uzdevumu var sākt risināt ļoti vienkārši un varat arī pēc tam optimizēt.
# (kaut vai tas, ka mums nav jāpārbauda dalīšanās ar skaitļiem, kas lielāki par ievadītā skaitļa kvadrātsakni)
print("\n\n3.uzdevums:")
print("--------------------------")

from math import sqrt

skaitlis = int(input("Ievadiet skaitli: \n"))

def ir_pirmskaitlis(skaitlis, dal):
    if dal == 1 and skaitlis != 1:
        return True
    elif skaitlis % dal == 0:
        return False
    else:
        return ir_pirmskaitlis(skaitlis, dal-1)


print("Ievadītais skaitlis ir pirmskaitlis" if
      ir_pirmskaitlis(skaitlis, int(sqrt(skaitlis))) else
      "Ievadītais skaitlis nav pirmskaitlis"
      )
