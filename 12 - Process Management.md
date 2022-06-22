# 12 - Process Management
> A program is a series of instructions that tell the computer what to do. When we run a program, those instructions are copied into memory and space is allocated for variables and other stuff required to manage its execution. This running instance of a program is called a process and it's processes which we manage.

Program ( 程序 ) 是告訴計算機要做什麼的一列指令。這些指令會被複製到內存中，並且為變數和其他管理程序執行所需的東西分配空間。

這個程序的執行實例稱為行程 ( process )。

## What is Currently Running?
Linux 是一個多工 ( multitasking ) 的作業系統，代表 process 可以在同一個時間被執行。在 Linux 系統中，除了我們自己執行的 process，還會有 Linux 自己底層執行的 process，甚至是其他使用者在系統上執行的。

#### top
要查看當前系統有那些東西在執行，可以使用 `top` 指令，以取得當前系統所發生事情的快照 ( snapshot )。

```
top
```

```
1. localhost:~# top
2. Tasks: 174 total, 3 running, 171 sleeping, 0 stopped
3. KiB Mem: 4050604 total, 3114428 used, 936176 free
4. Kib Swap: 2104476 total, 18132 used, 2086344 free
5. 
6.  PID USER %CPU %MEM COMMAND
7. 6978 ryan 3.0  21.2 firefox
8.   11 root 0.3   0.0 rcu_preempt
9. 6601 ryan 2.0   2.4 kwin
```

* 第 2 行：`Task` 是 process 的另外一個名稱。他們大部分是系統的 process，而也有一部分是 sleeping 的狀態。
<br/>

* 第 3 行：是某個工作記憶體內存 ( RAM ) 的資訊。Linux 會將最近使用的程序保存在內存中，以便再次運行時提高效能。如果佔了太大的內存，也可以清除他們。
<br/>

* 第 6-10 行：最後列出了系統上資源最密集的 process ( 按資源順序排列 )。這些資訊會實時更新，讓我們了解系統的狀況。如果某個特定的 process 在一段時間內 CPU 或 MEMORY 都很高的話，就可以研究一下原因。
<br/>

* 承上，`PID` 則是 process 的 ID

#### `ps [aux]`
另一個可以查看 process 的指令是 `ps [aux]`。`aux` 的意思是：
* `a` - show processes for all users
* `u` - display the process's user/owner
* `x` - also show process not attached to a terminal

```
ps [aux]
```

* 單純只使用 `ps` 的話，只顯示當前在 terminal 中執行的行程 ( process )
* 有加上 `[aux]` 參數的話就會顯示比較詳細的資訊
* 承上，由於加上 `aux` 參數顯示的資訊很多，通常會搭配 `grep` 過濾

```
localhost:~# ps aux
PID   USER     TIME  COMMAND
    1 root      0:01 {init} /bin/sh /sbin/init
    2 root      0:00 [kthreadd]
    3 root      0:00 [kworker/0:0]
    4 root      0:00 [kworker/0:0H]
    5 root      0:00 [kworker/u2:0]
    6 root      0:00 [mm_percpu_wq]
    7 root      0:00 [ksoftirqd/0]
    8 root      0:00 [kdevtmpfs]
    9 root      0:00 [oom_reaper]
   10 root      0:00 [writeback]
   11 root      0:00 [kcompactd0]
   12 root      0:00 [crypto]
   13 root      0:00 [bioset]
   14 root      0:00 [kblockd]
   15 root      0:00 [kworker/0:1]
   16 root      0:00 [kswapd0]
   17 root      0:00 [bioset]
   34 root      0:00 [khvcd]
   35 root      0:00 [bioset]
   36 root      0:00 [bioset]
   37 root      0:00 [bioset]
   38 root      0:00 [bioset]
   39 root      0:00 [bioset]
   40 root      0:00 [bioset]
   41 root      0:00 [bioset]
   42 root      0:00 [bioset]
   55 root      0:00 settime -d /
   56 root      0:00 dhcpcd -q
   61 root      0:00 sh -l
   62 root      0:00 [kworker/u2:1]
   85 root      0:00 ps aux

localhost:~# ps aux | grep 'firefox'
   84 root      0:00 grep firefox
```

#### `ps aux` 輸出格式
```
USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
```

| 欄位 | 說明 |
| --- | --- |
| `USER` | 行程擁有者 |
| `PID` | Process ID |
| `%CPU` | 佔用 CPU 的使用率 |
| `%MEM` | 佔用的記憶體使用率 |
| `VSZ` | 佔用的虛擬記憶體大小 |
| `RSS` | 佔用的記憶體大小 |
| `TTY` | 中端的次要裝置號碼 ( minor device number of tty ) |
| `STAT` | 該行程的狀態，Linux 的程序有五種狀態：<br/> 1. `D` - 不可中斷 ( uninterruptible sleep，usually IO ) <br/> 2. `R` - 執行 ( runnable，on run queue ) <br/> 3. `S` - 中斷 ( sleeping ) <br/> 4. `T` - 停止 ( traced or stopped ) <br/> 5. `Z` - 僵死 ( a defunct ( "zombie" ) process ) |
| `START` | 行程開始時間 |
| `TIME` | 執行的時間 |
| `COMMAND` | 所執行的指令 |

## Killing a Crashed Process

```
localhost:~# ps aux | grep 'firefox'
ryan 6978 8.8 23.5 2344096 945452 ? Sl 08:03 49:53 /usr/lib64/firefox/firefox
```

在 owner ( ryan ) 旁邊的是 `PID` ( 6978 )，我們可以使用 `PID` 來清除行程。

```
kill [signal] <PID>
```

```
kill 6978
```

在執行 `kill` 指令時，預設會送出數字 `1` 讓 process 能很好的結束。但如果發現 process 沒有被 `kill`，那麼可以改為送出數字 `9`，例：
```
kill -9 6978
```

關於 Linux signal number 可以參考[這篇](https://unix.stackexchange.com/questions/317492/list-of-kill-signals)。

通常實務上如果非 root user，我們只會 kill 自己的 process。

#### My Desktop has lock up
雖然很少見，不過有時候還是有機會發生 process crash 導致整個桌面被鎖定。

實際上 Linux 運行多個虛擬控制台 ( virtual console )。大部分時間我們只會看到控制台 7 號 ( console 7 ) ( 也就是我們使用的 GUI 介面 )。

所以當 GUI 被 lock 住，我們可以切換到其他的 console 並 kill 有問題的 process。要切換 console 的話可以使用下面的指令：

```
Ctrl + Alt + F<Console>
```

範例一：
執行後將會進入其中一個控制台，可以在這邊先 kill GUI。
```
Ctrl + Alt + F2
```

範例二：
執行後將可以回到 GUI console，看是否可以正常運行。
```
Ctrl + Alt + F7
```

p.s. 練習可以從 CPU 使用較高或記憶體使用率較高的 process 開始。

## 參考
* https://ryanstutorials.net/linuxtutorial/processes.php
* https://www.796t.com/content/1547716343.html
* https://unix.stackexchange.com/questions/106847/what-does-aux-mean-in-ps-aux