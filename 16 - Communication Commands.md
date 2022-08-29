# 16 - Communication Commands
當使用 Linux 可能會需要與其他 devices 溝通與傳輸，Linux 內部有提供一些 utilities 幫助我們跟以下不同需求的對象溝通：

* networks
* other Linux systems
* remote users

與之相關的指令有：
* SSH
* Ping
* FTP
* Telnet

## SSH
* SSH 就是 Secure Shell，用來已安全的方式連接到遠端的電腦
* 與 Telnet 相比，SSH 較為安全，因為 client / server 的連線會被數位認證 ( digital certificate ) 和授權 ( authentication )，密碼也是被加密過的

基於以上原因，SSH 被 system administrators 廣泛的用來控制遠端 Linux servers。

#### 語法
登入遠端 Linux。
```linux
SSH username@ip-address or hostname
```

登入後就可以執行任何的 Linux 指令。

```linux
ssh guru99@68.233.250.32
```

## Ping
* 此程序通常用於檢查與 server 的連線是否健康。
* 此外也可以用於：
  * 分析網路與主機連接
  * 追蹤網路效能並管理
  * 測試硬件和軟件問題

#### 語法
```linux
ping hostname="" or=""
```

```linux
ping 172.16.170.1
```
![](/images/16-1.png)

```linux
ping www.google.com
```
![](/images/16-2.png)

以上例子是某個系統傳送 64 bytes 的資料封包到 IP Address 是 `172.16.170.1` 或主機名稱是 `www.google.com` 的地方。如果封包沒有回傳或是遺失，代表連線出現錯誤。

* 所以通常我們使用此方法檢查網路連接
* `Ctrl + c` 可以退出 ping loop

## FTP
* FTP 是文件傳輸協定 ( file transfer protocol )。它是電腦之間最常被推薦使用的資料傳輸協定
* FTP 可以被用來：
  * 登入並與遠端主機建立連線
  * 上傳與下載文件
  * 瀏覽目錄
  * 瀏覽目錄下的內容

#### 語法
建立 FTP 連接。
```linux
ftp hostname="" or=""
```
輸入此命令之後，需要通過 `username` 和 `password` 的驗證。

![](/images/16-3.png)

登入主機後，可以使用以下命令執行不同操作：

| Command | Function |
| --- | --- |
| `dir` | 顯示遠端電腦上當前目錄下的所有檔案 |
| `cd "dirname"` | 切換到指定目錄 |
| `put file` | 將本地 ( local ) 檔案上傳到遠端電腦 |
| `get file` | 從遠端下載檔案到本地 ( local ) |
| `quit` | 登出 |

![](/images/16-4.png)

## Telnet
* Telnet 可以用來：
  * 連線到遠端 Linux 主機
  * 可遠端執行程式並進行管理

#### 語法
```linux
telnet hostname="" or=""
```

```linux
telnet localhost
```

下面的範例將會連接到 `localhost`，然後我們會需要輸入 `username` 和 `password` 來登入。

![](/images/16-5.png)

一旦登入後就可以在遠端的 terminal 輸入任何 Linux 指令。不過不同的是，這些指令將會在遠端主機被執行，而不是在本地端。

## 小結
* Linux/Unix 可以與其它不同的主機、網路和遠端使用者之間互動
* `ping` 指令用來檢查主機名稱或 IP Address 之間的連線是否正常
* FTP 是發送和接收文件最推薦的協定。使用 FTP 可以建立與遠端機的 FTP 鏈接，並執行指令來上傳、下載和瀏覽文件
* Telnet 可以連線到遠端的 Linux 主機並在上面執行指令

## 參考
* https://www.guru99.com/communication-in-linux.html