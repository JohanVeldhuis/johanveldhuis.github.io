---
id: 3191
title: Creating backup tasks for Snapmanager for Exchange using a script
date: 2013-06-09T18:48:13+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3191
permalink: /create-backup-tasks-snapmanager-for-exchange-via-a-script/
categories:
  - Scripts
---
Creating backups from Exchange databases is recommended just like backing up your other data. When using Netapp storage you can use the Snapmanager for Exchange to perform the backups. This product makes it possible to create a backup of a database within a few minutes.

Snapmanager does use the scheduled task from Windows for the scheduling part. Creating the backup tasks can be performed by using a wizard which is available in the Snapmanager console. When you want to do this for a few databases this is a method you can use but when you need to backup a large amount of databases it might be handy to create the backup tasks via a script.

The script is developed using Powershell and uses a XML template. The reason for this is that it is not possible to create a scheduled task via Powershell using the Windows 2003 template. Because Snapmanager for Exchange has this as s requirement so it can display the task in the NetApp console the only solution is to use a XML.

Before starting the script it may be required to modify some of the parameters in the XML:

  * **author_,_**_ _this field can be used to change the creater of the task
  * **interval**, can be used to change the intervals between backups, by default every 8 hour the task is started
  * **command,** the command which will run, you might need to change this depending on the location where Snapmanager is installed
  * **workingdirectory,** here the same is applicable as for _command _and might need to be changed when the Snapmanager installation directory is changed

The script can be used either by specifying the parameters of by using a CSV. Below are two examples of how you can use the script:

_Create_BackupSchedule.ps1 -database MBDB01 -server MBS01 -starttime 05:00AM _

Creates a scheduled task on a server called MBS01 and backups the database MBDB01 starting
  
at 05:00 AM.

_Create_BackupSchedule.ps1 -CSV c:\script\backups.csv_

Creates backup schedules on the servers using a CSV as input.

The script can be downloaded via the link below:

[download](http://gallery.technet.microsoft.com/Automate-creating-0bb7de79)