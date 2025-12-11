#!/bin/sh
# Author: Yijia
# Script: variables.sh
# Desc: Demonstrates shell variables
# Date: Oct 2025

echo "This script was called with $# parameters"
echo "The script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"

MY_VAR='some string'
echo "The current value of MY_VAR is: $MY_VAR"
echo "Please enter a new string:"
read MY_VAR
if [ -z "$MY_VAR" ]; then
    echo "No new string entered, keeping original value."
else
    echo "The new value of MY_VAR is: $MY_VAR"
fi

echo "Enter two numbers separated by a space:"
read a b

if [ -z "$a" ] || [ -z "$b" ]; then
    echo "No numbers entered, cannot compute sum."
else
    MY_SUM=$((a + b))
    echo "You entered $a and $b; their sum is $MY_SUM"
fi
