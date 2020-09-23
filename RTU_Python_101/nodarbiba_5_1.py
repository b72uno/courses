#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Juceklis
# ==========
# Lietotājs ievada vārdu.
# Tiek atgriezts lietotāja vārds apgriezts un sākas ar lielo burtu un papildu teksu pamatīgs juceklis vai ne pirmais lietotāja burts?
# Valdis -> Sidlav, pamatigs juceklis vai ne V?
vards = str(input("Ievadiet vārdu: "))
apgriezts = vards[::-1].capitalize()
print(apgriezts + " pamatigs juceklis vai ne " + vards[0] + "?\n")


