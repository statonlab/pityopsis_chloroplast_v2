#!/bin/bash
# create links to important files
ln -s ../11_liftover/NC_027434.1* ./
module load samtools
samtools faidx NC_027434.1.fa
