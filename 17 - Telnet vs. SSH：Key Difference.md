# 17 - Telnet vs. SSH：Key Difference
## Outline
* What is Telnet?
* What is SSH?
* Key Difference
* Important Telnet Commands
* Important SSH Commands
* Difference between Telnet and SSH
* Advantages and Disadvantages of Telnet
* Advantages and Disadvantages of SSH

## What is Telnet?
Telnet 是一個簡單應用層 ( OSI - Application Layer ) 「遠端終端機協定」，允許使用者透過 TCP 連線到遠端 server。

* 使用於網際網路及區網中，使用虛擬終端機 ( virtual terminal service ) 的形式，提供雙向、以文字字串為主的命令介面互動功能

* 也就是說，使用者可以使用 Telnet 協定從自己的 PC 連線到伺服器，by IP Address 或主機名稱

## What is SSH?
SSH 是一種被廣泛用於遠程訪問和管理設備的網路協定。

* 比較完整的解釋是 Secure Shell 通過 Internet 訪問網路設備和服務器的主要協議

## Key Difference
1. Telnet 和 SSH 是同類型的東西，差別在於 SSH 的戀線通道有經過加密

2. SSH 使用 public 和 private key 進行通道加密

3. Telnet 使用 `23` port，SSH 則 run 在 `22` port

4. Telnet 使用純文本 ( plaintext ) 的形式傳輸，SSH 則是以加密過的形式透過安全通道 ( secure channel ) 傳輸

5. Telnet 比較適合用在 private networks，SSH 比較適合在 public networks

## Important Telnet Commands
| Commands | Function |
| --- | --- |
| `Open` | 打開主機 port 號並建立 Telnet 連線 |
| `Close` | 關閉當前的 Telnet 連線 |
| `Quit` | 退出 Telnet |
| `Status` | 確認 Telnet 客戶端是否已連接 |
| `Timing Mark` | 定義時間標記 |
| `Terminal Type / Speed` | 設定 terminal 的速度和類型 |

## Important SSH Commands
* `ls`
* `cd`
* `mkdir`
* `touch`

## Difference between Telnet and SSH
以下將以表格的形式呈現 Telnet 和 SSH 之間的不同。
| Telnet | SSH |
| --- | --- |
| Telnet 是用於虛擬終端服務標準 TCP / IP 協定。它讓使用者可以在本地連接到遠程的系統。 | SSH 又稱作 Secure Shell，是一種通過網路登錄到另一台電好，並在遠端電腦執行命令的程式。 |
| 使用專為私有網路設計的 `23` port | 預設在 `22` port 上運行，port 號可以被更改 | 
| 沒有對用戶身分驗證提供授權 | 較安全，因為使用工要加密進行身分驗證 | 
| 適用於私人網路 | 適用於公用網路 |
| 以純文本的形式傳輸資料 | 使用加密格式與安全通道發送資料 |
| 只需低頻寬即可 | 通常需要高頻寬 |
| 使用此協議發送的資料較不易被駭客攔截 | 使用者名稱和密碼容易受到惡意攻擊 |
| 用於 Linux 和 Windows 系統 | 可以在所有流行的操作系統中使用 |

## Advantages and Disadvantages of Telnet
#### Advantages
* 此協定可用於收發訊息
* 支援用戶認證
* 可以同時多用戶協作

#### Disadvantages
* 因沒有使用身分驗證策略及加密資料，有安全上的疑慮
* 不支援動態 port 及加密數據傳輸
* 僅顯示文本和數字，不支援顯示圖形及顏色

## Advantages and Disadvantages of SSH
#### Advantages
* 可以通過加密且安全的通道傳輸不安全的應用程式，例： SMTP、IMAP、POP3 和 CVS
  SSH helps you to securely tunnel insecure applications like SMTP, IMAP, POP3, and CVS. 
<br/>  

* 允許用戶通過不安全的網路，安全地登入到另一台電腦
* 透過強加密保護隱私
* 會驗證發送者及接收者個身分
* 允許使用者遠端查看目錄內容、編輯文件和訪問自定義資料庫應用程式

#### Disadvantages
* 連接到 Telnet 時無法運行 GUI 工具
* 並非一個完美安全的協議，SSH 也沒有辦法解決所有 TCP 的問題
* 無法保護使用者防止受到透過其他協議進行的惡意攻擊
* 無法防範特洛伊木馬 ( Trojan horses ) 和病毒攻擊

## 參考
* https://www.guru99.com/telnet-vs-ssh.html
* https://ithelp.ithome.com.tw/articles/10277498?sc=iThelpR
* https://codecharms.me/posts/security-ssh