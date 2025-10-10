#!/bin/bash
# Author: Yijia
# Script: CountLines.sh
# Desc: Counts the number of lines in a file
# Date: Oct 2025

if [ $# -ne 1 ]; then
    echo "Usage: bash CountLines.sh <file>"
    exit 1
fi

NumLines=$(wc -l < "$1")
echo "The file $1 has $NumLines lines."
