#!/bin/bash
# Author: Yijia
# Script: ConcatenateTwoFiles.sh
# Desc: Concatenates two files into a third
# Arguments: file1 file2 output_file
# Date: Oct 2025

if [ $# -ne 3 ]; then
    echo "Usage: bash ConcatenateTwoFiles.sh <file1> <file2> <output>"
    exit 1
fi

cat "$1" > "$3"
cat "$2" >> "$3"
echo "Merged file saved as $3"
