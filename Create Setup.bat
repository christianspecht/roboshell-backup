@echo off

rem set version number (see batch file for more details)
call wix\version-number.bat

del /q release\*.*

candle wix\roboshell-backup.wxs

light -ext WixUIExtension roboshell-backup.wixobj  -out release\roboshell-backup-%productversion%.msi

pause