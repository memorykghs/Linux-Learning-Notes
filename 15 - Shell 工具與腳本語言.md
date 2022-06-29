# 15 - Shell 工具與腳本語言
到目前為止，我們都是根據狀況一行一行的執行指令。但在許多情況下我們希望執行一系列的指令，並且希望它能夠依照條件使用判斷式或是迴圈等流程控制。大部分的 shell 都有自己的腳本語言，包括變數、流程控制與專屬自己的語法。


## 建立變數
在 bash 中，我們會使用 `foo=bar` 來對變數進行賦值 ( 中間沒有任何空格，因為在 shell 中空格會分隔參數 )，`foo` 是變數名稱，`var` 則是變數的值。要將變數拿出來使用時，要在變數名稱前加上 `$` 字號，如 `$foo`。

> 在 shell 中，空格都是有意義的，它會分隔參數，所以撰寫指令時需要特別注意!

bash 的字串通過 `'` 與 `"` 來定義，但這兩個有些微的不同。
* `'` - 包在單引號內的值僅代表純文字，也就是其字元本身
* `"` - 包在雙引號內的字串會被當成變數看待

範例：
```sh
foo=bar
echo "$foo"
# prints bar
echo '$foo'
# prints $foo
```

其他 Bash 腳本中常用的預設參數：
* `$0` - 腳本名稱
* `$1`-`$9` - 腳本參數。`$1` 是第一個傳入的參數，`$2`是第二個，以此類推
* `$@` 或 `$*` - 全部參數值
* `$#` - 傳入的參數數量
* `$?` - 前一條指令的傳回值
* `$$` - 目前腳本的行程 ID ( Process identification number，PID )
* `!!` - 完整的前一條指令，含有參數。一個常見情況是因爲權限錯誤導致指令失敗，此時可以使用 `sudo !!` 再嘗試一次。
* `$_` - 前一條指令的最後一個參數。如果你使用的是互動式 shell，按下 Esc 後輸入 `.` 可以獲取它。

## 流程控制
如同大多數程式語言，bash 支持包含 `if`、`case`、`while` 與 `for` 等的流程控制。bash 也支援函式，以下的例子會先建立新資料夾並 `cd` 進去。

```sh
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```

指令通常會使用 `STDOUT` 來回傳輸出，使用 `STDERR` 返回錯誤，與一個傳回值 ( Return Code ) 來表示錯誤訊息。腳本或單獨指令利用**回傳值**與**退出狀態 ( exit status )** 的形式互相溝通。 通常，傳回值爲 `0` 表示一切正常，非 `0` 的回傳值表示發生了某種錯誤。

退出代碼可以和 `&&` ( and operator ) 與 `||` ( or operator ) 共同使用，它們都是[短路 ( Short-circuit ) 求值](https://zh.wikipedia.org/wiki/%E7%9F%AD%E8%B7%AF%E6%B1%82%E5%80%BC)運算子。

同一行內的多個指令可以使用 `;` 分隔。像是 `true` 的傳回值永遠是 `0`，`false` 的傳回值永遠是 `1`。

範例：
```sh
false || echo "Oops, fail"
# Oops, fail

true || echo "Will not be printed"
#

true && echo "Things went well"
# Things went well

false && echo "Will not be printed"
#

true ; echo "This will always run"
# This will always run

false ; echo "This will always run"
# This will always run
```

## 變數替換
另一種常見的模式是以變數的形式獲取一個指令的輸出。我們可以透過指令替換 ( command substitition ) 來做這件事。當在腳本中使用 `$( CMD )` 時， 括弧內的 `CMD` 會先被執行，然後再將 `CMD` 的值回傳回來，執行整段的 `$(CMD)`。

例如，如果你執行 `for file in $(ls)` ，shell 會首先執行 `ls` 然後遍歷其傳回值。

另一個不太常見的特性是**行程替代 ( process substitution )**， `<( CMD )` 會先執行 `CMD`，將其結果存入一個暫存檔案中，再將 `<()` 替換成臨時檔案名稱。這在我們希望傳回值通過檔案而非 `STDIN` 傳送時非常有用。下面的範例將會顯示 `foo` 與 `bar` 兩個目錄中的內容。

```
diff <(ls foo) <(ls bar) 
```

下面這個範例將會使用 `grep` 搜尋字串 `foobar`，如果沒有找到，就將其作爲註釋加入到檔案中。

```sh
#!/bin/bash

# date將會被替代為日期與時間
# 不能用單引號，因為這樣將會被當成純文字印出
# 雙引號內才能有變數
echo "Starting program at $(date)" 

echo "Running program $0 with $# arguments with pid $$"

for file in "$@"; do
    grep foobar "$file" > /dev/null 2> /dev/null
    # 當字串沒有被找到，grep將會退出並返回狀態碼 1
    # 我們將標準輸出流(STDOUT)和標準錯誤流(STDERR)重新導向到Null，因為我們並不關心這些訊息
    if [[ $? -ne 0 ]]; then
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
```

在條件語句中，我們比較 `$?` 是否等於 `0`。bash 實現了許多類似的比較操作，您可以查看 [test 手冊](https://man7.org/linux/man-pages/man1/test.1.html)。在 bash 中進行比較時，盡量使用雙方括號 `[[ ]]` 而不是單方括號 `[ ]`，這樣會降低出錯的機率，儘管這樣並不能相容於 sh。更詳細的說明參見[這裡](http://mywiki.wooledge.org/BashFAQ/031)。

## globbing 通配
當執行腳本時，我們可能很常需要提供類似的參數。bash 根據文件擴展名展開表達式使我們可以輕鬆的實現這一操作。這一技術被稱為 shell 的通配 ( globbing )。

> **檔名擴展 ( filename expansion )**
在 UNIX 系統中有時難免會用上長長的路徑、檔案名稱或一大堆的檔名在指令中，所以在 shell 中提供了幾個符號來幫助我們解決這困擾。這就是檔名擴展的功能，也有人稱它為 wildcard。

* `wildcards` 萬用字元 - 當你想要利用萬用字元進行匹配時，你可以分別使用 `?` 和 `*` 來匹配一個或任意個字符。

* `Curly braces` 大括號 ( `{}` ) - 當一串指令中包含了一些 substring，可以用大括號將這些 substring 包起來，才不會影響指令。這在移動多個文件時非常方便。

```sh
convert image.{png,jpg}
# Will expand to
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# Will expand to
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# Globbing techniques can also be combined
mv *{.py,.sh} folder
# Will move all *.py and *.sh files


mkdir foo bar
# This creates files foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h
touch {foo,bar}/{a..h}
touch foo/x bar/y
# Show differences between files in foo and bar
diff <(ls foo) <(ls bar)
# Outputs
# < x
# ---
# > y
```

## 其他與注意事項
在撰寫 bash script 時可能沒有那麼的直覺，可以使用 [shellcheck](https://github.com/koalaman/shellcheck) 工具來協助 debug。

腳本並不一定只有用 bash 寫才能在終端裡調用。比如說，下面就是一個 Python 腳本，主要是將輸入的參數倒序輸出：

```sh
#!/usr/local/bin/python
import sys
for arg in reversed(sys.argv[1:]):
    print(arg)
```

shell 知道去用 Python 解析氣而不是 shell 命令來執行這段腳本，是因為開頭第一行的 Shebang 指定了 python。另外也可以在 Shebang 使用 `env` 參數來提高腳本的可移植性，因為執行時 `env` 會使用前面介紹過的 `PATH` 幻境變量。

```
#!/usr/bin/env python
```

另外需注意 shell function 和腳本有以下的差異：
* functions 只能使用跟 shell 一樣的語言，但腳本可以使用任一一種。因此在腳本中包含 `Shebang` 是很重要的。

* functions 只有在被定義時被載入，腳本則是會在每次被執行時載入。這讓 function 的載入比腳本略快一些，但每次修改 function 定義，都要重新載入一次。

* function 會在當前的 shell 環境中執行，腳本會在獨立的行程 ( process ) 中執行。因此，functions 可以對環境變數進行更改，比如改變當前工作目錄，腳本則不行。腳本需要使用 `export` 指令將環境變數導出，並將值傳遞給環境變數。

* 與其他程式語言一樣，functions 可以模組化程式碼、提高程式碼複用性與可讀性。shell 腳本中往往也會包含它們自己的 functions 定義。

## Shell Tool
* [TLDR pages](https://tldr.sh/) 是一個可以讓我們快速找到要使用哪個 option 的小工具

#### 查詢文件
```
find
```

`find` 會一層一層的搜尋符合條件的 file。
```sh
# 查詢所有名稱為src的文件夾
find . -name src -type d
# 查詢所有文件夾路徑中包含test的python文件
find . -path '*/test/*.py' -type f
# 查詢前一天修改的所有文件
find . -mtime -1
# 查詢所有大小在500k至10M的tar.gz文件
find . -size +500k -size -10M -name '*.tar.gz'
```

除了列出所尋找的文件之外，`find` 還能對所有查詢到的文件進行操作。

```sh
# 刪除所有副檔名為 .tmp 的文件
find . -name '*.tmp' -exec rm {} \;
# 轉換所有 PNG 檔為 JPG 檔
find . -name '*.png' -exec convert {} {}.jpg \;
```

儘管 `find` 用途廣泛，它的語法卻比較難以記憶。例如，為了查詢滿足的模式 `PATTERN` 的文件，需要執行 `find -name '*PATTERN*'` ( 如果希望模式匹配時是區分大小寫，可以使用`-iname` 選項 )。

[fd](https://github.com/sharkdp/fd) 就是一個比 `find` 更簡單、更快速的 program，同時支援如輸出著色、Regex、unicode 等等。

```
fd PATTERN
```

另外更有效的方法，例如不要每次都搜尋文件而是通過編譯索引或建立數據庫的方式來加快搜尋，就可以使用 `locate`。

#### `locate`
`locate` 使用一個由updatedb負責更新的數據庫，在大多數系統中 `updatedb` 都會通過 `cron` 每日更新。而 `find` 和類似的工具則是可以通過別的屬性比如文件大小、修改時間或是權限來查詢文件，`locate` 只能通過文件名。

詳情可以參考[這裡](https://unix.stackexchange.com/questions/60205/locate-vs-find-usage-pros-and-cons-of-each-other)。

## 參考
* https://missing-semester-zh-hant.github.io/2020/shell-tools/