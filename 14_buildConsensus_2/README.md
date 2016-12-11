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
	/lustre/projects/staton/software/samtools-1.3/samtools \
	view -@ 15 -b $base.sam \
	| \
	/lustre/projects/staton/software/samtools-1.3/samtools \
	sort -@ 15 -T $base.tmp -m 10G -o $base.bam -

	/lustre/projects/staton/software/samtools-1.3/samtools index $base.bam
done
```

---
####create list of bam files
```
ls -1 *.bam > bamList.txt
```

####call variants

Call variants
```
module load samtools
module load bcftools
samtools mpileup \
-A \
-b bamList.txt \
-uf NC_pityopsis.complete.fa \
| \
bcftools call -mv --threads 20 > NC_pityopsis.raw.vcf
```

Filter and index
```
bcftools filter -s LowQual -O z NC_pityopsis.raw.vcf > NC_pityopsis.flt.vcf.bgz
bcftools index NC_pityopsis.flt.vcf.bgz
```

####create the consensus fastq file
for f in `ls *R1*.fastq`
do
	base=$(echo $f | cut -f 1-3 -d '_')
	bcftools consensus -f NC_pityopsis.complete.fa -s $base.bam -o $base.fasta NC_pityopsis.flt.vcf.bgz >& $base.consensus_output.txt
done

