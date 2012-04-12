$config = [xml](get-content .\Config.xml)

if ($config.copy.showlogo.value -eq "1")
{
	.\logo
}

$nasdrive = $config.copy.nasdrive.value
$usbdrive = $config.copy.usbdrive.value
$waittime = $config.copy.waittime.value
$truecrypt = $config.copy.truecrypt

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

if ($truecrypt.enabled -eq "1")
{
    $tcexe = join-path $usbdrive $truecrypt.exepath
    
    if (!(test-path $tcexe))
    {
    	"##########################################################"
    	"#"
    	"#  " + $msg.tcMissingExe -f $tcexe
    	"#  " + $msg.noBackupU
    	"#"
    	"#  " + $msg.windowClose -f $waittime
    	"#"
    	"##########################################################"
    	start-sleep -s $waittime
    	break
    }
    
    $tcvolume = join-path $usbdrive $truecrypt.volume
    
    if (!(test-path $tcvolume))
    {
    	"##########################################################"
    	"#"
    	"#  " + $msg.tcMissingVolume -f $tcvolume
    	"#  " + $msg.noBackupU
    	"#"
    	"#  " + $msg.windowClose -f $waittime
    	"#"
    	"##########################################################"
    	start-sleep -s $waittime
    	break
    }
    
    if ((test-path $truecrypt.mountto))
    {
    	"##########################################################"
    	"#"
    	"#  " + $msg.tcMountDriveExists -f $truecrypt.mountto
    	"#  " + $msg.noBackupU
    	"#"
    	"#  " + $msg.windowClose -f $waittime
    	"#"
    	"##########################################################"
    	start-sleep -s $waittime
    	break
    }
}

$usbfolder = Join-Path $usbdrive "Backup_NAS"

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