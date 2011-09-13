candle wix\roboshell-backup.wxs

light -ext WixUIExtension roboshell-backup.wixobj

del /q release\*.*
md release
copy roboshell-backup.msi release

pause