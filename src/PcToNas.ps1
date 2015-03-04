$config = [xml](get-content .\Config.xml)

.\logo $config.copy.showlogo.value

$nasdrive = $config.copy.nasdrive.value
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

$nasfolder = Join-Path $nasdrive $config.copy.nasfolder.value

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
	$parameters = @("/mir", "/xj", "/fft")
	
	$from = $node.from
	$to = Join-Path $nasfolder $node.to   
	
	if ($node.ignorefolders)
	{
		$parameters += "/xd"
		
		foreach ($folder in $node.ignorefolders.Split('|'))
		{
			$parameters += $folder
		}
	}

	if ($node.ignorefiles)
	{
		$parameters += "/xf"
		
		foreach ($file in $node.ignorefiles.Split('|'))
		{
			$parameters += $file
		}
	}
	
	&robocopy.exe "$from" "$to" *.* $parameters
}