# 02 - More About Files
在 Linux System 內，所有的東西都是一個 file：
* text file
* directory
* keyboard
* monitor
...

✨此概念幫助理解 Linux 的行為以及怎麼管理檔案和目錄。

在其他的作業系統中，例如 Windows，檔案都會加上附檔名 ( file extension ) 用以辨識檔案類型。但是在 Linux 系統中，會忽略所有檔案的副檔名，需要查看文件內容來確認是什麼類型的檔案。

ex：假設現在有一個圖檔 `myself.png`，在 Linux 系統中可以自由地將其名稱改為 `myself.txt`，而 Linux 仍然知道它是一個圖片檔。

基於以上原因，我們較難在 Linux 系統中辨識這是什麼類型的檔案，因此 Linux 提供了 `file` 指令來幫助我們判別。

## file
```
file [path]
```
* 用以取得檔案或目錄的類型

```
localhost:~# ls
Documents   bench.py    hello.c     hello.js    readme.txt

localhost:~# file Documents/
Documents/: directory

localhost:~# file hello.js
hello.js: ASCII text
```

## Linux is Case Sensitive
在 Linux 中大小寫是有區分的。

## Spaces in Names
當目錄或資料夾的名稱是帶有空白的，如 `Holiday Photos`，執行 `cd Holiday Photos` 會失敗，因為中間空白是被用來區分指令物件的。要解決此問題有兩種方式：

1. Quotes ( 在這邊單雙引號都可以 )
    ```
    localhost:~/Documents# cd 'Holiday Photos'

    localhost:~/Documents/Holiday Photos# pwd
    /root/Documents/Holiday Photos
    ```

2. Escape Characters ( 跳脫字元 )
```
localhost:~/Documents# cd Holiday\ Photos

localhost:~/Documents/Holiday Photos# pwd
/root/Documents/Holiday Photos
```

## 參考
* https://ryanstutorials.net/linuxtutorial/aboutfiles.php