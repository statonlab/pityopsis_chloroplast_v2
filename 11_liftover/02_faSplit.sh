#!/bin/bash
# reformat new fasta file and change header
/lustre/projects/staton/software/UCSC/faSplit sequence \
sealer_output_v2_scaffold.fa 1 new
sed -i 's/^>.*/>NC_027434.1/g' new0.fa
