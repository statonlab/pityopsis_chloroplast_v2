#!/bin/bash
# load necessary modules
module unload python/2.7.3
module load biopython
# run python script to extract pertinent information from gff file
./xDev_extractIR.py --g NC_027434.1.fixHandEdits.gff --f NC_027434.1.fa --o NC_027434.1 > IR.fa
sed 's/NNN\n$/NNN/g' NC_027434.1.fa > tmp.fa
cat tmp.fa IR.fa > NC_027434.1.complete.fa
