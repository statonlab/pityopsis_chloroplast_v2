#!/bin/bash

# run alignment
for f in `ls *R1*.fastq`
do
base=$(echo $f | cut -f 1-3 -d '_')
echo "#$ -N Con_$base
#$ -cwd
#$ -e ogs.error
#$ -o ogs.outpt
/lustre/projects/staton/software/bwa-0.7.15/bwa mem -t 1 KY045817_consensus.fa ${base}_R1_001.fastq ${base}_R2_001.fastq > $base.consensus.sam" > qsub.txt
qsub qsub.txt
rm -f qsub.txt
done
