set productversion=1.0

candle wix\roboshell-backup.wxs

light -ext WixUIExtension roboshell-backup.wixobj  -out roboshell-backup-%productversion%.msi

del /q release\*.*
md release
copy roboshell-backup-%productversion%.msi release

pause