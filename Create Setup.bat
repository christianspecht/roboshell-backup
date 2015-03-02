@echo off

rem set version number (see batch file for more details)
call wix\version-number.bat
echo %productversion% > src\version.txt


del /q /s release\*.*

rem MSI

rem install WiX if it's missing
set nugetpath=%~dp0\packages
call "%nugetpath%\nuget.exe" restore "%nugetpath%\packages.config" -PackagesDirectory "%nugetpath%"

set wixpath=%nugetpath%\WiX.Toolset.3.8.1128.0\tools\wix

"%wixpath%\candle.exe" wix\roboshell-backup.wxs

"%wixpath%\light.exe" -ext WixUIExtension roboshell-backup.wixobj  -out release\msi\roboshell-backup-%productversion%.msi


rem ZIP
"%~dp0\..\7za.exe" a -tzip release\zip\roboshell-backup-%productversion%.zip @zipfiles.txt


pause