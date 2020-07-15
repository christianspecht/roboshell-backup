param($showlogo)

if ($showlogo -eq "1")
{
	"  ____        _           ____  _          _ _ "
	" |  _ \  ___ | |__   ___ / ___|| |__   ___| | |"
	" | |_) |/ _ \| '_ \ / _ \\___ \| '_ \ / _ \ | |"
	" |  _ <| (_) | |_) | (_) |___) | | | |  __/ | |"
	" |_| \_\\___/|_.__/ \___/|____/|_| |_|\___|_|_|"
	"  ____             _                "
	" | __ )  __ _  ___| | ___   _ _ __  "
	" |  _ \ / _`  |/ __| |/ / | | | '_ \ "
	" | |_) | (_| | (__|   <| |_| | |_) |"
	" |____/ \__,_|\___|_|\_\\__,_| .__/ "
	"                             |_|    "
}
else
{
	"RoboShell Backup"
}

if (test-path version.txt)
{
	$version = get-content "version.txt"
	"v" + $version
}

"https://christianspecht.de/roboshell-backup/"
""