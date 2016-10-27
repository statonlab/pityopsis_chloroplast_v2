#!/bin/bash
# create blast DBs, one for rRNAs and tRNAs
module load blast
makeblastdb \
-in Aster_NC_027434.r_t_RNA.fasta \
-dbtype nucl \
-title Aster_NC_027434.r_t_RNA \
-out Aster_NC_027434.r_t_RNA
# one for proteins
makeblastdb \
-in Aster_NC_027434.CDS2.fasta \
-dbtype 'prot' \
-title Aster_NC_027434.CDS \
-out Aster_NC_027434.CDS
# one for the Aster genome 
makeblastdb \
-in Aster_NC_027434.fasta \
-dbtype nucl \
-title Aster_NC_027434.fasta \
-out Aster_NC_027434.fasta
# one for the Pityopsis genome
makeblastdb \
-in NC_027434.1.fa \
-dbtype nucl \
-title NC_027434.1.fa \
-out NC_027434.1.fa
