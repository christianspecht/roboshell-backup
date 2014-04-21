![logo](https://bitbucket.org/christianspecht/roboshell-backup/raw/tip/img/logo128x128.png)

RoboShell Backup is a simple personal backup tool.  
It uses Microsoft's [RoboCopy](http://en.wikipedia.org/wiki/Robocopy) to copy files, and it is written in [Windows PowerShell](http://en.wikipedia.org/wiki/Windows_PowerShell).

---

## Links

- [Download page](https://bitbucket.org/christianspecht/roboshell-backup/downloads)
- [Report a bug](https://bitbucket.org/christianspecht/roboshell-backup/issues/new)
- [Main Project page on Bitbucket](https://bitbucket.org/christianspecht/roboshell-backup)

---

## Background

I wrote RoboShell Backup because I needed something to fit **my** personal backup strategy.  
I have several computers and a NAS drive at home and I want to do two things:

1. I want to plug an external USB drive to any of my machines and just run one script that backups the whole NAS drive onto the USB drive.

2. There is some stuff locally on each machine that I can't save directly on the NAS.  
I try to put as much directly on the NAS drive as possible, but there are some programs that save files locally (for example in My Documents) and I can't change that.  
--> I want a copy of all that data on the NAS, so it gets automatically backed up on the USB disk as well, without having to connect the USB disk to each machine, every time I want to make a backup.  
(that's what I did before I wrote RoboShell Backup)

---

## What does it do?

RoboShell Backup works best if you have the following setup:

- Several computers, and on each one is local data that needs to be backed up regularly.
- A NAS drive to which you can copy the local data from all your computers.
- One or more external USB drives to take backups of your whole NAS drive.

If your setup looks like this, then RoboShell Backup is for you: It helps you automate the copying stuff.

RoboShell Backup consists of two batch files:

- `PcToNas.bat` copies folders from your local machine to a NAS drive.  
You can  specify in the `config.xml` file:  
  - the local folders to be copied
  - the drive letter of the NAS drive
  - the name of the destination folder on the NAS drive
- `NasToUsb.bat` backups the whole NAS drive to an external USB drive  
(which can be encrypted with [TrueCrypt](http://www.truecrypt.org/)).  
You can specify in the `config.xml` file:
  - the drive letter of the USB drive
  - settings for TrueCrypt (optional)  
*(If enabled, RoboShell Backup will automatically mount and dismount your TrueCrypt volume - [read more about how to set this up](http://christianspecht.de/2012/04/30/roboshell-backup-1-1-now-with-truecrypt-integration/))*

The idea is that you run `PcToNas.bat` regularly on each of your machines (by putting it into your Startup folder, for example), so that all your important data is always on your NAS drive, including the local stuff from each machine.  
Then, every time you feel like taking a complete backup of your NAS, you plug an external USB drive to any of your machines and run `NasToUsb.bat` to copy the whole NAS on the USB drive.

RoboShell Backup mirrors the copied files using RoboCopy's `/MIR` switch, which means that only changed, deleted and new files will be touched at all.
So, making a backup doesn't take much time (except for the very first run, of course).

---

## Setup

RoboShell Backup assumes that RoboCopy and Windows Powershell are both installed on your machine and in your `%PATH%` variable.  
Depending on your Windows version, this may already be the case (see below for more information).

The installation of RoboShell Backup itself is easy, just run the setup.  
When the installation has finished, the config file will automatically open in Notepad. You need to change the values in the config file once, according to your setup (which folders to backup, drive letters of your NAS and your USB drive).

#### Updating an existing installation

The setup will automatically detect the older version and update it.  
**Note that it will overwrite the `config.xml` file, so you should backup the existing file before you run the setup.**  
When the setup is finished, just overwrite the installed `config.xml` with your backed up version.  
*(yes, [this is a bug](https://bitbucket.org/christianspecht/roboshell-backup/issue/4/setup-dont-repair-remove-config-file-if)...but you need to work around it until I figure out how to make the setup keep existing config files)*  

#### Encrypt your USB drives

As mentioned before, RoboShell Backup can write to [TrueCrypt](http://www.truecrypt.org/)-encrypted USB drives.  
You don't need to install TrueCrypt on any of your machines - you just need to set up each USB drive once ([instructions and more information here](http://christianspecht.de/2012/04/30/roboshell-backup-1-1-now-with-truecrypt-integration/)). RoboShell Backup will then run TrueCrypt directly from the USB drive, in portable mode.

#### How to get RoboCopy and PowerShell

RoboCopy will be on your machine and in your `%PATH%` variable if you have at least Windows Vista (because it's included in the standard installation)  
If your have Windows XP or older, you need the Windows Resource Kit for your Windows version (RoboCopy is part of the Resource Kit).  
Links to the downloads are on the bottom of the [Resource Kit's Wikipedia page](http://en.wikipedia.org/wiki/Windows_Resource_Kit).

Windows PowerShell is part of all Windows versions since Windows XP SP2.  
So if you have at least XP SP2, it should be there. If it's not, you can get it [here](http://www.microsoft.com/powershell).

---

## How to build?

RoboShell Backup itself doesn't need to be built, because it consists just of batch files and PowerShell scripts.  
The only thing that needs to be compiled is the MSI setup.

The setup is made using [WiX](http://wixtoolset.org/).  
To build it, you need the WiX Toolkit installed on your machine. At the moment, we're using WiX 3.5 which you can download [here](http://wix.codeplex.com/releases/view/60102).

The build script is the file `Create Setup.bat` in the main folder of the repository, and it assumes that WiX is in your `%PATH%` variable.  
In particular, the `bin` subfolder of the WiX installation path needs to be in your `%PATH%` variable, because the files used by the build script are located there.

---

### Acknowledgements

RoboShell Backup makes use of the following open source projects:

 - [TrueCrypt](http://www.truecrypt.org/)
 - [WiX](http://wixtoolset.org/)

---

<div id="license"></div>
### License

RoboShell Backup is licensed under the MIT License. See **[License.rtf](https://bitbucket.org/christianspecht/roboshell-backup/src/tip/src/License.rtf)** for details.

---

### Project Info

<script type="text/javascript" src="http://www.ohloh.net/p/583937/widgets/project_basic_stats.js"></script>  
<script type="text/javascript" src="http://www.ohloh.net/p/583937/widgets/project_languages.js"></script>

