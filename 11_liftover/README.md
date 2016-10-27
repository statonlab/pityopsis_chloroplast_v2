Objective is to create a liftover of the old pityopsis genome annotation to the new pityposis genome.

Started here:
https://www.biostars.org/p/65558/

This can be accomplished through a series of steps described by http://genomewiki.ucsc.edu/index.php/Minimal_Steps_For_LiftOver. I will drop out and use the crossmap software once I get the chain files: https://sourceforge.net/projects/crossmap/files/

See also:
http://genomewiki.ucsc.edu/index.php/LiftOver_Howto
http://hgwdev.cse.ucsc.edu/~kent/src/unzipped/hg/doc/liftOver.txt
https://www.mail-archive.com/genome@lists.soe.ucsc.edu/msg02508.html

Software needed to create chain files:
faSplit
twoBitInfo
blat
liftUp
axtChain
chainMergeSort
chainSplit

These software were obtained from: http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64

These software were stored in: /lustre/projects/staton/software/UCSC/

user will want to install CrossMap in user directory using pip
module load python/2.7.11
pip install --user CrossMap

see: https://sourceforge.net/projects/crossmap/files/
####need to create links for important files, new assembly:
```
ln -s /lustre/projects/staton/projects/pityopsis_chloroplast_v2/10_sealer/sealer_output_v2_scaffold.fa ./
```
####old assembly:
```
ln -s /lustre/projects/staton/projects/trigiano/pityopsis/chloroplast_genome/analysis_081616/Pityopsis.fasta ./
```
####old assembly annotation:
```
ln -s /lustre/projects/staton/projects/trigiano/pityopsis/chloroplast_genome/analysis_081616/07_p_8-16.gff ./Pityopsis.gff
cp sealer_output_v2_scaffold.fa NC_027434.1.fa
sed -i 's/^>.*/>NC_027434.1/g' NC_027434.1.fa
```
---
####reformat new fasta file and change header
```
/lustre/projects/staton/software/UCSC/faSplit sequence \
sealer_output_v2_scaffold.fa 1 new
sed -i 's/^>.*/>NC_027434.1/g' new0.fa
```
---
####convert fasta to 2bit
```
/lustre/projects/staton/software/UCSC/faToTwoBit Pityopsis.fasta Pityopsis.2bit
/lustre/projects/staton/software/UCSC/faToTwoBit new0.fa new0.2bit
```
---
####blat align all new pieces to the old build
```
/lustre/projects/staton/software/UCSC/blat \
Pityopsis.2bit new0.fa \
new0.psl \
-tileSize=12 -minScore=100 -minIdentity=98
```
---
####chain the files
```
/lustre/projects/staton/software/UCSC/axtChain \
-linearGap=medium \
-psl new0.psl \
Pityopsis.2bit \
new0.2bit \
new0.chain
```
####sort the chain
```
/lustre/projects/staton/software/UCSC/chainSort \
new0.chain new0.sorted.chain
```
####getInfo, needed for next step
```
/lustre/projects/staton/software/UCSC/twoBitInfo Pityopsis.2bit Pityopsis.chromInfo
/lustre/projects/staton/software/UCSC/twoBitInfo new0.2bit new0.chromInfo
```
---
####load proper python module
```
module load python/2.7.11 
```
####I have crossmap installed in my home directory, see 00_notes.md for installation
```
python ~/.local/bin/CrossMap.py gff new0.chain Pityopsis.gff new0.gff
```
---
####just adds proper gff header to file
```
if [ 0 = 0 ]
then
echo "##gff-version 3								length
##sequence-region NC_027434.1 1 127211"
cat new0.gff
fi > NC_027434.1.gff
```
---
