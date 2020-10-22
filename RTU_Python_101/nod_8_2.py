#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 2. vārdnīcu labotājs
# ======================
# uzrakstīt replace_dict_value(d, bad_val, good_val), kas atgriež vārdnīcu ar nomainītām vērtībām
# funkcijas parametri ir vārdnīca d, kas jāapstrādā, un vērtības bad_val kura jānomaina uz good_val
# clean_dict_value({'a':5,'b':6,'c':5}, 5, 10) -> {'a':10,'b':6,'c':10} , jo 5 bija vērtība, kas jānomaina.


# %%
def replace_dict_value(d, bad_val, good_val):
    clean = dict()
    for k, v in d.items():
        clean[k] = v if v is not bad_val else good_val
    return clean


print(replace_dict_value({'a': 5, 'b': 6, 'c': 5}, 5, 10))
