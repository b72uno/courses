#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Uzrakstīt programmu teksta simbola atpazīšanai
# ================================================
# Lietotājs(pirmais spēlētājs) ievada tekstu.
# Tiek izvadītas tikai zvaigznītes burtu vietā. Pieņemsim, ka cipari nebūs, bet atstarpes gan var būt
# Lietotājs(tātad otrs spēlētājs) ievada simbolu.
# Ja burts ir tad tas burts attiecīgajās vietās tiek parādīts, visi pārējie burti paliek par zvaigznītēm.
# Kartupeļu lauks -> ********* *****
# ievada a -> *a****** *a***
# Principā tas ir labs iesākums karātavu spēlei.

teksts = input("Ievadiet tekstu: ")
print("".join("*" if i.isalpha() else i for i in teksts))

burts = input("Ievadiet burtu: ")
print("".join(i if burts.lower() == i.lower() or
              not i.isalpha() else "*" for i in teksts))
print("\n")
