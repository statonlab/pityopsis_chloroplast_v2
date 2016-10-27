#!/bin/bash
# search pityopsis genome for Aster_NC matches (protein)
module load blast
echo "Pitiyopsis	Aster	% identity	alignment length	mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score"
blastn \
-query $1 \
-db NC_027434.1.fa \
-outfmt 6 \
-show_gis \
-max_target_seqs 1 
#-num_threads 30
