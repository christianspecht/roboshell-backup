$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$usbdrive = $config.copy.usbdrive.value
$usbfolder = $usbdrive + "Backup_NAS"

write-host "##########################################################"
write-host "#"
write-host "#  Backup from NAS to external USB drive"
write-host "#"
write-host "#  NAS drive letter:              $nasdrive"
write-host "#  USB drive destination folder:  $usbfolder"
write-host "#"
write-host "##########################################################"
write-host ""
read-host "Press Enter to start!"

robocopy.exe "$nasdrive" "$usbfolder" *.* /mir /fft

read-host "Press Enter to exit!"