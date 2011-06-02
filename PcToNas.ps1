$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$nasfolder = $nasdrive + $config.copy.nasfolder.value
$waittime = $config.copy.waittime.value

if (!(test-path $nasdrive))
{
	"##########################################################"
	"#"
	"#  NAS drive {0} does not exist!" -f $nasdrive
	"#  Backup to NAS will not run!"
	"#"
	"#  This window will close in {0} seconds!" -f $waittime
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
			"#  Missing source folder(s)!"
			"#  The following source folders do not exist:"
			"#"
		}
	
		"#  $folder"
		
		$numerrors++
	}
}

if ($numerrors -gt 0)
{
	"#"
	"#  Backup to NAS will not run!"
	"#"
	"#  This window will close in {0} seconds!" -f $waittime
	"#"
	"##########################################################"
	start-sleep -s $waittime
	break
}

"##########################################################"
"#"
"#  Backup from local machine to NAS"
"#"
"#  Folders will be backed up to:"
"#  $nasfolder"
"#"
"#  Backup will start in {0} seconds!" -f $waittime
"#"
"##########################################################"
""
start-sleep -s $waittime

foreach ($node in $config.copy.sourcefolder)
{
    $from = $node.from
    $to = $nasfolder + $node.to   
    robocopy.exe "$from" "$to" *.* /mir /xj /fft
}