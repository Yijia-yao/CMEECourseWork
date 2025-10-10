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
echo "The new value of MY_VAR is: $MY_VAR"

echo "Enter two numbers separated by a space:"
read a b
MY_SUM=$(expr $a + $b)
echo "You entered $a and $b; their sum is $MY_SUM"
