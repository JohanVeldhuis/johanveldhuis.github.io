---
id: 1357
title: Create a new room and set permissions in one step
date: 2009-10-04T20:38:34+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1357
permalink: /maak-een-nieuwe-vergaderzaal-aan-en-stel-de-rechten-in-in-een-stap/
categories:
  - Exchange
---
A really simple Powershellscript, the script below will make it possible to create a room and will add extra permissions to it:

_Param(
  
[string] $room
  
)
  
New-Mailbox -database &#8220;MBX-srv\Mailbox Database&#8221; -Name $room -OrganizationalUnit &#8220;Conference Rooms&#8221; -DisplayName $room -UserPrincipalName_ [_$room@domain.local_](mailto:$room@domain.local) _-Room
  
Add-adpermission $room -User domain\administrator -Extendedrights &#8220;Receive-As&#8221;_

Executing the script:: new-room.ps1 &#8220;meetingroom1&#8221;

The script will place all rooms in the OU named _Conference Rooms._ 

First the name will be read that is specified after the name of the parameter room$. After this the mailbox will be created as  a mailbox of the type room. The last step is setting the extra permissions, this is done by using the command _add-_adpermission, in this case the _receive-as_ will be added but also _send-as_ is an option.

Below a few links to the Technet pages of the used commands:

Technet add-adpermission <a href="http://technet.microsoft.com/en-us/library/bb124403.aspx" target="_blank">open</a>
  
Technet new-mailbox <a href="http://technet.microsoft.com/en-us/library/aa997663.aspx" target="_blank">open</a>