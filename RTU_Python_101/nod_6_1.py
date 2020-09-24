#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 1.a vidējā vērtība
# ====================
# uzrakstīt programmu, kas liek lietotājam ievadīt skaitļus(float).
# programma pēc katra ievada rāda visu ievadīto skaitļu vidējo vērtību.
# ps. 1a var iztikt bez lists

# 1.b programma rāda gan skaitļu vidējo vērtību, gan visus ievadītos skaitļus
# ps iziešana no programmas ir ievadot "q"

# 1.c programma nerāda visus ievadītos skaitļus bet gan tikai top3 un bottom3 un protams joprojām vidējo.

skaitli = []

while True:

    ievads = input("Ievadiet daļskaitļi: ")

    try:
        skaitlis = float(ievads)
        skaitli.append(skaitlis)
        avg = sum(skaitli) / len(skaitli)

        if len(skaitli) > 6:
            print(
                f"Ievadītie daļskaitļi: \n {skaitli[:3]} \n ... \n {skaitli[-3:]} \
                \n Vidējā vērtība: {avg}")
        else:
            print(f"Ievadītie skaitļi: {skaitli} \n Vidējā vērtība: {avg}")

    except ValueError:
        if ievads == "q":
            break
        print("Nav daļskaitlis. Ievadiet q lai izietu.")
