# 10 | Grep and Regular Expressions
Regular 和 Wildcards 雖然使用的字元差不多，半他們的行為仍有些微的不同。

## eGrep
eGrep 是一個可依據輸入的 pattern 搜尋和印出的一個程序，同時也是 `grep` 的擴充。

```
egrep [command line options] <pattern> [path]
```

通常會將要查的 pattern 用單引號包住，尤其是一些可能被當作指令執行的特殊字元。

範例一：
```
localhost:~# cat sampleData.txt
Fred apples 20
Susy oranges 5
Susy oranges 5
Susy oranges 5
Mark watermellons 12
Robert pears 4
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Mark grapes 39
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
Oliver rockmellons 2
Betty limes 14
 
Susy oranges 5
Susy oranges 5

localhost:~# egrep 'mellon' sampleData.txt
Mark watermellons 12
Oliver rockmellons 2
```

範例二：
```
localhost:~# egrep -n 'mellon' sampleData.txt
5:Mark watermellons 12
14:Oliver rockmellons 2
```

* `-n` | 顯示行數

範例三：
```
localhost:~# egrep -c 'mellon' sampleData.txt
2
```
* `-c` | 印出共找到幾行

當使用 `grep` 或 `egrep` 沒有出現結果時：
1. 檢查是否打錯字 ( typos )
2. 可能是用錯指令，某些指令也許不是你想的那樣
3. 一個一個拆掉 pattern 檢查

p.s. 有一個可以幫助理解的 Regex 小套件 Debuggex。

> Q. eGrep 跟 grep 有什麼關係?

> Q. grep 底層怎麼去查的?

## grep
`grep` = global search regular expression (RE) and print out the line，全面搜尋政則表達式並將結果打印出來

## Regular Expression Overview
| Regex | 說明 |
| --- | --- |
| `.` (dot) |  a single character. |
| `?` | the preceding character matches 0 or 1 times only. |
| `*` | the preceding character matches 0 or more times. |
| `+` | the preceding character matches 1 or more times. |
| `{n}` | the preceding character matches exactly n times. |
| `{n,m}` | the preceding character matches at least n times and not more than m times. |
| `[agd]` | the character is one of those included within the square brackets. |
| `[^agd]` | the character is not one of those included within the square brackets. |
| `[c-f]` | the dash within the square brackets operates as a range. In this case it means either the letters c, d, e or f. |
| `()` | allows us to group several characters to behave as one. |
| `|` (pipe symbol) | the logical OR operation. |
| `^` | matches the beginning of the line. |
| `$` | matches the end of the line. |

## Samples
```
localhost:~# cat sampleData.txt
Fred apples 20
Susy oranges 5
Susy oranges 5
Susy oranges 5
Mark watermellons 12
Robert pears 4
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Mark grapes 39
Mark grapes 39
Anne mangoes 7
Greg pineapples 3
Oliver rockmellons 2
Betty limes 14
```

範例一：含有 aeiou 英文字母且其中一個出現兩次以上。
```
localhost:~# egrep '[aeiou]{2,}' sampleData.txt
Robert pears 4
Lisa peaches 7
Anne mangoes 7
Greg pineapples 3
```

範例二：過濾出含有 2 且 2 後面還有一個字的內容。
( `.` 代表單一字元，`+` 代表後面的字元鄰接 2 )
```
localhost:~# egrep '2.+' sampleData.txt
Fred apples 20
```

範例三：過濾尾端出現 2 的內容。
( `$` 代表出現在尾端 )
```
localhost:~# egrep '2$' sampleData.txt
Mark watermellons 12
Susy oranges 12
Oliver rockmellons 2
```

範例四：過濾出現 `or` 或 `is` 或 `go` 的內容。
```
localhost:~# egrep 'or|is|go' sampleData.txt
Susy oranges 5
Susy oranges 5
Susy oranges 5
Terry oranges 9
Lisa peaches 7
Susy oranges 12
Anne mangoes 7
Susy oranges 5
Susy oranges 5
```

範例五：過濾開頭為 A 到 K 的內容。
```
localhost:~# egrep '^[A-K]' sampleData.txt
Fred apples 20
Anne mangoes 7
Greg pineapples 3
Betty limes 14
```

## 參考
* https://ryanstutorials.net/linuxtutorial/grep.php
