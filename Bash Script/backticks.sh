#!/bin/bash
# A simple demonstration of using backticks
# Ashley 2022/06/28
 
lines=`cat $1 | wc -l`
echo The number of lines in the file $1 is $lines