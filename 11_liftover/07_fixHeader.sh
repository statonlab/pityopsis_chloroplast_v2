#!/bin/bash
# just adds proper gff header to file
if [ 0 = 0 ]
then
echo "##gff-version 3								length
##sequence-region NC_027434.1 1 127211"
cat new0.gff
fi > NC_027434.1.gff
