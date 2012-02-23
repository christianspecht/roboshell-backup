$config = [xml](get-content .\Config.xml)

if ($config.copy.showlogo.value -eq "1")
{
	.\logo
}

$nasdrive = $config.copy.nasdrive.value
$nasfolder = Join-Path $nasdrive $config.copy.nasfolder.value
$waittime = $config.copy.waittime.value

Import-LocalizedData -BindingVariable msg -FileName messages.psd1

if (!(test-path $nasdrive))
{
	"##########################################################"
	"#"
	"#  " + $msg.noNasDrive -f $nasdrive
	"#  " + $msg.noBackupN
	"#"
	"#  " + $msg.windowClose -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

$numerrors = 0

foreach ($node in $config.copy.sourcefolder)
{
    $folder = $node.from

	if (!(test-path $folder))
	{
		if ($numerrors -eq 0)
		{
			"##########################################################"
			"#"
			"#  " + $msg.missingFolders1
			"#  " + $msg.missingFolders2
			"#"
		}
	
		"#  $folder"
		
		$numerrors++
	}
}

if ($numerrors -gt 0)
{
	"#"
	"#  " + $msg.noBackupN
	"#"
	"#  " + $msg.windowClose -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

"##########################################################"
"#"
"#  " + $msg.backupStartN1
"#"
"#  " + $msg.backupStartN2
"#  $nasfolder"
"#"
"#  " + $msg.backupStartN3 -f $waittime
"#"
"##########################################################"
""
start-sleep -s $waittime

foreach ($node in $config.copy.sourcefolder)
{
    $from = $node.from
    $to = Join-Path $nasfolder $node.to   
    robocopy.exe "$from" "$to" *.* /mir /xj /fft
}