#!/bin/sh
# Author: Yijia
# Script: csvtospace.sh
# Desc: Converts comma-separated file to space-separated
# Arguments: 1 -> CSV file
# Date: Oct 2025

if [ $# -ne 1 ]; then
    echo "Error: Please provide ONE input file."
    echo "Usage: bash csvtospace.sh <file.csv>"
    exit 1
fi

infile=$1
outfile="${infile%.csv}.space.txt"

echo "Converting commas to spaces in $infile ..."
cat "$infile" | tr "," " " > "$outfile"
echo "Done! Saved as $outfile"
exit 0
