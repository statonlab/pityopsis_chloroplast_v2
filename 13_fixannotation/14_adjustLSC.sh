#!/bin/bash
# LLC needed to be adjusted a bit due to a gap being filled
echo "##gff-version 3
##sequence-region NC_027434.1 1 152245"
grep -v "^#" $1 | awk -v OFS='\t' '{print $1, $2, $3, ($4 + 203), ($5 + 203), $6, $7, $8, $9}' -
