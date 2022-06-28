#!/bin/bash
# Backs up a single project directory
# Ashley 2022/06/28
 
date=`date +F%`
mkdir ~/projectbackups/$1_$date
cp -R ~/projects/$1 ~/projectbackups/$1_d=$date
echo Backup of $1 completed