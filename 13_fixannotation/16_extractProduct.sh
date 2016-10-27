#!/bin/bash
# load necessary modules
module unload python/2.7.3
module load biopython
# run python script to extract pertinent information from gff file
./xDev_extractProduct.py --g Aster_NC_027434.gff3 --r NC_pityopsis.complete.gff --o Aster
