#!/bin/bash
# create bwa index
/lustre/projects/staton/software/bwa-0.7.15/bwa index \
-p NC_027434.1.complete.fa \
NC_027434.1.complete.fa
# run alignment
/lustre/projects/staton/software/bwa-0.7.15/bwa mem \
-t 15 \
NC_027434.1.complete.fa \
/lustre/projects/staton/projects/pityopsis_chloroplast/raw_reads/Pfalcata_S2_L001_R1_001.fastq \
/lustre/projects/staton/projects/pityopsis_chloroplast/raw_reads/Pfalcata_S2_L001_R2_001.fastq \
> NC_027434.1.complete.fa.sam
# sort and index with samtools
/lustre/projects/staton/software/samtools-1.3/samtools view \
-@ 10 -m 2G \
-b NC_027434.1.complete.fa.sam \
| \
/lustre/projects/staton/software/samtools-1.3/samtools sort \
-@ 10 -m 2G \
-o NC_027434.1.complete.fa.bam -
/lustre/projects/staton/software/samtools-1.3/samtools index \
NC_027434.1.complete.fa.bam
