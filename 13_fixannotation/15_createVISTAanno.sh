#!/bin/bash
# created this file to try and run VISTA anno this way... gff ended up working out just fine
grep -v "^#" $1 |\
gawk '{match($9, /Name=([A-Za-z0-9\-]*);/, a)
if ($3 == "gene" ) {
        if ($7 == "+")
            print ">", $4, $5, a[1];
        if ($7 == "-")
            print "<", $4, $5, a[1];
} else {
        print $4, $5, $3;
}
}' - | grep -v "mRNA" | grep -v "CDS"
