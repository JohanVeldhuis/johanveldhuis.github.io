---
id: 2335
title: How is the OAB being distributed?
date: 2011-10-03T20:43:26+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2335
permalink: /how-is-the-oab-being-distributed/
categories:
  - Exchange
---
 As you may know Exchange by default has one Offline Address Book (OAB) and one Global Address List (GAL). The GAL contains all objects for which Exchange attributes are configured. For example groups, userobjects and contacts.

The OAB will be generated once a day by the _generation server_. Within an Exchange environment only one server is responsible for generating the OAB. This is always a server which contains the Mailbox Role.

To find out which server is responsible for generating the OAB you can use two methods:

**Exchange Management Console (EMC)**

  * Open _Organization Management_
  * Select the _Mailbox_ object
  * Select the tab _Offline Address Book_

_[<img title="Exchange Management Console: Offline Address Book tab" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/emc_oab-300x17.jpg?resize=300%2C17" alt="" width="300" height="17" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/emc_oab.jpg)_

**Exchange Management Shell (EMS)**

  * Run the following cmdlet _get-offlineaddressbook | select name,server_

_[<img title="Exchange Management Shell: oab" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/ems_oab-300x38.jpg?resize=300%2C38" alt="" width="300" height="38" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/ems_oab.jpg)_

On the generation server you will find the _ExchangeOAB_ directory inside the Exchange directory. In this directory another folder is created. The name of this directory is the GUID from the OAB. Inside this directory several files are stored:

  * lzx, the addressbook files
  * oab.xml, the index which points to the addressbook files. Without the oab.xml file the client will not be able to find and download the addressbook files.

The OAB can be distributed via two methods:

  * Public Folders
  * Web

The Public Folders may be configured to have additional replica&#8217;s. This ensures that the OAB files are stored in multiple Public Folder databases. But how are the OAB files distributed to the Client Access Servers (CAS)?

To distribute the OAB to the configured CAS Servers the File Distribution service is used. This service runs on all CAS Servers and will check if a new OAB is available every 8 hours.

Sometimes this can has as effect that the users who are using Outlook in Online Mode and Outlook Web App can see new users earlier. This is sometimes very anoying.

To change this process you must change the _pollinterval_ via EMS. This can be done by using the _set-oabvirtualdirectory_ cmdlet:

```PowerShell
Set-OabVirtualDirectory -identity 'servername\OAB (Default Web Site)' -pollinterval 120
```

Using the example above we will reconfigure the CAS Servers to check every 2 hours for an update. But keep in mind that the GAL will only be generated once per day. If you wish to update an object perform the following steps:

  * update the object
  * wait for AD replication
  * run the following cmdlet_ Update-GlobalAddressList &#8220;Default Global Address List&#8221;_
  * run the following cmdlet _Update-OfflineAddressBook &#8220;servername\OAB (Default Web Site)&#8221;_
  * run cmdlet_ Update-FileDistributionService_

If you only want to distribute the OAB to the CAS Servers run the following cmdlet _Update-FileDistributionService._ This will ensure that the CAS Servers will check if an update is available for the OAB.

If there are still issues you will need to enable logging. The logging needs to be enabled on the CAS Servers which are responsible for distributing the OAB:

```PowerShell
Set-EventLog -Identity 'MsExchangeFDS\General' -Level Expert

Set-EventLog -Identity 'MsExchangeFDS\FileReplication' -Level Expert
```

Force a replication using the File Replication service to verify if an update is available:

```PowerShell
Update-FileDistributionService -identity servername
```

Once the cmdlet is executed check the _application_ event log to verify the replication has occured.

[<img title="Update-FileDistributionService" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/update-frs-300x110.jpg?resize=300%2C110" alt="" width="300" height="110" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/update-frs.jpg)

In the screenshot above you can see the data synchronisation has started. In this case the Web distribution has just been enabled but the CAS server doesn&#8217;t have a copy.

[<img title="update-FileReplicationService completed" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/update-frs-completed-300x117.jpg?resize=300%2C117" alt="" width="300" height="117" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/update-frs-completed.jpg)

Once the OAB has been synchronized succesfully you will see the message above in the event log. When you browse to the directory X:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\OAB zal you will find a directory which contains both the oab.xml and addressbook files.

Don&#8217;t forget to reset the logging level back to the original level once ready with troubleshooting:

```PowerShell
Set-EventLog -Identity 'MsExchangeFDS\General' -Level Lowest
  
Set-EventLog -Identity 'MsExchangeFDS\FileReplication' -Level Lowest
```

Here ends the blog about how the OAB is distributed to the CAS Servers. If you would like to have more information about the cmdlet&#8217;s have a look at the sites below:

Technet: Update-FileDistributionService <a href="http://technet.microsoft.com/en-us/library/bb124697.aspx" target="_blank">open</a>
  
Technet: Update-GlobalAddresslist: <a href="http://technet.microsoft.com/en-us/library/bb266966.aspx" target="_blank">open</a>
  
Technet: Update-OfflineAddressBook: <a href="http://technet.microsoft.com/en-us/library/aa995979.aspx" target="_blank">open</a>