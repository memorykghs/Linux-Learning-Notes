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

## 參考
* https://ryanstutorials.net/linuxtutorial/permissions.php