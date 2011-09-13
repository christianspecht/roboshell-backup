# RoboShell Backup

RoboShell Backup is a simple personal backup tool.  
It uses Microsoft's [RoboCopy](http://en.wikipedia.org/wiki/Robocopy) to copy files, and it is written in [Windows PowerShell](http://en.wikipedia.org/wiki/Windows_PowerShell).

## What does it do?

RoboShell Backup works best if you have the following setup:

- Several computers, and on each one is local data that needs to be backed up regularly.
- A NAS drive to which you can copy the local data from all your computers.
- One or more external USB drives to take backups of your whole NAS drive.

If your setup looks like this, then RoboShell Backup is for you: It helps you automate the copying stuff.

RoboShell Backup consists of two batch files:

- PcToNas.bat copies folders from your local machine to a NAS drive.
- NasToUsb.bat backups the whole NAS drive to an external USB disk.

There is a config file in which you can specify the local folders to be backed up, and the drive letters of the NAS and USB drives.

## How to install?

In order to use RoboShell Backup, you need to have RoboCopy and Windows Powershell installed and in your %PATH% variable.  
Depending on your Windows version, this may already be the case.

The installation itself is easy, just run the setup.  
When the installation has finished, the config file will open automatically in Notepad. You need to change the values in the config file once, according to your setup (which folders to backup, drive letters of your NAS and your USB drive).

For more information on the installation (and how to get RoboCopy and Windows PowerShell if it's not already on your machine), see the [wiki](https://bitbucket.org/christianspecht/roboshell-backup/wiki/Install).

### Developers

Information for developers is available in the [wiki](https://bitbucket.org/christianspecht/roboshell-backup/wiki/Developers).

### License

RoboShell Backup is licensed under the MIT License. See **License.rtf** for details.