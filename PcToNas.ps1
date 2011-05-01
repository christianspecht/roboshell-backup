$config = [xml](get-content .\Config.xml)

$nasdrive = $config.copy.nasdrive.value
$nasfolder = $nasdrive + $config.copy.nasfolder.value
$waittime = $config.copy.waittime.value

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