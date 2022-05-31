# 03 - Manual Pages
Manual Pages 是一組頁面，解釋了系統上可用的指令，包括他們的功能、執行他們的細節，以及可以接受的命令參數。即類似於指令的說明書，可以查詢該指令的功能以及可以加什麼參數。

```
man <command to look up>
```

* 可以使用 `q` 離開 manual pages
* 有 long hand ( `--` ) 和 short hand ( `-` ) 之分
  ```
  ls -a
  ls --all
  ls -alh
  ```

使用 `man` 列出指令內容：
```
localhost:~# man ls
Name
    ls - list directory contents
 
Synopsis
    ls [option] ... [file] ...
 
Description
    List information about the FILEs (the current directory by default). Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.
 
    Mandatory arguments to long options are mandatory for short options too.
 
    -a, --all
        do not ignore entries starting with .
 
    -A, --almost-all
        do not list implied . and ..
    ...
```

另外如果不太知道要用什麼指令來達成目的，可以使用關鍵字搜索。
```
man -k <search term>
```

而進入 manual pages 之後想要搜尋文檔中的內容時，可以輸入 `/` 並在後面輸入要搜尋的單字，然後按 `Enter`。如果關鍵字出現多次，可以按下 `n` 往下繼續瀏覽。

## 小結
* `man <command>` - 在 manual page 中搜尋特定指令
* `man -k <search term>` - 在 manual page 中使用關鍵字搜尋
* `/<term>` - Within a manual page, perform a search for 'term'
* `n` - After performing a search within a manual page, select the next found item.

## 參考
* https://ryanstutorials.net/linuxtutorial/manual.php

