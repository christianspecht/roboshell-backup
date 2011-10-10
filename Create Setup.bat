set productversion=1.0

del /q release\*.*

candle wix\roboshell-backup.wxs

light -ext WixUIExtension roboshell-backup.wixobj  -out release\roboshell-backup-%productversion%.msi

pause