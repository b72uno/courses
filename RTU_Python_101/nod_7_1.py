#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 1. Lielais rezultāts
# ======================
# Uzrakstiet funkciju add_mult, kurai nepieciešami trīs parametri/argumenti
# Atgriež rezultātu, kas ir 2 mazāko argumentu summa reizināta ar lielāko argumenta vērtību.
# PS Uzskatīsim, ka funkcijai vienmēr tiks padoti skaitliski parametri, varam tipus nepārbaudīt.
# Iespējami dažādi risinājumi, piemēram ar list struktūru varētu būt tīri eleganti.
# Piemērs add_mult(2,5,4) -> atgriezīs (2+4)*5 = 30


def add_mult(x, y, z):
    num_list = [x, y, z]
    largest = max(num_list)
    num_list.remove(largest)
    return sum(num_list) * largest
