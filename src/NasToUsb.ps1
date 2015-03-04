$config = [xml](get-content .\Config.xml)

.\logo $config.copy.showlogo.value

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
	
	$tcmount = $truecrypt.mountto
	
	if ((test-path $tcmount))
	{
		"##########################################################"
		"#"
		"#  " + $msg.tcMountDriveExists -f $tcmount
		"#  " + $msg.noBackupU
		"#"
		"#  " + $msg.windowClose -f $waittime
		"#"
		"##########################################################"
		start-sleep -s $waittime
		break
	}
	
	$tmp = [System.Diagnostics.Process]::Start("$tcexe", "/q /v $tcvolume /l $tcmount /b")
	
	# concatenate path manually here, because Join-Path apparently doesn't work with mounted folders
	$usbfolder = $tcmount + "Backup_NAS"
}
else
{
	$usbfolder = Join-Path $usbdrive "Backup_NAS"
}

"##########################################################"
"#"
"#  " + $msg.backupStartU1
"#"
"#  " + $msg.backupStartU2 -f $nasdrive
"#  " + $msg.backupStartU3 -f $usbfolder

if ($truecrypt.enabled -eq "1")
{
	"#  " + $msg.backupStartU4
}

"#"
"##########################################################"
""
if ($truecrypt.enabled -eq "1")
{
	$msg.tcMount -f $tcmount
	""
	$msg.tcPressEnter1
	$msg.tcPressEnter2
	read-host $msg.tcPressEnter3
	
	# in TrueCrypt mode, wait a few seconds to make sure that the drive is really mounted
	start-sleep -s 5
	
	if (!(test-path $tcmount))
	{
		"##########################################################"
		"#"
		"#  " + $msg.tcDriveNotMounted1
		"#  " + $msg.tcDriveNotMounted2 -f $tcmount
		"#  " + $msg.noBackupU
		"#"
		"#  " + $msg.windowClose -f $waittime
		"#"
		"##########################################################"
		start-sleep -s $waittime
		break
	}	
}
else
{
	read-host $msg.pressEnter1
}

robocopy.exe "$nasdrive" "$usbfolder" *.* /mir /fft

if ($truecrypt.enabled -eq "1")
{
	$msg.tcDisMount -f $tcmount
	""
	$tmp = [System.Diagnostics.Process]::Start("$tcexe", "/q /d $tcmount")
}

read-host $msg.pressEnter2