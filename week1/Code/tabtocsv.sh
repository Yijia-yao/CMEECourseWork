#!/bin/sh
# Author: Yijia
# Script: tabtocsv.sh
# Desc: Substitute tabs with commas
# Arguments: 1 -> tab-delimited file
# Date: Oct 2025

if [ $# -ne 1 ]; then
    echo "Error: Please provide ONE input file."
    echo "Usage: bash tabtocsv.sh <file>"
    exit 1
fi

infile=$1
outfile="${infile%.txt}.csv"

echo "Creating a comma-delimited version of $infile ..."
cat "$infile" | tr -s "\t" "," > "$outfile"
echo "Done! Saved as $outfile"
exit 0
