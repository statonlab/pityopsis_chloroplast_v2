#!/bin/bash
# create list of bam files
ls -1 *.bam > bamList.txt
# create pileup (output vcf)
/lustre/projects/staton/software/samtools-1.3/samtools mpileup \
-A \
-b bamList.txt \
-uf NC_pityopsis.complete.fa > NC_pityopsis.consensus.vcf
# create the consensus fastq file
/lustre/projects/staton/software/bcftools-1.2/bcftools call -c NC_pityopsis.consensus.vcf |\
/lustre/projects/staton/software/bcftools-1.2/vcfutils.pl vcf2fq > NC_pityopsis.consensus.fq
# convert fastq to fasta
sed -n '/+/q;p' NC_pityopsis.consensus.fq > NC_pityopsis.consensus.fa
