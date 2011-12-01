How to release a new version
####################################################################################

1. Increase the version number in Create Setup.bat in the main folder

2. Find this line right at the beginning of the roboshell-backup.wxs (in this folder) and replace the GUID by a new one:
<?define ProductId = {E00ADE45-F382-47C5-B6C2-647715412338} ?>