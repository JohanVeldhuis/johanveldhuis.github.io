---
id: 1357
title: Create a new room and set permissions in one step
date: 2009-10-04T20:38:34+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1357
permalink: /create-new-room-and-set-permissions-in-one-step/
categories:
  - Exchange
---
A really simple Powershellscript, the script below will make it possible to create a room and will add extra permissions to it:

```PowerShell
Param(
  
[string] $room
  
)
  
New-Mailbox -database 'MBX-srv\Mailbox Database' -Name $room -OrganizationalUnit 'Conference Rooms' -DisplayName $room -UserPrincipalName room@domain.local -Room
  
Add-adpermission $room -User domain\administrator -Extendedrights 'Receive-As&#8221;
```

Executing the script:: new-room.ps1 'meetingroom1'

The script will place all rooms in the OU named _Conference Rooms._ 

First the name will be read that is specified after the name of the parameter room$. After this the mailbox will be created as  a mailbox of the type room. The last step is setting the extra permissions, this is done by using the command _add-_adpermission, in this case the _receive-as_ will be added but also _send-as_ is an option.

Below a few links to the Technet pages of the used commands:

Technet add-adpermission <a href="http://technet.microsoft.com/en-us/library/bb124403.aspx" target="_blank">open</a>
  
Technet new-mailbox <a href="http://technet.microsoft.com/en-us/library/aa997663.aspx" target="_blank">open</a>