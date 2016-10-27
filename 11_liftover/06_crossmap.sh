#!/bin/bash
# load proper python module
module load python/2.7.11 
# I have crossmap installed in my home directory, see 00_notes.md for installation
python ~/.local/bin/CrossMap.py gff new0.chain Pityopsis.gff new0.gff
