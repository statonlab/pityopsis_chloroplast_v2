#!/bin/bash
# chain the files
/lustre/projects/staton/software/UCSC/axtChain \
-linearGap=medium \
-psl new0.psl \
Pityopsis.2bit \
new0.2bit \
new0.chain
# sort the chain
/lustre/projects/staton/software/UCSC/chainSort \
new0.chain new0.sorted.chain
# getInfo, needed for next step
/lustre/projects/staton/software/UCSC/twoBitInfo Pityopsis.2bit Pityopsis.chromInfo
/lustre/projects/staton/software/UCSC/twoBitInfo new0.2bit new0.chromInfo
