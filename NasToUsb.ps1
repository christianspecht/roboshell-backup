$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$usbdrive = $config.copy.usbdrive.value
$waittime = $config.copy.waittime.value

if (!(test-path $nasdrive))
{
	write-host "##########################################################"
	write-host "#"
	write-host "#  NAS drive $nasdrive does not exist!"
	write-host "#  Backup to external USB drive will not run!"
	write-host "#"
	write-host "#  This window will close in $waittime seconds!"
	write-host "#"
	write-host "##########################################################"
	start-sleep -s $waittime
	break
}

if (!(test-path $usbdrive))
{
	write-host "##########################################################"
	write-host "#"
	write-host "#  USB drive $usbdrive does not exist!"
	write-host "#  Backup to external USB drive will not run!"
	write-host "#"
	write-host "#  This window will close in $waittime seconds!"
	write-host "#"
	write-host "##########################################################"
	start-sleep -s $waittime
	break
}

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
read-host "Press Enter to start"

robocopy.exe "$nasdrive" "$usbfolder" *.* /mir /fft

read-host "Press Enter to exit"