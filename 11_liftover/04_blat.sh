#!/bin/bash
# blat align all new pieces to the old build
/lustre/projects/staton/software/UCSC/blat \
Pityopsis.2bit new0.fa \
new0.psl \
-tileSize=12 -minScore=100 -minIdentity=98
