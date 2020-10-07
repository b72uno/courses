#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 2. Palindroms
# ===============
# uzrakstiet funkciju is_palindrome(text)
# kas atgriež bool True vai False atkarībā vai vārds vai teikums ir lasāms vienādi no abām pusēm.
# PS no sākuma varat sākt ar viena vārda risinājumu, bet pilns risinājums ignorēs atstarpes(whitespace) un lielos/mazos burtus
# is_palindrome("Alus ari ira      sula") -> True


def is_palindrome(text):
    clean_text = text.replace(" ", "").lower()
    return True if clean_text == clean_text[::-1] else False


print(is_palindrome("Alus ari ira       sula"))
