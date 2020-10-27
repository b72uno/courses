#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Definējiet klasi Song
# Klases construktora vajag būt trīs papildu 3 parametriem(self un vēl 3!)
# title pēc noklusējuma tukša string
# author pēc noklusējuma tukšs string
# lyrics pēc noklusējuma tukšs tuple
# konstruktors saglabātu šos trīs parametrus
# un papildu izdrukātu uz ekrāna "New Song made" - (pamēģiniet arī izdrukāt šeit author un title!)

# Uzrakstiet metodi sing kas izdrukā dziesmu pa rindiņai uz ekrāna, vispirms izdrukājot autoru un title, ja tie ir.
# Uzrakstiet metodi yell kas izdrukā dziesmu ar lieliem burtiem pa rindiņai uz ekrāna, vispirms izdrukājot autoru un title, ja tie ir.

# Bonuss: uztaisiet lai sing un yell varam izsaukt vairākas reizes (ķēdejot)
# Bonuss: uztaisiet papildu parametru max_lines, kas izdrukā tikai noteiktu rindiņu skaitu gan sing gan yell. Labāk taisiet ar kādu default vērtību piem. -1 , pie kuras tad izdrukā visas rindas.
# Par ķēdēšano bija šeit: https://www.das.lv/platforma/mod/page/view.php?id=690


class Song:
    def __init__(self, title, author, lyrics):
        self.title = title
        self.author = author
        self.lyrics = lyrics
        print(f"New song made: {title} by {author}")

    def sing(self, max_lines=999, caps=False):
        print(f"{self.author} - {self.title}")

        lyrics = self.lyrics[:max_lines]

        if caps:
            lyrics = [line.upper() for line in lyrics]

        for line in lyrics:
            print(line)

        return self

    def yell(self, max_lines=999):
        self.sing(max_lines=max_lines, caps=True)
        return self


# Izveidojiet vairākas dziesmas ar dziesmu tekstiem

# Piemērs:
ziemelmeita = Song("Ziemeļmeita", "Jumprava",
                   ["Gāju meklēt ziemeļmeitu", " Garu, tālu ceļu veicu"])
ziemelmeita.sing(1).yell()
# Rezultāts uz ekrāna:
# Ziemeļmeita - Jumprava
# Gāju meklēt ziemeļmeitu
# Ziemeļmeita - Jumprava
# GĀJU MEKLĒT ZIEMEĻMEITU
# GARU, TĀLU CEĻU VEICU

# %%
# 1.B
# Tie kas jūtas komfortabli, uztaisiet Rap klasi kas manto no Song
# Papildu metode break_it ar diviem noklusētiem parametriem max_lines un drop vienādu ar "yeah", kura līdzīga sing, bet pievienot drop aiz katra vārda...


class Rap(Song):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def break_it(self, max_lines, drop="yeah"):
        drop = " " + drop.upper() + " "
        self.lyrics = [drop.join(line.split(" ")) for line in self.lyrics]
        self.sing(max_lines)
        return self


zrap = Rap("Ziemeļmeita", "Jumprava",
           ["Gāju meklēt ziemeļmeitu", " Garu, tālu ceļu veicu"])
zrap.break_it(2, "yah")
# Ziemeļmeita - Jumprava
# Gāju YAH meklēt YAH ziemeļmeitu YAH
