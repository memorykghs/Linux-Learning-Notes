# 01 - Basic Navigation
## The Shell, Bash
* 不同的 OS 定義他們的終端會如何運作 ( behave ) 與執行 ( running / executing commands )
* 最常見的是 bash ( stands for Bourne again shell )
* 如果想要知道目前使用的 shell 是哪一個，可以使用 `echo`

```
echo $SHELL
```
↑ `echo` 是用來顯示訊息的。

## Navigation
#### pwd
* Print working directory 印出所在的目錄路徑
```
localhost:~/Documents# pwd 
/root/Documents
```
## ls
```
ls [option][location]
```
* 列出當前目錄下有什麼檔案 ( what's in our current location? )
* `ls` = list

```
localhost:~# ls Documents/

localhost:~# ls
Documents   bench.py    hello.c     hello.js    readme.txt

localhost:~# ls -l
total 20
drwxr-xr-x    2 root     root            37 May 26 22:17 Documents
-rw-r--r--    1 root     root           114 Jul  6  2020 bench.py
-rw-r--r--    1 root     root            76 Jul  3  2020 hello.c
-rw-r--r--    1 root     root            22 Jun 26  2020 hello.js
-rw-r--r--    1 root     root           151 Jul  6  2020 readme.txt
```

![](/images/1-1.png)

## path
* 分成 **Absoute** & **Relative** Path
* Linux 中的 file system 是一個分層式的架構 ( hierachical structure )

![](/images/1-2.png)

#### 絕對路徑 Absolute Path
從 root directory 開始，以斜線 `/...` 開始。
```
localhost:~# ls /home/ryan/Documents
file1.txt file2.txt file3.txt
```

#### 相對路徑 Relative Path
不由斜線開始，根據當前下指令的所在目錄往下搜尋符合的目錄或檔案。
```
localhost:~# ls Documents/
file1.txt file2.txt file3.txt
```

## More on Paths
* `~` ( tilde，波浪號 ) - home 目錄的簡寫，ex：`/home/app/Documents` → `~/Documents`
* `.` ( dot ) - 參考到目前所在的目錄，使用相對路徑時也可以用。ex：`Documents` → `./Documents`
* `..` ( dot dot ) - 參考到當前所在的目錄的上一層位置 ( parent directory )

## cd - Move Around
```
cd [location]
```
* 如果後面沒有任何參數，那麼會直接回到 home 目錄

## 在 Linux System 的一些資料夾
| 目錄 | 說明 |
| --- | --- |
| `/etc` | Stores config file for the system. |
| `var/log` | Stores log files for various system programs. ( 但可能不會每個資料夾都有權限進去 )
| `/bin` | The location of several commoly used programs. |
| `/usr/bin` | Another location for programs in the system. |

## 💡 用四種不同的方式回到 home 目錄
1. `cd ~`
2. `cd home`
3. `cd /home`
4. ???

## 參考
* https://ryanstutorials.net/linuxtutorial/commandline.php