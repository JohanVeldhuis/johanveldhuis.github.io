---
id: 3159
title: 'The Exchange 2013 alphabet: Database Availability Group &#8211; part 2'
date: 2013-04-30T21:09:51+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3159
permalink: /the-exchange-2013-alphabet-database-availability-group-part-2/
categories:
  - Exchange
---
In the first part of this blog we looked at the theory and some examples. In this blog we will continue with configuring and managin the DAG.

In this case we have an environment which consists out of two multirole Exchange 2013 servers. Because this is not an odd amount we will need to use a file share witness. Ideally this fileshare witness is placed on another Exchange server (for example your CAS) but it can also be located on an generic server.

First step is to prepare our FSW. It is important the _Exchange Trusted Subsystem_ is a member of the local administrators group of the server. This because Exchange uses this account under the hood to perform the needed actions.

If the server doesn’t contain the File Server feature add it by using the following Powershell cmdlet:

_Add-WindowsFeature FS-FileServer_

Once these actions have been performed we can continue with configuring our DAG.

If you are familiar with DAG’s from Exchange 2010 pay attention to the next step. You will need to pre-stage the Cluster Name Object (CNO). Open ADUC and create a _computeraccount_ which matches the name you want to give to the DAG, for example _DAG01_. After creating the object _disable_ the account and get the properties of the object. Select the _security tab_ and add the _computeraccount_ of the computer which will be the first member of the DAG. Repeat this last step for the _Exchange Trusted Subsystem_ security group.

Of course you can also script the creation of this object. Fellow The UC Architects member Michel de Rooij has created a script which can be found [here](http://eightwone.com/2012/12/20/cluster-name-object-pre-staging/).

Next step is to create the DAG, we will use the Exchange Management Shell for this:

_New-DatabaseAvailabilityGroup -Name Exchange\_DAG01 -WitnessServer FS01 -WitnessDirectory C:\Exchange\_DAG01  -DatabaseAvailabilityGroupIpAddresses 192.168.1.90_

By using the cmdlet above we will create a DAG which has the name _DAG01_ and assign _FS01_ as the witness server. On the FS01 a directory will be created called _Exchange_DAG01._ As last step we will assign an IP address to the DAG _192.168.1.90_.

Now we have created the DAG it’s time to add the mailbox servers to it. This can be done by using the _Add-DatabaseAvailabilityGroupServer_ cmdlet:

_Add-DatabaseAvailabilityGroupServer -Identity DAG01 -MailboxServer EX01_ 

**Remark:** If the Windows Failover Clustering components are missing the cmdlet will install then automatically. Keep in mind that this might require a restart of your Exchange Server. The cmdlet will in that case only install the components and will not add the server to the DAG. So if the server is rebooted run the cmdlet again to add the server to the DAG. However it may not be required to reboot the server in that case the server will be added to the DAG directly.

_[<img alt="Add-DatabaseAvailabilityGroupServer" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-DatabaseAvailabilityGroupServer-300x106.png?resize=300%2C106" width="300" height="106" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-DatabaseAvailabilityGroupServer.png)_

Once the first server is completed repeat the same step for the other server:

_Add-DatabaseAvailabilityGroupServer -Identity DAG01 -MailboxServer EX02_

To finish the configuration of the DAG we will need to add the additional copies of the databases. For adding a copy you will need to use the _Add-MailboxDatabaseCopy_ cmdlet:

_Add-MailboxDatabaseCopy -Identity MBDB01 -MailboxServer EX02 -ActivationPreference 2_

[<img alt="Add-MailboxDatabaseCopy" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-MailboxDatabaseCopy-300x13.png?resize=300%2C13" width="300" height="13" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-MailboxDatabaseCopy.png)

After the copy is added you will need to restart the _Microsoft Exchange Information Store_ service on the target server. This has to do with the &#8220;Managed Store&#8221; as introduced in Exchange 2013. Collegue Exchange MVP Tony Redmond published a nice blog. So if you want to know the indept details I recommend to visit[ this](http://windowsitpro.com/blog/why-exchange-2013-asks-you-restart-information-store-after-creating-new-database) page.

This will add a copy of the database called MBDB01 to mailboxserver EX02 and will set the activation preference to 2.

Repeat the step for the database hosted by EX02:

_Add-MailboxDatabaseCopy -Identity MBDB02 -MailboxServer EX01 -ActivationPreference 2_

Once the cmdlets have been ran you can use the _Get-MailboxDatabaseCopyStatus_ cmdlet to verify the status of the databases and its copies:

[<img alt="Get-MailboxDatabaseCopyStatus" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Get-MailboxDatabaseCopyStatus-300x28.png?resize=300%2C28" width="300" height="28" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Get-MailboxDatabaseCopyStatus.png)

In the example above the first copy is mounted and the content index state is healthy. However for the second copy of the database the content index is FailedAndSuspended. In case of a *over this results in users who will start to have issues when searching their mailbox.

To fix this issue we need to run the _Update-MailboxDatabaseCopy_ cmdlet like this:

_Update-MailboxDatabaseCopy -Identity MBDB01\EX02 –CatalogOnly_

After the confirmation the catalog will be updated on the second copy:

[<img alt="Add-MailboxDatabaseCopy" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-MailboxDatabaseCopy-300x13.png?resize=300%2C13" width="300" height="13" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Add-MailboxDatabaseCopy.png)

Let’s look at another issue:

[<img alt="Get-MailboxDatabaseCopyStatus" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Get-MailboxDatabaseCopyStatus-2-300x9.png?resize=300%2C9" width="300" height="9" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Get-MailboxDatabaseCopyStatus-2.png)

In this case the second copy failed completely so we do have to update both the database and the catalog:

_Update-MailboxDatabaseCopy -Identity MBDB02\EX01_

[<img alt="Update-MailboxDatabaseCopy" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Update-MailboxDatabaseCopy-300x86.png?resize=300%2C86" width="300" height="86" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Update-MailboxDatabaseCopy.png)

After confirming the reseed is performed and both the database and catalog should be healthy again.

If we want to perform maintenance on the DAG members we will need to put the member in maintenance mode. This can be done by using the _StartDagServerMaintenance_ script which can be found in the default script directory of Exchange.

[<img alt="StartDagServerMaintenance" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/StartDagServerMaintenance-300x23.png?resize=300%2C23" width="300" height="23" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/StartDagServerMaintenance.png)

By adding the _Server_ parameter we can specify a server which we would like to put in maintenance. Once this is done it will check if the PAM role and which databases are currently activated on the server and will try to move them to another DAG member.

Once we have performed some maintenance on EX02 we will need to take it back in production. This can be done by using the _StopDagServerMaintenance_ script:

_.\StopDagServerMaitenance.ps 1 –Server EX02_

Once this script has been executed verify if the databases are healthy using the _Get-MailboxDatabaseCopyStatus_ cmdlet. The script will not re-balance the databases so we will need to do this manually. To move the active database we need to run the _Move-ActiveDatabase_ cmdlet:

_Move-ActiveMailboxDatabase MBDB02 –ActivateOnServer EX02_

[<img alt="Move-ActiveMailboxDatabase" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Move-ActiveMailboxDatabase-300x49.png?resize=300%2C49" width="300" height="49" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/Move-ActiveMailboxDatabase.png)

After confirming the activation on the other server the database will be moved to _EX02._

Here ends the second part of the Exchange Alphabet about Database Availability Groups. In this part we had a look how to create a DAG and perform several operations