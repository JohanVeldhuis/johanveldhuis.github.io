---
id: 314
title: 'Add mailcontacts via a  CSV and add the new user to a distributiongroup'
date: 2008-04-23T20:36:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=314
permalink: /gebruikers-via-csv-toevoegen-en-vervolgens-aan-een-distibutiegroep-toevoegen/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2007
  - Software
---
Today I did some experimentations with Powershell and created a script which creates mailcontacts from a CSV by importing the name, e-mail adddress and OU. When the mailcontact is created it will be added to a distributiongroup.

When you want to use the file you can just copy and paste it in Notepad and save is as a ps1 file. When you gone execute the command you need to give some parameters with it, it will looks like this:

_adduserstodg.ps1 -CSVFile &#8220;c:\users.csv&#8221;_

The easiest way is to put the file in the scripts directory from Exchange.

**Complete script**

_Param(_

[string] $CSVFile,

)

_Import-CSV $CSVFile | ForEach-Object -Process {New-MailContact -Name $\_.name -ExternalEmailAddress $\_.email -OrganizationalUnit $_.ou}_

_Import-CSV $CSVFile | ForEach-Object -Process {Add-DistributionGroupMember -Identity DistibutionGroupName -Member $_.name}_