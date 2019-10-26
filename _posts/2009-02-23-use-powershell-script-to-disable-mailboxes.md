---
id: 1117
title: Use Powershell script to disable mailboxes
date: 2009-02-23T00:34:13+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1117
permalink: /use-powershell-script-to-disable-mailboxes/
categories:
  - Exchange
---
Why do it the hard way instead of the easy way,  imagine you&#8217;ve got several mailboxes which you would like to disable and you&#8217;ve got them listed in a CSV file. Why shouldn&#8217;t you use Powershell to do this.

Save the script below in the Exchange 2007 scripts directory:

```PowerShell
dismb.ps1

Param(
  
[string] $CSVFile
  
)
  
Import-CSV $CSVFile | ForEach-Object -Process {disable-Mailbox $_.Name}
```

Execute it via Powershell by typing the following _.\dismbps1 &#8220;c:\csvfile.csv&#8221;_

The script will open the CSV you will give as a parameter when executing the command and will take read the column _Name_.

A warning will be displayed which asks you to confirm the changes you want. When acknowleding the alarm the mailboxes will be disabled.