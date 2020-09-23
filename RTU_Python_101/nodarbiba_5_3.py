#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Uzrakstīt programmu teksta pārveidošanai
# ========================================
# Saglabā lietotāja ievadu
# Izdrukā ievadīto tekstu bez izmaiņām
# Izņēmums: ja ievadā ir vārdi nav .... slikts, TAD izvadā nav ... slikts posms jānomaina uz ir labs
# Laiks nav slikts -> Laiks ir labs
# Auto nav jauns -> Auto nav jauns
# Tas biezpiens nav nemaz tik slikts -> Tas biezpiens ir labs
# Droši vien noderēs find (vai index, vai pat rfind), tāpat arī in operātors var noderēt. Tāpat slice sintakse būs noderīga.
# Ja uzdevums risinās raiti, tad varam uzlabot un meklēt gan nav ... slikts -> ir labs, gan nav ... slikta -> ir laba
ievads = input("Ievadiet ievadu: ")
print(ievads)

if "nav" in ievads and "slikts" in ievads:
    nav_loc = ievads.find("nav")
    slikts_loc = ievads.find("slikts")
    sl = len("slikt")
    izvads = ievads[:nav_loc] + "ir labs" + ievads[slikts_loc + sl:]

    print(izvads)






