# 09 - Filters
* Linux 設計的一個基本原則就是一個 item 一次只做一件事，且 user 可以透過將這些 item 組合在一起，達到不同的效果。

* Filter 在 Linuz Command Line 中是一種可以接受文字型態的資料，並將他們以特定方式轉換的程序 ( program )。

* Filter 是一種 access 原始資料的方法，像是由其他程式生成的、或是儲存在 file 內的資料等等，然後對其進行操作，在以更適合的方式顯示。

* 由於 Filter 後面也可以接一些 option，所以可以查詢 `man page`。

以下將介紹一些比較常用的 Filters。

## head
預設印出指定檔案的前 10 行。可以透過 option 調整行數。

```
head [-number of lines to print] [path]
```

範例一：
```
localhost:/home# head sampleData.txt
Fred apples 20
Susy oranges 5
Mark watermellons 12
Robert pears 4
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
```

範例二：
```
localhost:/home# head -4 mysampledata.txt
Fred apples 20
Susy oranges 5
Mark watermellons 12
Robert pears 4
```

## tail
和 `head` 相反，預設印出指定檔案的最後 10 行。

```
tail [-number of lines to print] [path]
```

範例一：
```
localhost:/home# tail sampleData.txt
Mark watermellons 12
Robert pears 4
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
Oliver rockmellons 2
Betty limes 14
```

範例二：
```
localhost:/home# tail -3 mysampledata.txt
Fred apples 20
Susy oranges 5
Mark watermellons 12
```

## sort
將指定的檔案的內容依照字母順序排序。
```
sort [-options] [path]
```
```
localhost:~# sort sampleData.txt
 
Anne mangoes 7
Betty limes 14
Greg pineapples 3
Lisa peaches 7
Mark grapes 39
Mark watermellons 12
Oliver rockmellons 2
Robert pears 4
Susy oranges 12
Terry oranges 9
```

也可以用 options 來依照需求設定不同的排序方法 ( 可以查 man pages )。

## nl
number lines 的縮寫，為文件內的每一行標上行數顯示。
```
nl [options] [path]
```
```
localhost:~# nl sampleData.txt
    1  Mark watermellons 12
    2  Robert pears 4
    3  Terry oranges 9
    4  Lisa peaches 7
    5  Susy oranges 12
    6  Mark grapes 39
    7  Anne mangoes 7
    8  Greg pineapples 3
    9  Oliver rockmellons 2
    10  Betty limes 14
```

也可接受一些格式來自定如何顯示。
ex：
```
localhost:~# nl -s '.' -w 10 sampleData.txt
    1.Mark watermellons 12
    2.Robert pears 4
    3.Terry oranges 9
    4.Lisa peaches 7
    5.Susy oranges 12
    6.Mark grapes 39
    7.Anne mangoes 7
    8.Greg pineapples 3
    9.Oliver rockmellons 2
    10.Betty limes 14
```

* `-s` - 指定在數字後面要印出的符號
* `-w` - 數字與文字之間的 padding 距離

## wc
word count 的縮寫，計算字數。

```
wc [-option] [path]
```
```
localhost:~# wc sampleData.txt
11        30       168 sampleData.txt
```

<br/>

* 當單純只想知道多少單字或是多少字母，可以搭配 `-l`、`-m`、`-w` 等指令執行
  * `-l` - lines
  * `-w` - words
  * `-m` - characters

```
localhost:~# wc -l -w sampleData.txt
11        30 sampleData.txt
```
<br/>

* 這些 option 也可以被合併，如：`wc -lw sampleData.txt`
```
localhost:~# wc -wl sampleData.txt
11        30 sampleData.txt
```
## cut
剪下某段文字，當想要撿取的內容是類似表格之類的內容時，`cut` 很好用。
```
cut [-option] [path]
```
```
localhost:~# cut -f 1 -d ' ' sampleData.txt
Mark
Robert
Terry
Lisa
Susy
Mark
Anne
Greg
Oliver
Betty
```

* `-f` - fields，指定欄位用，欄位由左到右從 1 開始。多個欄位的話可以用逗號區分。
* `-d` - 後面接切分符號，類似於 split 指定切分的依據

指定多欄位：
```
localhost:~# cut -f 1,2 -d ' ' sampleData.txt
Mark watermellons
Robert pears
Terry oranges
Lisa peaches
Susy oranges
Mark grapes
Anne mangoes
Greg pineapples
Oliver rockmellons
Betty limes
```

## sed
Stream Editor 的縮寫，用於搜尋和取代資料。

```
sed <expression> [path]
```
基本的表達式 ( exprssion ) 如下：
```
s/serch/replace/g
```
* `s` - 替代並指定要執行的操作
* `serach` - 放要搜尋的文字
* `replace` - 想替換成的文字
* `g` - ( 非必要 ) global，代表全文。如果沒有放的話將只會替換第一個找到的結果。

```
localhost:~# sed 's/oranges/apples/g' sampleData.txt
Mark watermellons 12
Robert pears 4
Terry apples 9
Lisa peaches 7
Susy apples 12
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
Oliver rockmellons 2
Betty limes 14
```
上面的範例代表將原本內文的 oranges 換成 apples。

* `sed` 識別的不是單字，而是字串 ( Strings of characters )。
* 搜尋的一些條件其實也就是表達式，將搜尋的表達式包在單引號中，是為了避免某些特殊符號被當作指令的一部份執行

## uniq
unique 的縮寫，移除檔案中重複的內容。但有一個限制是這些內容必須是相鄰的 ( 即一個接著一個的 )。

```
unique [options] [path]
```

向下面這個例子，在第二個段落也有 Susy oranges 5 的文字，但是在執行 `uniq` 後沒有被移除，代表移除的範圍是以一個連續的段落為主。
```
localhost:~# uniq sampleData.txt
Fred apples 20
Susy oranges 5
Mark watermellons 12
Robert pears 4
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
Oliver rockmellons 2
Betty limes 14
 
Susy oranges 5
```
`uniq` 執行結束後，並不會異動到原本的檔案，只是將文字過濾出來顯示。

## tac
`cat` 倒過來就是 `tac` XD。跟 `cat` 功能完全相反，同樣是會印出檔案內容，但從最後一行開始印。

```
tac [path]
```
```
localhost:~# tac sampleData.txt
Susy oranges 5
Susy oranges 5
 
Betty limes 14
Oliver rockmellons 2
Greg pineapples 3
Anne mangoes 7
Mark grapes 39
Mark grapes 39
Susy oranges 12
Lisa peaches 7
Terry oranges 9
Robert pears 4
Mark watermellons 12
Susy oranges 5
Susy oranges 5
Susy oranges 5
Fred apples 20
```


## Others 
另外兩個值得研究的 program。
* [awk](https://ryanstutorials.net/linuxtutorial/bonus.php#awk)
* diff

## 小結
| 指令 | 說明 |
| --- | --- |
| `head` | View the first n lines of data. |
| `tail` | View the last n lines of data. |
| `sort` | Organise the data into order. |
| `nl` | Print line numbers before data. |
| `wc` | Print a count of lines, words and characters. |
| `cut` | Cut the data into fields and only display the specified fields. |
| `sed` | Do a search and replace on the data. |
| `uniq` | Remove duplicate lines. |
| `tac` | Print the data in reverse order. |

## Important Concepts
* Processing - Filters allow us to process and format data in intersting ways.
* man pages - Most of the programs we looked at have command line options that allow you to modify their behaviour.

## 參考
* https://ryanstutorials.net/linuxtutorial/filters.php