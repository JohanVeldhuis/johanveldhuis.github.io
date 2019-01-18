---
id: 1028
title: Standby Continuous Replication and log truncation
date: 2009-01-07T23:44:25+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1028
permalink: /standby-continuous-replication-and-logs-truncation/
categories:
  - Exchange
---
Standby Continuous Replication is a part of Exchange since service pack 1. With this option a copy from the storage group is made to another server for example a server in a DR site. This is done by copying the log files from the production server to the server in the DR site.

Before a SCR will work we need to activate it on the storagegroup, this can be done by using the following Powershell command:

```PowerShell
Enable-StorageGroupCopy -Identity Test -StandbyMachine sr-exch2 -ReplayLagTime 0.1:0:0
```

The command above will activate  SCR for a storagegroup and uses the standard values for seeding and log truncation.  The replaying of logs will be delayed for 1 hour instead of the standard 24 hours.

When SCR is activated on an existing storagegroup it may be necessary to seed it manually.

To start the seeding we need to execute the following Powershell commands:

```PowerShell
Suspend-StorageGroupCopy -Identity sr-exch\Test -StandbyMachine sr-exch2
```

This command will stop the copying temporarily. The next step is deleting all \*.log, \*.jrs, *.chk, and the .edb files from the path you defined as target server.

Next steo is starting the seeding, this can be done by the following Powershell command:

```PowerShell
Update-StorageGroupCopy -Identity sr-exch\Test -StandbyMachine sr-exch2
```

After seeding the automatic copying starts immediately.

It can happen that not all log files will get truncated from the DR server. There are 2 causes of this issue:

  * circular logging is enabled, with this option log files will be re-used this can only fixed by manually seeding the DR server.
  * the backup server cleans the log after a full backup, this can cause gaps in the in the sequence of logs which will result in logs not being deleted. Also for this a manual seed will solve the issue.

<a href="http://technet.microsoft.com/en-us/library/bb676465.aspx" target="_blank">Managing Standby Continuous Replication</a>

<a href="http://technet.microsoft.com/en-us/library/bb691015.aspx" target="_blank">How to Enable Standby Contuous Replication for an Existing Storage Group</a>