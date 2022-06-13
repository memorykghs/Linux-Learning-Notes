# 07 - Wildcards
用來建立一些 pattern 所使用的建築模塊 ( building blocks )，幫助我們定義一組目錄或文件的格式

* `*` - zero or more characters
* `?` - a single character
* `[]` - a range of characters

```
localhost:~# ls
Documents   bench.py    hello.c     hello.js    readme.txt
localhost:~# ls *s
hello.js
 
Documents:
firstfile.txt   secondfile.txt
```

## Some More Examples
##### Example 1
```
localhost:~# ls /home/ryan/linuxtutorialwork/*.txt             
/home/ryan/linuxtutorialwork/barry.txt /home/ryan/linuxtutorialwork/blah.txt
```

##### Example 2
```
localhost:~# ls ?i*
firstfile video.mpeg
```

##### Example 3
```
localhost:~# ls *.???
barry.txt blah.txt example.png frog.png
```

##### Example 4
```
localhost:~# ls [sv]*
secondfile video.mpeg
```

##### Example 5
```
localhost:~# ls [^a-k]*
secondfile thirdfile video.mpeg
```

##### Example 6
`[]` 裡面篩選的關鍵字不需要連在一起，只要有出現就好。
```
localhost:~# ls [sv]*
secondfile video.mpeg
```

## Some Real World Examples
先辨別此目錄下有哪些東西。
```
localhost:~# file /home/ryan/*
bin: directory
Documents: directory
frog.png: PNG image data
public_html: directory
```

移動所有是 jpg 或 png 的檔案到另外一個目錄。
```
localhost:~# mv public_html/*.??g public_html/images/
```

最後列出這些檔案的大小與異動時間。
```
localhost:~# ls -lh /home/*/.bash_history
-rw------- 1 harry users 2.7K Jan 4 07:32 /home/harry/.bash_history
-rw------- 1 ryan users 3.1K Jun 12 21:16 /home/ryan/.bash_history
```

## 練習
可以在 Linux 系統中 `/etc` 目錄下做練習，因為他是存放 Linux 系統的 config files，使用者無法隨意地變更它。


> 1. 列出所有 `/etc` 目錄下所有有副檔名的檔案
```
ls /etc/*.*
```
<br/>

> 2. 列出 `/etc` 中副檔名為三個字的檔案
```
/etc/*.???
```
<br/>

> 3. 列出 `/etc` 中檔名中有大寫的檔案 ( hint: `[[:upper:]]` may be useful here )
```
ls /etc/[[:upper:]]
```
最後有沒有加 `*` 有差嗎??? ( `ls /etc/[[:upper:]]` )
<br/>

> 4. 列出 `/etc` 中檔名長度為 4 個字元的檔案
```
/etc/????
```

## 小結
* **Anywhere in any path** - Wildcards 可以被用在任何跟 `path` 有關的地方
* **Wherever a path is used** - 因為 Wildcards 的替換是由系統完成的，所以可以在使用路徑的任何地方使用它們。

## 參考
* https://ryanstutorials.net/linuxtutorial/wildcards.php