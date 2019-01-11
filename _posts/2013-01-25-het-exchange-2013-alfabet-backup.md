---
id: 2665
title: 'The Exchange 2013 alphabet: Backup'
date: 2013-01-25T21:32:26+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2665
permalink: /het-exchange-2013-alfabet-backup/
categories:
  - Exchange
---
**The Exchange alphabet: B**ackup

The second blog in the Exchange alphabet blog series is about backup.

In this blog we will only have a look at the backup NOT at the restore, we are just at the letter **b.** In a future blog we will discuss the restore options.

As with every solution it’s also necessary to make a backup of your Exchange environment. Backing up Exchange can be split up in a few parts:

  * OS
  * Exchange Server itself
  * Exchange databases

The last one is probably the most import one, losing data can have a huge impact on an organization.

Backups can be performed using several methods including traditional backups and snapshots. But for the databases there is another option which is known as Exchange Native Data Protection. Those of you who have been working with the Mailbox Calculator should have seen this term.

**What is Native Data Protection?**

But what does it actually mean Exchange Native Data Protection? This means that you will use built-in options to protect your data.

One of the options you can use a DAG which includes a maximum of 16 copies of a database. For those of you who are unfamiliar with DAGs a short explanation.

Using a Database Availability Group (DAG) you can create multiple copies of a database in an Exchange environment. Only one copy can be active of each database can be active. A maximum of 16 copies can be created per database which means a copy of a database is hosted on 16 mailbox servers. Each copy has its own activation preference. This is one of the parameters used to determine which copy will be activated if the primary copy fails. Using log shipping the copies of each database are kept up-to-date.

_Remark: in an upcoming blog we will discuss the DAG details and configuration_

One of the parameters that can be configured on a copy is replay lag time. Using this parameter you can configure how many days the Information Store service on a server has to wait before replaying the logs that have been copied to the server. The maximum value for this parameter is 14 days which means logs will be replayed 14 days after they have been copied to the server.

For example:

_Set-MailboxDatabaseCopy -Identity MBDB01\MBXBE03 -ReplayLagTime 3.0:0:0_

This example will wait 3 days before the logs are being replayed on server MBXBE03 for database MBDB01.

Now back to the backup story. Using this method we ensure that multiple copies of a database are in our Exchange organization so there are multiple copies of the data spread among several servers. Does one server completely fail no problem we’ve got another copy which can be activated automatically and users can continue to work.

But what about the lagged copy which I meant earlier. The lagged copy is the copy which has not yet replayed all log files yet. This gives you the ability to activate the copy either:

  1. Replaying all files
  2. Replay the log files partially

Besides the DAG Exchange does contains some additional features which are not really backup features but can be used to restore items. In Exchange 2013 the Recoverable Items folder and Hold policy make it possible to retain a copy of each deleted or modified item. It was originally introduced in Exchange 2010 to replace the dumpster which was available in Exchange 2007.

**What if Native Data Protection is not enough?**

If you decide not to only use the native data protection but also want to have a “traditional” backup then you will need additional software. At this moment only Windows Server Backup and Microsoft’s System Center 2012 – Data Protection Manager do have support for using the VSS writer which is supported to create a backup of the databases of Exchange 2013.

Compared to Exchange 2010 and Exchange 2007 there has been a big change when looking at the VSS writer. In those versions there were two VSS writers available: one in the Information Store en one in the replication service. In Exchange 2013 we’ve only got one VSS writer called the Microsoft Exchange Writer. This functionality can only be found in the Microsoft Exchange Replication Service so no writer is included in the Information Store anymore. One remark must be made, it is still necessary that the Information Store service is running else the VSS writer will not be advertised.

[<img class="aligncenter size-medium wp-image-2666" title="Microsoft Exchange Writer" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Microsoft-Exchange-Writer-300x43.png?resize=300%2C43" alt="" width="300" height="43" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Microsoft-Exchange-Writer.png?resize=300%2C43&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Microsoft-Exchange-Writer.png?w=506&ssl=1 506w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Microsoft-Exchange-Writer.png)

It is expected that several other vendors are now working hard to get there software ready and supported for Exchange 2013. In the coming few months they will probably release there software. So if you are using other software then Windows Server Backup or DPM 2012 make sure you verify if and when your backup software vendor will support Exchange 2013.

**What happens exactly during a traditional backup?**

But what does exactly happen during a VSS backup? We will look at the steps performed by Windows Server Backup but these steps are generally the same for other software:

  1. A VSS snapshot is created by Windows Server Backup using the Microsoft Exchange Writer
  2. A consistency check is performed using ESEUTIL to make sure all are files are in a correct state. With a correct state it means that they can be recovered. Because a snapshot has already been created the consistency check is performed against:

  * The production Exchange data
  * The changed blocks in the shadow copy storage

  1. There are now two options:

  * The consistency check fails: in this case the backup will fail
  * The consistency check completes successfully: the process can continue

  1. If the check is completed successfully the backup data is being copied to the backup destination
  2. Once this has been completed the log files will be cleared and the database will be marked as backed up.

The process can be easily monitored by looking in the Application log of the Mailbox Server. As a lot of information is logged in the Application log you could create a filter which only displays events which have the _MsExchangeRepl _as source:

[<img class="aligncenter size-medium wp-image-2673" title="VSS Backup events" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/VSS-Backup-events-300x149.png?resize=300%2C149" alt="" width="300" height="149" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/VSS-Backup-events.png?resize=300%2C149&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/VSS-Backup-events.png?w=538&ssl=1 538w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/VSS-Backup-events.png)

You can expect the following event id&#8217;s during the process:

[table id=34 /]

So here raises another question, how to deal with the log files if you are using only Exchange Native Data Protection?

**Continuous Replication Circular Logging**

If you are planning to use only Exchange Native Data Protection logs will not be flushed anymore. This is due to the fact that the log flushing is a part of the VSS writer process. If you do not take any action the log disk will fill up and eventually will cause that the databases to be dismounted automatically.

To prevent this from happening you will need to enable circular logging on the databases. You might think but circular logging will overwrite existing log files so how does the replication process will handle this?

Well since Exchange 2010 a new form of circular logging is introduced called Continuous Replication Circular Logging. This process is managed by the Microsoft Exchange Replication Service and ensures that no log files will be deleted if they have not been replicated and replayed in the other database copies.

So when does log truncation occur when a lagged copy is used?

First I should mention the criteria are different for the non-lagged copies and lagged copies:

_Non-lagged copies:_

  * Verify if the log file is below the checkpoint
  * Do the other non-lagged copies of the database agree with the deletion
  * Has the log file been inspected by all lagged copies of the database

If all criteria’s are met the log files will be flushed.

_Lagged copies:_

  * Verify if the log file is below the checkpoint
  * Verify if the log file is older than the values of the replaylagtime and truncationlagtime parameters
  * Is the log file deleted on the active copy of the database

If all criteria’s are met the log file will be flushed on the server hosting the lagged copy.

**How to monitor the backup process**

Besides letting the backup software send you a message that the backup has succeeded you can check several parameters of the databases.

The cmdlet which can be used to verify this parameters is _Get-MailboxDatabase_ don’t forget to include the _–status_ parameter else some parameters won’t have values.

For example we want to the values of all backup related parameters of all our mailboxdatabases:

_Get-MailboxDatabase –status|select Identity, Status, BackupInProgress, SnapshotLastFullBackup, SnapshotLastIncrementalBackup, SnapshotDifferentialBackup, SnapshotLastCopyBackup, LastFullBackup, LastIncrementalBackup, LastDifferentialBackup, LastCopyBackup_

When running the cmdlet above you when the backups runs you can expect an output like this:

[<img class="aligncenter size-medium wp-image-2667" title="Backup in progress" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-in-progress-300x63.png?resize=300%2C63" alt="" width="300" height="63" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-in-progress.png?resize=300%2C63&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-in-progress.png?w=962&ssl=1 962w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-in-progress.png)

Once the backup has finished you will see this:

[<img class="aligncenter size-medium wp-image-2668" title="Backup completed" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-completed-300x62.png?resize=300%2C62" alt="" width="300" height="62" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-completed.png?resize=300%2C62&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-completed.png?w=959&ssl=1 959w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Backup-completed.png)

In this example we created a VSS Copy backup using Windows Server Backup. The _SnapshotLastCopy_ tells us that a snapshot is used to create the backup. The _LastCopyBackup_ will display the date and time of the last backup.

Using this output you can easily check when the last backup has occurred and which method is used. In the useful links parts there’s a link to Paul Cunninghams database backup alert email script. This script checks the backup parameters and generates a HTML form which is then mailed to the system administrator.

Here ends the second blog in the Exchange ABC series. In this blog we did have a look at the backup: which methods are available, how it works, and how you can monitor it.

Below you will find some useful links to sites containing backup related information.

**Useful links:**

How to Set Up an Automated Exchange 2010 Database Backup Alert Email:

<http://exchangeserverpro.com/set-automated-exchange-2010-database-backup-alert-email>

Exchange 2010: Implementing a dedicated backup network for a Database Availability Group…:

<http://blogs.technet.com/b/timmcmic/archive/2011/10/25/exchange-2010-implementing-a-dedicated-backup-network-for-a-database-availability-group.aspx>

Exchange 2007 / 2010: Windows Server Backup and Performance Issues:

<http://blogs.technet.com/b/timmcmic/archive/2011/07/12/exchange-2007-2010-windows-server-backup-and-performance-issues.aspx>