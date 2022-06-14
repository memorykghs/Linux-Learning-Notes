# 08 - Permissions
dictate ( 主宰 ) by 三個權限：
1. read ( `r` )
2. write ( `w` ) - 修改文件的權限
3. execute ( `x` ) - 直行或 run 一個檔案，如果檔案類型是 program 或是 scripts 的話

> Q. 如果是非 scripts 類型的檔案一樣有 execute 權限嗎?

<br/>

Linux 系統中，可以再劃分為三個權限群組，每個群組均包含上述的三個權限設定：
1. **owner** - 檔案的擁有者 ( 通常是創建文件的使用者，但有時候可能會被授權給其他人 ) ( Typically the person who created the file but ownership may be granted to some one else by certain users. )
2. **group** - 每個文件都是一個獨立的權限群組 ( Every file belongs to a single group. )
3. **others** - 不在上面兩個群組內的，都是此權限

## View Permissions
使用 long list option ( `-l` ) 就可以看到每個檔案或目錄下的權限。
```
ls -l [path]
```

```
localhost:/home/Documents# ls -l
total 8
-rwxr-x--x    1 root     root           742 Jun 15 02:04 saampleData.txt
-rw-r--r--    1 root     root            22 Jun 15 02:05 test.js
```

## Change Permissions
指令的意思為 change file mode。
```
chmod [permissions] [path]
```

變更權限圍繞在三個方向：
1. 變更誰的權限? ( `[ugoa]` - user ( or owner )、group、others 和 all )
2. 授予 ( grant ) 權限還是撤銷 ( revoke ) 權限? ( 使用加號 `+` 或是減號 `-` 代表 )
3. 設定哪一種權限? ( read `r`、write `w` 或 execute `x` )

範例：
```
localhost:~# ls -l frog.png
-rwxr----x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod g+x frog.png
localhost:~# ls -l frog.png
-rwxr-x--x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod u-w frog.png
localhost:~# ls -l frog.png
-r-xr-x--x 1 harry users 2.7K Jan 4 07:32 frog.png
```

也可以一次變動多個群組的權限：
```
localhost:~# ls -l frog.png
-rwxr----x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod g+wx frog.png
localhost:~# ls -l frog.png
-rwxrwx--x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod go-x frog.png
localhost:~# ls -l frog.png
-rwxrw---- 1 harry users 2.7K Jan 4 07:32 frog.png
```

## Setting Permissions Shorthand
計算機系統中有幾個典型的數字系統：十進制 ( decimal，0 - 9 )、八進制 ( octal，0 - 7 ) 以及二進制 ( binary，0 - 1 )。在這裡我們將使用只有二進制來指定權限，其中牽涉到二進制轉換為八進制的部分，其 mapping 如下：

![](/images/8-1.png)

因為二進制轉換為八進制需要三個位數，那麼我們就可以以這個八進位數來代表一個權限群組擁有的權限。

```
p.s. 0 → 無權限 / 1 → 有權限

- w x r
========
  1 1 1 → wxr 均有權限 → 轉換後的數字為 7
  0 1 0 → 2
  0 1 1 → 3
  1 0 1 → 5
  ...
```

接下來看一些範例：
```
localhost:~# ls -l frog.png
-rw-r----x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod 751 frog.png
localhost:~# ls -l frog.png
-rwxr-x--x 1 harry users 2.7K Jan 4 07:32 frog.png

localhost:~# chmod 240 frog.png
localhost:~# ls -l frog.png
--w-r----- 1 harry users 2.7K Jan 4 07:32 frog.png
```

通常比較常用的有 `755` 和 `750`。

## Permissionos for Directories
跟 file 一樣有三個權限，但他們的定義有稍微的不同：
1. read ( `r` ) - 可以查看目錄下的內容，如使用 `ls`
2. write ( `w` ) - 可以在該目錄下變更內容，如建立檔案或目錄
3. execute ( `x` ) - 可以進入該目錄下，如 `cd`

範例：
```
localhost:/home# ls Documents/
saampleData.txt  test.js

localhost:/home# ls -ld Documents/
dr--------    2 root     root            93 Jun 15 02:00 Documents/

localhost:/home# cd Documents/
cd: Documents: Permission denied

localhost:/home# ls Documents
file1 file2 file3

localhost:/home# chmod 100 Documents
localhost:/home# ls -ld Documents
---x------ 1 ryan users 2.7K Jan 4 07:32 Documents

localhost:/home# ls Documents
localhost:/home# cd Documents
localhost:/home# pwd
/home/ryan/Documents
ls: cannot open directory Documents/: Permission denied
```

* `-ld` - 查看目錄的權限

## The Root User
在 Linux 系統中只有兩種人比較可能去異動權限：
1. file owner 
2. root user

通常我們會使用 root 帳號來維護 Linux 系統，因為 root user 權限是凌駕於前面提到的三個權限群組之上的。

## Basic Security
通常較好的權限設定模式會是：group 和 others 不能有 write access，但可以有 execute 和 read access。

在嚴謹一點的話可以只留 execute，代表他人可以執行 home 目錄下的檔案，但看不到裡面有什麼東西，也進不去。

## 小結
* `chmod` - 更改檔案或目錄的權限
* `ls -ld` - 查看指定目錄的權限

## Important Concepts
* Security - 正確設定權限對於一個系統來說非常重要
* Usage - 設置正確的權限對於在 Linux 上順利運行某些任務很重要

## 參考
* https://ryanstutorials.net/linuxtutorial/permissions.php