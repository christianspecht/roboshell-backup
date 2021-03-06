![logo](https://raw.githubusercontent.com/christianspecht/roboshell-backup/master/img/logo128x128.png)

RoboShell Backup is a simple personal backup tool.  
It uses Microsoft's [RoboCopy](https://en.wikipedia.org/wiki/Robocopy) to copy files, and it is written in [PowerShell](https://en.wikipedia.org/wiki/PowerShell).

---

## Links

- [Download page](https://github.com/christianspecht/roboshell-backup/releases)
- [Report a bug](https://github.com/christianspecht/roboshell-backup/issues/new)
- [Main Project page on GitHub](https://github.com/christianspecht/roboshell-backup)

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
  - the local folders to be copied *(and subfolders/files to be ignored)*
  - the drive letter of the NAS drive
  - the name of the destination folder on the NAS drive
- `NasToUsb.bat` backups the whole NAS drive to an external USB drive  
(which can be encrypted with [TrueCrypt](http://en.wikipedia.org/wiki/TrueCrypt) / [VeraCrypt](https://en.wikipedia.org/wiki/VeraCrypt)).  
You can specify in the `config.xml` file:
  - the drive letter of the USB drive
  - settings for TrueCrypt/VeraCrypt (optional)  
*(If enabled, RoboShell Backup will automatically mount and dismount your TrueCrypt/VeraCrypt volume - read more about how to set this up for [TrueCrypt](https://christianspecht.de/2012/04/30/roboshell-backup-1-1-now-with-truecrypt-integration/) / [VeraCrypt](https://christianspecht.de/2018/01/07/veracrypt-integration-for-roboshell-backup/))*

The idea is that you run `PcToNas.bat` regularly on each of your machines (by putting it into your Startup folder, for example), so that all your important data is always on your NAS drive, including the local stuff from each machine.  
Then, every time you feel like taking a complete backup of your NAS, you plug an external USB drive to any of your machines and run `NasToUsb.bat` to copy the whole NAS on the USB drive.

RoboShell Backup mirrors the copied files using RoboCopy's `/MIR` switch, which means that only changed, deleted and new files will be touched at all.
So, making a backup doesn't take much time (except for the very first run, of course).

---

## Setup

RoboShell Backup assumes that RoboCopy and Windows Powershell are both installed on your machine and in your `%PATH%` variable.  
Depending on your Windows version, this may already be the case (see below for more information).

There are two options to install RoboShell Backup:

1. **MSI installer**  
    - Run the setup.
    - When the installation has finished, the config file will automatically open in Notepad.
2. **ZIP file**   
    - Unzip to a folder of your choice.
    - Open the config file (`config.xml`) by yourself.

You need to change the values in the config file once, according to your setup (which folders to backup, drive letters of your NAS and your USB drive).


### MSI installer: Updating an existing installation

The setup will automatically detect the older version and update it.  
**Note that it will overwrite the `config.xml` file, so you should backup the existing file before you run the setup.**  
When the setup is finished, just overwrite the installed `config.xml` with your backed up version.  
*(yes, [this is a bug](https://github.com/christianspecht/roboshell-backup/issues/4)...but you need to work around it until I figure out how to make the setup keep existing config files)*  

### Encrypt your USB drives

As mentioned before, RoboShell Backup can write to [TrueCrypt](https://en.wikipedia.org/wiki/TrueCrypt)- and [VeraCrypt](https://en.wikipedia.org/wiki/VeraCrypt)-encrypted USB drives.  
You don't need to install TrueCrypt/VeraCrypt on any of your machines - you just need to set up each USB drive once *(see the following links for instructions and more information for [TrueCrypt](https://christianspecht.de/2012/04/30/roboshell-backup-1-1-now-with-truecrypt-integration/) and [VeraCrypt](https://christianspecht.de/2018/01/07/veracrypt-integration-for-roboshell-backup/))*.  
RoboShell Backup will then run the respective encryption tool directly from the USB drive, in portable mode.

> ### Please note:
> 
> Development of TrueCrypt [stopped in May 2014](https://en.wikipedia.org/wiki/TrueCrypt#End_of_life_announcement). The only version still available on the [official TrueCrypt website](http://truecrypt.sourceforge.net/) *(version 7.2)* supports *de*cryption only, therefore it's not suited for usage with RoboShell Backup.
>
> &nbsp;
>
> For more information about TrueCrypt's current status as well as an article about whether it's still secure *(it is!)*, and to download TrueCrypt 7.1a *(the version RoboShell Backup's integration was developed and tested with)*, see the [TrueCrypt Final Release Repository](https://www.grc.com/misc/truecrypt/truecrypt.htm).
>
> &nbsp;
>
> [VeraCrypt](https://en.wikipedia.org/wiki/VeraCrypt) is a fork of the last TrueCrypt version with additional security fixes.

### How to get RoboCopy and PowerShell

RoboCopy will be on your machine and in your `%PATH%` variable if you have at least Windows Vista (because it's included in the standard installation)  
If your have Windows XP or older, you need the Windows Resource Kit for your Windows version (RoboCopy is part of the Resource Kit).  
Links to the downloads are on the bottom of the [Resource Kit's Wikipedia page](https://en.wikipedia.org/wiki/Windows_Resource_Kit).

Windows PowerShell is part of all Windows versions since Windows XP SP2.  
So if you have at least XP SP2, it should be there. If it's not, you can get it [here](https://www.microsoft.com/powershell).

---

## How to build?

RoboShell Backup itself doesn't need to be built, because it consists just of batch files and PowerShell scripts.  
The only thing that needs to be compiled is the MSI setup, which is made using [WiX](https://wixtoolset.org/).

The build script is the file `Create Setup.bat` in the main folder of the repository, and it will download WiX via NuGet *(the ["WiX Toolset (unofficial)"](https://www.nuget.org/packages/WiX.Toolset/) package)*.

The script will create a zip file as well, using the [7-Zip Command Line Version](https://www.7-zip.org/download.html). It expects the `7za.exe` in the parent folder.

---

### Acknowledgements

RoboShell Backup makes use of the following open source projects:

 - [NuGet](https://www.nuget.org/)
 - [TrueCrypt](http://www.truecrypt.org/)
 - [VeraCrypt](https://www.veracrypt.fr)
 - [WiX](https://wixtoolset.org/)

---

<div id="license"></div>
### License

RoboShell Backup is licensed under the MIT License. See **[License.rtf](https://github.com/christianspecht/roboshell-backup/raw/master/src/License.rtf)** for details.

---

### Project Info

<script type='text/javascript' src='https://www.openhub.net/p/roboshell-backup/widgets/project_basic_stats?format=js'></script>
<script type='text/javascript' src='https://www.openhub.net/p/roboshell-backup/widgets/project_languages?format=js'></script>

