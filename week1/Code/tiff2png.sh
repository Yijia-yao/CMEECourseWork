#!/bin/bash
# Author: Yijia
# Script: tiff2png.sh
# Desc: Converts all .tif images to .png
# Date: Oct 2025

for f in *.tif; do
    echo "Converting $f"
    convert "$f" "$(basename "$f" .tif).png"
done
