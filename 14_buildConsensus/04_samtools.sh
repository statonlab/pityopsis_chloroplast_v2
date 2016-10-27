#!/bin/bash

# sort and convert to bam
for f in `ls *R1*.fastq`
do
base=$(echo $f | cut -f 1-3 -d '_')
/lustre/projects/staton/software/samtools-1.3/samtools view -@15 -m 2G -b $base.sam | /lustre/projects/staton/software/samtools-1.3/samtools sort -@15 -m 2G -o $base.bam -
/lustre/projects/staton/software/samtools-1.3/samtools index $base.bam
done
