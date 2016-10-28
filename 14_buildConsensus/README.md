Align all sequenced chloroplast reads to the assembled Pityopsis falcata genome
####create links to important files
```
ln -s ../13_fixannotation/NC_pityopsis.complete.fa ./
ln -s  ../../pityopsis_chloroplast/raw_reads/*.fastq ./
```
---
####create bwa index
```
/lustre/projects/staton/software/bwa-0.7.15/bwa index \
-p NC_pityopsis.complete.fa \
NC_pityopsis.complete.fa
```
---
####run alignment
```
for f in `ls *R1*.fastq`
do
base=$(echo $f | cut -f 1-3 -d '_')
echo "#$ -N $base
#$ -cwd
#$ -e ogs.error
#$ -o ogs.outpt
/lustre/projects/staton/software/bwa-0.7.15/bwa mem -t 1 NC_pityopsis.complete.fa ${base}_R1_001.fastq ${base}_R2_001.fastq > $base.sam" > qsub.txt
qsub qsub.txt
rm -f qsub.txt
done
```
---
####sort and convert to bam
```
for f in `ls *R1*.fastq`
do
base=$(echo $f | cut -f 1-3 -d '_')
/lustre/projects/staton/software/samtools-1.3/samtools view -@15 -m 2G -b $base.sam | /lustre/projects/staton/software/samtools-1.3/samtools sort -@15 -m 2G -o $base.bam -
/lustre/projects/staton/software/samtools-1.3/samtools index $base.bam
done
```
---
####create list of bam files
```
ls -1 *.bam > bamList.txt
```
####create pileup (output vcf)
```
/lustre/projects/staton/software/samtools-1.3/samtools mpileup \
-A \
-b bamList.txt \
-uf NC_pityopsis.complete.fa > NC_pityopsis.consensus.vcf
```
####create the consensus fastq file
```
/lustre/projects/staton/software/bcftools-1.2/bcftools call -c NC_pityopsis.consensus.vcf |\
/lustre/projects/staton/software/bcftools-1.2/vcfutils.pl vcf2fq > NC_pityopsis.consensus.fq
```
####convert fastq to fasta
```
sed -n '/+/q;p' NC_pityopsis.consensus.fq > NC_pityopsis.consensus.fa
```
---
####run alignment
```
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
```
---
####sort and convert to bam
```
for f in `ls *R1*.fastq`
do
base=$(echo $f | cut -f 1-3 -d '_')
/lustre/projects/staton/software/samtools-1.3/samtools view -@15 -m 2G -b $base.consensus.sam | /lustre/projects/staton/software/samtools-1.3/samtools sort -@15 -m 2G -o $base.consensus.bam -
/lustre/projects/staton/software/samtools-1.3/samtools index $base.consensus.bam
done
```
---
