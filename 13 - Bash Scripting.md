# 13 - Bash Scripting
在計算機中的 Bash Script ( 腳本 ) 可以想想成戲劇的劇本，說明應該要做什麼。只是腳本是由電腦讀取和執行。

Bash Script 可以讓我們自行定義一系列操作，然後由電腦自行執行這些動作，不需要使用者在輸入指令。當有需要執行特定重複的任務，Bash Script 會是一個非常有用的工具。

Bash Script 會被稱作解析器 ( interpreter ) 的東西讀取和執行。在 Linux 中有許多典型的解析器，接下來我們會來認識 Bash Script。

> 任何可以被致行的指令都可以被放進腳 本中，反之亦然，在腳本中的任何內容都可以在 terminal 被執行。

* 可以另外看 [Bash Scripting Tutorial](https://ryanstutorials.net/bash-scripting-tutorial/)。

## A Simple Scripting
建議自己建立一個相似的檔案來執行並觀察它是如何運作的。下面的這個腳本將印出訊息到畫面上 ( 用 `echo`  ) 然後執行 `ls` 列出當前目錄下有的東西。

```
echo <message>
```

範例：
先建立一個 `testScript.sh` 檔案，內容如下：
```
#!/bin/bash
# A simple demostration script
# Ashley 2022/06/22
 
echo Here are the files in your current directory:
ls
```

如果沒有執行權限，修改檔案權限：
```
chmod test 744 testScript.sh
```

```
1.  localhost:~# cat testScript.sh
2.  #!/bin/bash
3.  # A simple demostration script
4.  # Ashley 2022/06/22
5. 
6.  echo Here are the files in your current directory:
7.  ls
8.  localhost:~# ls -l testScript.sh
9.  -rw-r--r--    1 root     root           118 Jun 27 20:16 testScript.sh
10. localhost:~# chmod 744 testScript.sh
11. localhost:~# ls -l testScript.sh
12. -rwxr--r--    1 root     root           118 Jun 27 20:16 testScript.sh
13. localhost:~# ./testScript.sh
14. Here are the files in your current directory:
15. bench.py       hello.c        hello.js       readme.txt     testScript.sh
```

###### Line 2
腳本的第一行開頭應該必須是這一行。因為這一行標示了使用哪一種解析器。前兩個字符 `#!` 被稱為 **Shebang**。在計算機領域中，Shebang 是由 `#` ( 井字號 ) 和 `!` ( 驚嘆號 ) 組成的，通常出現在文字檔案的第一行前兩個字元。

在檔案中存在 Shebang 的情況，類 Unix 作業系統的程式載入器會分析 Shebang 後的的內容，將這些內容作為直譯器指令，並呼叫該指令，將載有 Shebang 的檔案路徑作為該直譯器的參數。

在 Shebang 之後的的內容**中間沒有空格**，代表解析器的路徑。

* [Shebang 補充](https://www.delftstack.com/zh-tw/howto/linux/shebang-in-bash-script/)

###### Line 3 & Line 4
`#` 後面都是註解，不會被解析器執行，通常最好包含 user name、編寫腳本的日期以及此腳本的功能。

###### Line 6
使用 `echo` 將放在該指令後的任何內容作為命令行參數印在畫面上。

###### Line 9
腳本必須有 execute 權限才可以被執行。

###### Line 12
執行腳本，後面會解釋為何需要打 `./`。

## Important Points 
#### The Shebang
指 `#!` 這兩個字符，作用：
  * 告訴系統使用哪一個解析器
  * 是腳本中的第一行
  * 中間沒有任何空格
  * Shebang 告訴系統之後解析器要使用的路徑

如果不知道解析器在哪，可以使用 `which` 來查找。

```
which <program>
```

```
localhost:~# which bash
/bin/bash
localhost:~# which ls
/usr/bin/ls
```

如果沒有 Shebang 這行，Bash Script 仍然有效。因在沒有指定的情況下，大部分的 shell ( 包括 bash ) 將預設自己是解析器。

當其他人當前的 shell 中解析器非 bash 的環境下執行腳本時，很有可能造成意料之外的結果。

#### The Name
> Linux is an extensionless system.

&rarr; 一個不看附檔名的系統???

總之，通常我們會在腳本後加上 `.sh` 的附檔名，但這純粹只為了方便，副檔名加不加都無所謂。也就是說如果腳本叫做 `testScript` 或 `testScript.jpg` 它依然可以正常運行。

#### Comment
* 在 Linux 系統中是用 `#` 開頭
* 可以放在開頭或尾端

```
localhost:~# cat myscript.sh
#!/bin/bash
# A comment which takes up a whole line
ls # A comment at the end of the line
```

#### Why the `./` ?
Linux 系統會這樣設置主要是出於一些邏輯性原因。當我們在命令行輸入指令，系統會運行一系列預設的目錄來尋找我們指定的程序。我們可以透過查看特定變量  `PATH` 來找出這些目錄。

```
localhost:~# echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

系統在第一個目錄中找不到指定程序，就會一個一個往下檢查。每個目錄之間用 `:` ( 冒號 ) 分隔。

系統不會在這些目錄之外查找，甚至是當前所在的目錄也是。所以我們可以直接指定要查找的路徑來覆蓋原本預設的行為。在前面的章節 ( 大概是第二章 )，`.` ( full stop ) 代表當前所在的目錄，所以 `./testScript.sh` 就是告訴系統在當前的目錄中查找腳本，`PATH` 也可以帶入絕對/相對路徑。

在沒有這種機制的情況下，在當前目錄中運行腳本，很有可能會因為某人在特定目錄中創建惡意腳本並將其命名為 `ls` 或類似名稱的檔案，導致在無意間執行它。

#### Permissions
在執行腳本前必須具有 execute 權限，沒有的話可以執行 `chmod 755 <script>` 來修改。

## Variables
變數 ( variable ) 是一段簡單的儲存資料的容器，我們可以先設定變數並在之後某些情況下使用它。設至變數時，我們會先指定變數名稱，然後在等號後面賦值 ( `=` 兩邊沒有任何空格 )。而要引用變量時，必須在變量名稱前加上 `$`。

```
localhost:~# cat varScript.sh
#!/bin/bash
# A simple demonstration of variables
# Ashley 2022/06/27
 
name='Ashley'
echo Hello $name
localhost:~# ./varScript.sh
sh: ./varScript.sh: Permission denied
localhost:~# chmod 744 varScript.sh
localhost:~# ls -l varScript.sh
-rwxr--r--    1 root     root           102 Jun 27 23:52 varScript.sh
localhost:~# ./varScript.sh
Hello Ashley
```

#### Command Line Arguments and More
在運行腳本時，有一些變數會自動為我們設置。以下列出一些：
* `$0` - 腳本的名稱
* `$1` - `$9` - 傳給腳本指令的參數，`$1` 代表傳入的第一個參數值，`$2` 代表第二個，以此類推
* `$#` - 計算提供給腳本的參數個數
* `$*` - 列出所有的傳給腳本的參數值

```
localhost:~# cat moreScript.sh
#!/bin/bash
# A simple demonstration of more variables
# Ashley 2022/06/27
 
echo My name is $0 and I have been given $# command line arguments
echo Here they are: $*
echo And the 2nd command line argument is $2
localhost:~# chmod 744 moreScript.sh
localhost:~# ls -l moreScript.sh
-rwxr--r--    1 root     root           211 Jun 28 00:00 moreScript.sh
localhost:~# ./moreScript.sh bob fred sally
My name is ./moreScript.sh and I have been given 3 command line arguments
Here they are: bob fred sally
And the 2nd command line argument is fred
```

#### Back Ticks ( `\``，反引號 )
可以將執行後的輸出存到變數中 ( 感覺有點像是 JS 的 literal template 的功能 )。

```
localhost:~# cat backticks.sh
#!/bin/bash
# A simple demonstration of using backticks
# Ashley 2022/06/28
 
lines=`cat $1 | wc -l`
echo The number of lines in the file $1 is $lines
localhost:~# ls -l backticks.sh
-rwxr--r--    1 root     root           150 Jun 28 00:11 backticks.sh
localhost:~# ./backticks.sh testfile.txt
The number of lines in the file testfile.txt is 5
```

#### A Sample Backup Script
綜上所學，我們先將自己有的 projects 單獨存放到 home 目錄下名為 project 的資料夾，然後定期將這些項目輩分，存到 projectbackups 的目錄中 ( 同樣在 home 目錄下 )。

```
localhost:~# ls projects
testScript.sh
localhost:~# cat projectbackup.sh
#!/bin/bash
# Backs up a single project directory
# Ashley 2022/06/28
 
date=`date +F%`
mkdir ~/projectbackups/$1_$date
cp -R ~/projects/$1 ~/projectbackups/$1_d=$date
echo Backup of $1 completed
localhost:~# ./projectbackup.sh testScript.sh
Backup of testScript.sh completed
```

上面的範例腳本中使用相對路徑，可以使腳本更加有彈性且通用。

## If Statements
當腳本中出現錯誤時，會導致該腳本在一堆錯誤訊息中崩潰。下面將稍微示範 `If` Statements，詳細可參考 [Bash Tutorial](https://ryanstutorials.net/bash-scripting-tutorial/)。

```
1.  cat projectbackup.sh
2.  #!/bin/bash
3.  # Backs up a single project directory
4.  # Ryan 27/6/2022
5. 
6.  if [ $# != 1 ]
7.  then
8.      echo Usage: A single argument which is the directory to backup
9.      exit
10. fi
11. if [ ! -d ~/projects/$1 ]
12. then
13.     echo 'The given directory does not seem to exist (possible typo?)'
14.     exit
15. fi
16. date=`date +%F`
17.  
18. # Do we already have a backup folder for todays date?
19. if [ -d ~/projectbackups/$1_$date ]
20. then
21.     echo 'This project has already been backed up today, overwrite?'
22.     read answer
23.     if [ $answer != 'y' ]
24.     then
25.         exit
26.     fi
27. else
28.     mkdir ~/projectbackups/$1_$date
29. fi
30. cp -R ~/projects/$1 ~/projectbackups/$1_$date
31. echo Backup of $1 completed
```

###### Line 6
第一個 `if` Statement。要注意格式對不對，包含每個空格都是有意義的。這一行判斷參數數量 ( `#*` ) 是否等於 ( `!=` ) 一個。

###### Line 8
如果參數不等於一，則腳本沒有被正確的調用。同時用 `echo` 印出一條提示訊息。

###### Line 9
由於腳本沒有被正確調用，所以使用 `exit` 指令退出腳本。

###### Line 10
`fi` 表示 `if` Statement 的結束，`fi` 就是 `if` 倒過來XD。

###### Line 11
`If` 語句可以測試很多不同的東西。
* `!` - 表示否定
* `-d` - 表示"路徑存在且是目錄"

因此該行的意思是：如果給定的目錄不存在...。

###### Line 22
`read answer` 代表要求用戶輸入。`read` 可以接受一個參數，並儲存 `answer` 的變量。

#### Tip
* 上面範例中的程式碼是有縮排的，但並不強制 ( 通常建議要排版要容易閱讀 )。
* `If` Statement 實際上使用了一個名為 `test` 的命令。想要了解更多並分別他們之間的差異，可以查看 manual page。

## 小結
* `#!` - Shebang，告訴 Linux 該腳本要用哪個解析器運行

* `echo` - 在屏幕上印出一段 message

* `which` - 告訴我們特定程序的路徑

* `$` - 呼叫並使用變數時，要在變數名稱前加上 `$`

* `` ( 反引號 ) - 用於將程序的輸出保存到變量中

* `date` - 印出日期

* `if [ ] then else fi` - 執行基本的條件邏輯

##### Behaves the Same
在命令行中執行的任何操作都可以在腳本中執行，且其結果與行為完全相同。

##### Formatting
Bash Script 對於格式的要求非常嚴格，尤其需要注意空格的位置。

## 練習
寫一支能夠列出指定目錄資訊的腳本，內容包含：
1. 該目錄下有多少檔案?
2. 該目錄下有多少目錄?
3. 容量最大的檔案?
4. 近期最常異動或新增的檔案?
5. 列出目錄下所有檔案及其擁有者
6. 其他任何你能想到的...

#### 參考解答
```bash
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
```

結果：
```
localhost:~# ./practice.sh
sh: ./practice.sh: Permission denied
localhost:~# chmod 744 practice.sh
localhost:~# ./practice.sh
1. There are 7 files in directory .
2. There are 2 directories in directory .
3. The biggest file is .
4. The recent modify files are:
./.ash_history ./testScript.sh ./projects ./projects/testScript.sh ./projectback
up.sh ./projectbackups ./projectbackups/testScript.sh_F ./projectbackups/testScr
ipt.sh_d=F ./practice.sh
5. The list below current directory:
total 36 -rw-r--r-- 1 root root 114 Jul 6 2020 bench.py -rw-r--r-- 1 root root 7
6 Jul 3 2020 hello.c -rw-r--r-- 1 root root 22 Jun 26 2020 hello.js -rwxr--r-- 1
 root root 603 Jun 28 01:31 practice.sh -rwxr--r-- 1 root root 195 Jun 28 00:42
projectbackup.sh drwxr-xr-x 3 root root 103 Jun 28 00:42 projectbackups drwxr-xr
-x 2 root root 67 Jun 28 00:38 projects -rw-r--r-- 1 root root 151 Jul 6 2020 re
adme.txt -rw-r--r-- 1 root root 119 Jun 28 00:38 testScript.sh
```

## 參考
* https://ryanstutorials.net/linuxtutorial/scripting.php
* https://iter01.com/575361.html (檔案、目錄數量)
* https://www.onejar99.com/linux-command-du/ (容量大小)
* http://ailog.tw/lifelog/2021/06/16/file-search/ (近期異動的檔案)