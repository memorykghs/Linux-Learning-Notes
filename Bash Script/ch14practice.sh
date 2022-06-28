#!/bin/bash
# Example of activity practice
# Ashley 2022/06/28

# 檔案數量
fileNum=`ls -l $1 | grep '^-' | wc -l`
echo 1. There are $fileNum files in directory $1.

# 目錄數量
directoryNum=`ls -l $1 | grep '^d' | wc -l`
echo 2. There are $directoryNum directories in directory $1.

# 容量最大
bigfile=`du -sh $1 | sort -r | grep head`
echo 3. The biggest file is $bigfile.

# 近期異動或新增的檔案
recentfile=`find $1 -mtime 0`
echo 4. The recent modify files are:
echo $recentfile

# 目錄或檔案的擁有者
list=`ls -l $1`
echo 5. The list below current directory:
echo $list