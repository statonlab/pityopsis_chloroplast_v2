#!/bin/bash
# need to create links for important files, new assembly:
ln -s /lustre/projects/staton/projects/pityopsis_chloroplast_v2/10_sealer/sealer_output_v2_scaffold.fa ./
# old assembly:
ln -s /lustre/projects/staton/projects/trigiano/pityopsis/chloroplast_genome/analysis_081616/Pityopsis.fasta ./
# old assembly annotation:
ln -s /lustre/projects/staton/projects/trigiano/pityopsis/chloroplast_genome/analysis_081616/07_p_8-16.gff ./Pityopsis.gff
cp sealer_output_v2_scaffold.fa NC_027434.1.fa
sed -i 's/^>.*/>NC_027434.1/g' NC_027434.1.fa
