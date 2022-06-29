# 14 - The Shell
## Shell 是什麼?
電腦有各種介面來讓我們輸入指令，精美的圖形化介面，語音輸入，甚至是AR/VR介面已經無處不在。這些介面可應用在80%的使用場景，但從根本上限制了你能做的事情————你無法點選不存在的按鈕或者用語音輸入從未收錄的指令。為了充分利用電腦的功能，我們不得不回到最根本的方式，使用純文字介面：Shell。

這邊會使用 **Bourne Again SHell ( 簡稱 "bash" )**，是使用最廣泛的 shell 之一，其語法與許多其他 shell 相似。

## 使用 Shell
使用終端時，會看到一個*提示自元*，像下面這樣：
```
localhost:~$
```

這是 shell 的主要文字介面，包含以下資訊：

* `localhost` - 主機名稱
* 接在 `localhost` 後面的是「目前的工作目錄 ( directory )」，`~` 代表目前位置是「home」目錄
* `$` - 代表現在不是 root user

接下來在 shell 執行簡單的指令。
範例一：
```
localhost:~$ date
Wen 29 Jun 2022 11:49:31 PM EST
```

範例二：
```
localhost:~$ echo hello
hello
```

shell 如何知道怎樣找到 `date` 或 `echo` 程式?由於 shell 是一個開發環境，所以他具備一些預設的變數、條件、迴圈和函式。當你在 shell 內執行指令時，實際上是在寫一段可以被 shell 解析的程式碼。shell 被要求去執行非程式關鍵字的指令時，它會去查詢**環境變數 ( environment variable ) `$PATH`**，`$PATH` 會指出當 shell 收取某指令時，依照預設的路徑尋找對應的程式。 

```
localhost:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
localhost:~$ which echo
/bin/echo
localhost:~$ /bin/echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

當我們執行 `echo` 指令時, shell 會知道它應該執行 `echo`， 然後它會在 `$PATH` 中根據該名稱搜索由 `:` 分隔的一系列目錄。當 shell 找到程式時，shell 會執行它 ( 如果此檔案是可執行的 ( executable )）。

也可以使用 `which` 來找出該程序對應的是哪個檔案。當然也可以繞過 `$PATH`，透過直接指定程式的**路徑 ( path )** 來執行該程式。

## root user 與 `sudo`
在大部分的淚 Unix 系統中，有一個特殊的使用者 root user。root user 幾乎不授權限限制，對任何的文件或是目錄都有 `wxr` 與刪除的權限。

我們通常不大會直接登入使用 root 來操作系統，因為太容易操作失誤而破壞系統，取而代之的，我們會使用 `sudo` 指令。

#### `sudo`
* `su` - super user，也就是 root 的身份
* `do` - 做某件事!

也就是說，`sudo` 可以讓我們用特殊的 root 身份來做某件事。有些事情是只有 root user 才能做，像是掛載在 `/sys` 下的 `sysfs` 檔案系統寫入內容。

## 練習
1. 在 `/tmp` 下新建一個名為 `missing` 的文件夾。
2. 查詢 `touch` 的手冊，請善用 `man` 指令。
3. 用 `touch` 在 `missing` 文件夾中新建一個叫 `semester` 的文件，並將以下內容逐行寫入 `semester` 文件：
<br/>
    ```
    #!/bin/sh
    curl --head --silent https://missing.csail.mit.edu
    ```

    第一行可能有點棘手， `#` 在Bash中表示註釋，而 `!` 即使被雙引號（`"`）包裹也具有特殊的含義。 單引號（`'`）則不一樣，此處利用這一點解決輸入問題。更多資訊請參考 [quoting](https://www.gnu.org/software/bash/manual/html_node/Quoting.html) 手冊。

4. 嘗試執行這個文件。例如，將該腳本的路徑（`./semester`）輸入到您的 shell 中並按 Enter。如果程序無法執行，請使用 `ls` 命令來獲取資訊並理解其不能執行的原因。

5. 執行 `sh` 直譯器 ( interpreter )，並以 `semester` 作為第一個參數，例如 `sh semester`。為什麼這樣可以但 `./semester` 卻不行?

6. 查看 `chmod` 的手冊 ( 例如，使用 `man chmod` 命令 )。

7. 使用 `chmod` 讓 `./semester` 指令可直接執行而不是輸入 `sh` `semester`。如何讓你的shell知道該程式應該透過 `sh` 直譯?查看 `shebang` 來了解其用途。

8. 使用 `|` 和 `>` ，將 `semester` 文件輸出的最後更改日期資訊，寫入根目錄下的 `last-modified.txt` 的文件中。

9. 寫一段指令來從 `/sys` 中獲取筆記型電腦的電量資訊，或者桌上型電腦的 CPU 溫度。注意：macOS 並沒有 `sysfs`，所以 mac 用戶可以跳過這一題。

## 參考
* https://missing-semester-zh-hant.github.io/2020/course-shell/