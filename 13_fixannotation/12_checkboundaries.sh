#!/bin/bash
# extract appropriate regions
#module load biopython
#python extract.py NC_027434.1.complete.fa 151245 152245 > tmp_end.fasta
python extract.py NC_027434.1.complete.fa 151448 152448 > tmp_end.fasta
python extract.py NC_027434.1.complete.fa 1 1000 > tmp_beg.fasta
cat tmp_end.fasta tmp_beg.fasta > Pityopsis_IRB_to_LSC_boundary.fasta
# remove extra header
gep -v ">NC_027434.1subseq1-1000 <unknown description>" Pityopsis_IRB_to_LSC_boundary.fasta > tmp.fa
sed -i 's/^>.*$/>NC_027434.1/g' tmp.fasta
module load java/jdk8u5
java -jar /lustre/projects/staton/software/picard/build/libs/picard.jar NormalizeFasta INPUT=tmp.fa OUTPUT=Pityopsis_IRB_to_LSC_boundary.fasta
# map with bwa
/lustre/projects/staton/software/bwa-0.7.15/bwa index Pityopsis_IRB_to_LSC_boundary.fasta
/lustre/projects/staton/software/bwa-0.7.15/bwa mem -t 15 Pityopsis_IRB_to_LSC_boundary.fasta \
/lustre/projects/staton/projects/pityopsis_chloroplast/raw_reads/Pfalcata_S2_L001_R1_001.fastq \
/lustre/projects/staton/projects/pityopsis_chloroplast/raw_reads/Pfalcata_S2_L001_R2_001.fastq \
> Pityopsis_IRB_to_LSC_boundary.sam
# manipulate with samtools
/lustre/projects/staton/software/samtools-1.3/samtools view -b Pityopsis_IRB_to_LSC_boundary.sam |\
/lustre/projects/staton/software/samtools-1.3/samtools sort -o Pityopsis_IRB_to_LSC_boundary.bam -
/lustre/projects/staton/software/samtools-1.3/samtools index Pityopsis_IRB_to_LSC_boundary.bam
/lustre/projects/staton/software/samtools-1.3/samtools faidx Pityopsis_IRB_to_LSC_boundary.fasta
