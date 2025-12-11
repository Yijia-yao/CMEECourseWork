#!/bin/bash
# Author: Yijia
# Script: tiff2png.sh
# Desc: Converts all .tif images to .png
# Date: Oct 2025

# for f in *.tif; do
#     echo "Converting $f"
#     convert "$f" "$(basename "$f" .tif).png"
# done


shopt -s nullglob  

files=( *.tif )

if [ ${#files[@]} -eq 0 ]; then
    echo "No .tif files found in current directory, nothing to convert."
    exit 0
fi

for f in "${files[@]}"; do
    echo "Converting $f"
    convert "$f" "$(basename "$f" .tif).png"
done

exit 0
