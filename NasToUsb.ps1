$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$usbdrive = $config.copy.usbdrive.value
$waittime = $config.copy.waittime.value

if (!(test-path $nasdrive))
{
	"##########################################################"
	"#"
	"#  NAS drive {0} does not exist!" -f $nasdrive
	"#  Backup to external USB drive will not run!"
	"#"
	"#  This window will close in {0} seconds!" -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

if (!(test-path $usbdrive))
{
	"##########################################################"
	"#"
	"#  USB drive {0} does not exist!" -f $usbdrive
	"#  Backup to external USB drive will not run!"
	"#"
	"#  This window will close in {0} seconds!" -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

$usbfolder = $usbdrive + "Backup_NAS"

"##########################################################"
"#"
"#  Backup from NAS to external USB drive"
"#"
"#  NAS drive letter:              {0}" -f $nasdrive
"#  USB drive destination folder:  {0}" -f $usbfolder
"#"
"##########################################################"
""
read-host "Press Enter to start"

robocopy.exe "$nasdrive" "$usbfolder" *.* /mir /fft

read-host "Press Enter to exit"