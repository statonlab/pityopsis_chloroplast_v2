#!/bin/bash
# load necessary modules
module unload python/2.7.3
module load biopython
# run python script to extract pertinent information from gff file
./xDev_extractAA.py --g NC_027434.1.gff --f NC_027434.1.fa --o NC_027434.1
