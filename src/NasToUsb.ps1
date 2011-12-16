.\logo

$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$usbdrive = $config.copy.usbdrive.value
$waittime = $config.copy.waittime.value

Import-LocalizedData -BindingVariable msg -FileName messages.psd1

if (!(test-path $nasdrive))
{
	"##########################################################"
	"#"
	"#  " + $msg.noNasDrive -f $nasdrive
	"#  " + $msg.noBackupU
	"#"
	"#  " + $msg.windowClose -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

if (!(test-path $usbdrive))
{
	"##########################################################"
	"#"
	"#  " + $msg.noUsbDrive -f $usbdrive
	"#  " + $msg.noBackupU
	"#"
	"#  " + $msg.windowClose -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

$usbfolder = $usbdrive + "Backup_NAS"

"##########################################################"
"#"
"#  " + $msg.backupStartU1
"#"
"#  " + $msg.backupStartU2 -f $nasdrive
"#  " + $msg.backupStartU3 -f $usbfolder
"#"
"##########################################################"
""
read-host $msg.pressEnter1

robocopy.exe "$nasdrive" "$usbfolder" *.* /mir /fft

read-host $msg.pressEnter2