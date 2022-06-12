# 06 - Vi Text Editor
* Vi is intend as a plain text editor
* powerful than Notepad or Textedit
* 有兩種模式：
    * **Insert ( Input )** - insert or input edit
    * **Edit**
        * move around the file
        * delete
        * copying
        * search
        * replace
        * saving

## 進入 Vi 模式
```
vi <file>
```

ex：
```
vi firstfile
```

* 打開指定的檔案
* 若檔案不存在，會先建立檔案，再進入 Vi 模式
* 按下 `i` 會進入 INSERT 模式
  ```
  ~
  ~
  ~
  ~
  -- INSERT --
  ```
* 按 `Esc` 可退出 INSERT 模式並回到 EDIT 模式
* 在 EDIT 模式下按下 `Esc` 不會有反應，也可以用來確認當前的模式

> Q 給不給副檔名的差別?

![](/images/6-1.png)

在 Linux 系統中，有沒有包含副檔名是有極大差別的，如果該目錄下有一個 `firstfile.txt`，這時候執行 `vi firstfile` 相當於是建立一個新的沒有副檔名的檔案叫做 `firstfile`。

如果真的要對 `firstfile.txt` 檔案編輯，那麼就要連附檔名都打出來 `vi firstfile.txt`。

## Navigating a File
在 EDIT 模式下使用以下指令。

| 指令 | 說明 |
| --- | --- |
| `Arrow keys` | move the cursor around |
| `j`, `k`, `h`, `l` | move the cursor down, up, left and right ( similar to the arrow keys ) |
| `^` ( caret ) | 移到當前游標所在行的開頭 |
| `$` | 移到當前游標所在行的尾端 |
| `nG` | 移動到指定行數位置，ex：`5G` 就是移動到第五行 <br/> p.s. 在 EDIT 模式下，按下 `數字 + shift + g` |
| `G` | 按下 `shift + g`，移動到該文件最後一行 |
| `w` | 移動到下一行開頭 |
| `nw` | 往下移動 n 個單字，ex：`2w` 代表往下移動 2 個單字 |
| `b` | 移動到前一個單字的開頭 |
| `nb` |移動到前 n 個單字的開頭 |
| `{` | 移動到前一個段落 ( 中間有空一行的話代表一個段落 ) |
| `}` | 移動到後一個段落 |

## Saving and Exiting
在 INSERT 模式下：
* `ZZ` ( 雙大寫 ) - Save and exit
* `:q!` - 捨棄所有變更，回到前一次的儲存狀態，並對初 INSERT 模式
* `:w` - 儲存但不會出 INSERT 模式
* `:wq` - 儲存並退出 INSERT 模式

在 EDIT 模式下：
* `ZZ` - 先保存後退出
* `ZQ` - 強制退出

## Deleting Content
* `x` - 刪除單一字元
* `nx` - 刪除 n 個字元，ex：`5x` 代表刪除 5 個字元
* `dd` - 刪除當前所在的行
* `dn` - 按下 `d` 之後後面接著 movement command，會刪除 movement command 指定的範圍

## Undoning 回復變更
* `u` - 回復上一變更
* `U` ( 大寫 ) - 回復當前游標在的這行的所有變更

## Taking it Further
* 可以使用 `vi <insert concept here>` 查詢想要的功能
* 也可以藉由 vi cheat sheet 來查詢下面的指令： 
  * copy and paste
  * search and replace
  * buffers
  * markers
  * ranges
  * settings

## Other Ways to View Files
在 Linux 系統中有 2 種方式：
* `cat`
* `less`

### `cat <file>`
* `cat` 是 concatenate 的縮寫，旨在 join files together
* 不過此指令的基本形勢對於查看文件很方便
```
localhost:~/Documents# cat firstfile.txt
Lorem ipsum dolor sit amet
consectetur adipiscing elit. Nunc mollis
magna sed ullamcorper scelerisque
arcku felis tempor est
sit amet molestie urna nulla eu augue
 
Donec mi arc
volutpat nec sem volutpa
fringilla posuere ipsum
Suspendisse semper nibh quis tortor iaculis convalli
Praesent dapibus sagittis mi sed ullamcorpe
```

> Q. `cat` 不存在的 file 的結果?

會顯示找不到此檔案 No such file or directory。
```
localhost:~/Documents# cat secondfile.txt
cat: can't open 'secondfile.txt': No such file or directory
```
<br/>

* `cat` 後面沒有接任何參數時會發欠 cursor 移動到下一行，且不會發生任何事。由於沒有接任何參數，所以預設會去讀 `STDIN` ( 終端輸入 ) 的指令。
* 想要退出可以按 `ctrl + c` ( Universal signal for CANCEL in Linux )

### `less <file>`
* 當檔案較大時，可以使用
  1. 可以 move up 和 move down ( 可以在文件中使用 `↑`、`↓` 移動 )
  2. `space` - 換到下一頁
  3. `b` - 回到上一頁
  4. `q` - 離開檢視文件模式

## 參考
* https://ryanstutorials.net/linuxtutorial/vi.php
* https://kknews.cc/zh-tw/tech/ovpjz6m.html