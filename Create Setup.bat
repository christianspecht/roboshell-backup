candle wix\roboshell-backup.wxs

light roboshell-backup.wixobj

del /q release\*.*
md release
copy roboshell-backup.msi release

pause