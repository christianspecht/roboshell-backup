$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$nasfolder = $nasdrive + $config.copy.nasfolder.value
$waittime = $config.copy.waittime.value

if (!(test-path $nasdrive))
{
	write-host "##########################################################"
	write-host "#"
	write-host "#  NAS drive $nasdrive does not exist!"
	write-host "#  Backup to NAS will not run!"
	write-host "#"
	write-host "#  This window will close in $waittime seconds!"
	write-host "#"
	write-host "##########################################################"
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
			write-host "##########################################################"
			write-host "#"
			write-host "#  Missing source folder(s)!"
			write-host "#  The following source folders do not exist:"
			write-host "#"
		}
	
		write-host "#  $folder"
		
		$numerrors++
	}
}

if ($numerrors -gt 0)
{
	write-host "#"
	write-host "#  Backup to NAS will not run!"
	write-host "#"
	write-host "#  This window will close in $waittime seconds!"
	write-host "#"
	write-host "##########################################################"
	start-sleep -s $waittime
	break
}

write-host "##########################################################"
write-host "#"
write-host "#  Backup from local machine to NAS"
write-host "#"
write-host "#  Folders will be backed up to:"
write-host "#  $nasfolder"
write-host "#"
write-host "#  Backup will start in $waittime seconds!"
write-host "#"
write-host "##########################################################"
write-host ""
start-sleep -s $waittime

foreach ($node in $config.copy.sourcefolder)
{
    $from = $node.from
    $to = $nasfolder + $node.to   
    robocopy.exe "$from" "$to" *.* /mir /xj /fft
}