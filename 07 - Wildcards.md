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
> 1. A good directory to play with is /etc which is a directory containing config files for the system. As a normal user you may view the files but you can't make any changes so we can't do any harm. Do a listing of that directory to see what's there. Then pick various subsets of files and see if you can create a pattern to select only those files.


> 2. Do a listing of /etc with only files that contain an extension.
```
ls /etc/*.*
```

> 3. What about only a 3 letter extension?
```
/etc/*.???
```

> 4. How about files whose name contains an uppercase letter? ( hint: `[[:upper:]]` may be useful here )
```
ls /etc/*[[:upper:]]*
```
最後有沒有加 `*` 有差嗎???

> 5. Can you list files whose name is 4 characters long?
```
/etc/[????]
```

## 小結
* **Anywhere in any path** - Wildcards 可以被用在任何跟 `path` 有關的地方
* **Wherever a path is used** - 因為 Wildcards 的替換是由系統完成的，所以可以在使用路徑的任何地方使用它們。

## 參考
* https://ryanstutorials.net/linuxtutorial/wildcards.php