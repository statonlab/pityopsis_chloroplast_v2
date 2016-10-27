#!/bin/bash
# load necessary modules
module unload python/2.7.3
module load biopython
# run python script to extract pertinent information from gff file
./xDev_extractAA.py --g NC_pityopsis.complete.gff --f NC_pityopsis.complete.fa --r Aster_NC_027434.gff3 --o NC_pityopsis
