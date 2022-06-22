# 11 - Piping and Redirection
每一個我們值型的指令都與三種 Data Stream 有關：
1. STDIN (0) - standard input ( 標準輸入 )，餵給 program 的資料
2. STDOUT (1) - standard output ( 標準輸出 )，由 program 輸出的資料，預設輸出到 termianl
2. STDERR (2) - standard error ( 標準錯誤 )，用於印出錯誤訊息，默認輸出到 terminal

![](/images/11-1.png)

Piping 和 Direction 可以將 program 與 file 之間的 Stream 連接起來進行一些資料的操作。

## Redirecting to a File
* 大部分的時候，我們操作的結果會直接被印在 terminal 上。
* 當有需要將操作的結果寫入 file 的話，可以使用 `>` 操作符 ( 但結果將不會印在 terminal 上 )

```
localhost:~# ls
bench.py    hello.c     hello.js    readme.txt

localhost:~# ls > myLog.txt

localhost:~# cat myLog.txt
bench.py
hello.c
hello.js
myLog.txt
readme.txt
```

#### Some Observations
在上面的範例中，可以發現直接輸出在 terminal 上是一行的，但將結果 redirect 到 file 中，卻是斷行的。這是因為螢幕 ( screen ) 的寬度是已知的，所以程序可以格式化內容並印出。

但是當 redirect 時，目的可能是一個檔案或是其他的地方，最安全的方式是將每一個結果分段為一行，這樣也讓我們可以更方便的察看內容或進行其他操作。


#### Tip
當 piping 或 directing 時，原本的資料並不會被異動，但格式化出來的結果很有可能跟原資料不同。

## Saving to an Existing File
將當前的 STDOUT 存入已存在檔案時，該檔案原本的內容會被清空，再存入新的資料。

```
localhost:~# cat myLog.txt
bench.py
hello.c
hello.js
myLog.txt
readme.txt

localhost:~# wc -l myLog.txt > myLog.txt

localhost:~# cat myLog.txt
0 myLog.txt
```

如果想保留原本檔案的資料，並將印出的結果串接在最後，可以使用 `>>`。

```
localhost:~# cat myLog.txt
0 myLog.txt

localhost:~# cat myLog.txt
0 myLog.txt

localhost:~# ls >> myLog.txt

localhost:~# cat myLog.txt
0 myLog.txt
bench.py
hello.c
hello.js
myLog.txt
readme.txt
```

## Redirecting from a File
`<` 操作符與 `>` 相反，可以將檔案中的內容當成 STDIN 餵給指定的 program 並顯示

```
localhost:~# wc -l myLog.txt
6 myLog.txt

localhost:~# wc -l < myLog.txt
6
```

上面的例子使用 `wc` 對 `myLog.txt` 檔案計算行數，然後再 redirect 到一個新的檔案中。

但可以發現 redirect 到 `wc` 時，不會將原檔名給印出來。原因是因為在 piping 或 redirecting 時，數據都是匿名發送的。`wc` 只單純收到要處理的內容，但不知道來自哪裡。

另外，也可以結合兩個重定向操作符一起使用。

```
localhost:~# cat test.txt
1
2
3
4
5

localhost:~# wc -l < test.txt >> myLog.txt

localhost:~# cat myLog.txt
0 myLog.txt
bench.py
hello.c
hello.js
myLog.txt
readme.txt
6
5
```

## Redirecting STDERR
當想印出 STDERR 也是使用 `>` 操作服，不過由於 `>` 預設是 STDOUT，所以我們會用數字 ( 像上面寫的三個 Stream 都有自己對應的數字，STDERR 對應到的是 2 ) 來代表 redirect 到哪一個 Stream。

```
localhost:~#ls
bench.py    hello.c     hello.js    readme.txt

localhost:~# ls -l video.mpg
ls: video.mpg: No such file or directory

localhost:~# ls -l vedio.mpg 2> errors.txt

localhost:~# cat errors.txt
ls: vedio.mpg: No such file or directory
```

當想要同時儲存正常的 output 以及 error message 到同一個檔案中，可以先 redirect STDERR 到 STDOUT Stream，然後再將 STDOUT Stream redirect 到檔案中。

1. 先 redirect file
2. 再 redirect error stream

```
localhost:~# ls -l vedio .mpg > myoutput 2>&1

localhost:~# cat myoutput
ls: vedio: No such file or directory
ls: .mpg: No such file or directory
```

在指令中，要 redirect stream 到另一個 stream 的話，要在 stream number 前加上 `&`，否則預設會導入一個叫做 `1` 的 file 內。

## Piping
* 主要是由一個 program 將資料傳遞給另一個 program，這個機制就是 pipe。

* 使用的操作符為 `|`，邏輯是將左側 program 輸出的結果提供給左側的 program。

範例一：
```
localhost:~# ls
bench.py    hello.c     hello.js    myLog.txt   readme.txt  test.txt

localhost:~# ls | head -3
bench.py
hello.c
hello.js
```

範例二：
```
localhost:~# ls
bench.py    hello.c     hello.js    myLog.txt   readme.txt  test.txt
localhost:~# ls | head -3 | tail -1
hello.js
```

#### Tip
任何為程序提供的命令參數都必須接在該程序旁邊。

```
ls | head -3 | tail -1
```

如上面的 `head -3`，其中 `-3` 就是要針對 `head` 指令進行一些操作，必須以一個空白連接。

piping 與 redirect 可以同時使用。

```
localhost:~# ls | head -3 | tail -1 > myLog.txt
localhost:~# cat myLog.txt
hello.js
```

## 參考
* https://ryanstutorials.net/linuxtutorial/piping.php