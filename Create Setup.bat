@echo off

rem set version number (see batch file for more details)
call wix\version-number.bat

del /q release\*.*

rem MSI

candle wix\roboshell-backup.wxs

light -ext WixUIExtension roboshell-backup.wixobj  -out release\msi\roboshell-backup-%productversion%.msi


rem ZIP
%~dp0\..\7za.exe a -tzip release\zip\roboshell-backup-%productversion%.zip @zipfiles.txt


pause