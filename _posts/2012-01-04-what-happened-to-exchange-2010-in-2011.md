---
id: 2379
title: What happened to Exchange 2010 in 2011
date: 2012-01-04T21:41:19+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2379
permalink: /what-happened-to-exchange-2010-in-2011/
categories:
  - Exchange
---
2012 has arrived, but what has happened in the past year with Exchange 2010? In this blog we will have a look at some of the high lights of the news about Exchange 2010 in 2011.

If we summarize this year you could use the following words:

[<img class="aligncenter" title="tagcloud" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/01/tagcloud-300x176.jpg?resize=300%2C176" alt="" width="300" height="176" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/01/tagcloud.jpg)

**January**

In the begin of January Exchange was awarded as InfoWorld&#8217;s Technology of the Year award for the best mail server 2011.

Microsoft published a statement on GAL Segmentation on the 27th of January which was till this moment still not supported in Exchange 2010. The whitepaper which was available for Exchange 2007 would not be updated for Exchange 2010. They announced another solution would be available in Exchange 2010 SP2, this feature got a name a few months later Address Book Policies.

One day after the statement Kevin Allison announced that UDP notifications would be reintroduced in Exchange 2010. This due to the fact that many customers asked for it. The functionality would be available after installing Rollup 3. The result of reintroducing the feature was that the release date of the Rollup would be rescheduled.

**February**

The Windows Server team released SP1 for Windows 2008 R2. But what does this mean for Exchange 2010? On the 11th of February the MsExchange Team came with an answer. Both Exchange 2010 RTM and Exchange 2010 SP1 will be supported with this SP. For Exchange 2010 SP1 the seperate hotfixes 979744, 983440, 979099, 982867 and 977020 are not required anymore. This hotfixes are included in the Service Pack for Windows 2008 R2.

**March**

On the 7th of March Microsoft released Rollup 3 for Exchange 2010 SP1. Everyone was curious about the UDP notifications feature which became available with this Rollup. But short after the release the fora did contain a lot of messages about Exchange 2010 i.c.w. BlackBerry devices. Messages would be send twice which of course could have a big impact for some companies.

On the 14th of March Microsoft published the following message on the [MsExchangeTeam](http://blogs.technet.com/b/exchange/archive/2011/03/14/exchange-2010-sp1-rollup-3-and-blackberrys-sending-duplicate-messages.aspx) blog:

_We have received notification of an issue impacting some customers which have_ 
  
_RIM BlackBerry devices connecting to an Exchange 2010 SP1 RU3 environment. At_ 
  
_this stage we are actively working with RIM to identify the exact scenarios in_ 
  
_which customers are reporting this issue in order to narrow down the root cause_ 
  
_of the problem and identify a suitable resolution for it._

_As a precautionary measure we have deactivated the download page for Exchange_ 
  
_2010 SP1 RU3 until we can identify the appropriate next steps._

Rollup 3 was removed the update from the download center.

**April**

OWA Automobile Edition, Twitter-Ready Mail, Boss OOFs, Email Etiquette Enforcement (EEE) Agent, Automatic Randomized MRM (ARM) Assistant, Active Inbox Rules (AIR) Agent, Mobile Read Receipts and Exchange Configuration. All new features which were announced on the 1ste of April. All these features where one big April foul which caused a lot of nice reactions from some people.

In March Rollup 3 was removed, on the 6th of April Rollup 3v3 was released. This release fixe the BlackBerry issue and contained the original fixes which where included in Rollup 3.

[<img title="activesync_logo" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/01/activesync_logo-150x150.png?resize=150%2C150" alt="" width="150" height="150" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/01/activesync_logo.png)

On the 13th of April Microsoft announced the Exchange ActiveSync Logo Program. This certification program for ActiveSync devices was created by Micrsoft together with an external lab. Devices should support the following features to be certified for the program:

  * Direct Push email, contacts & calendar
  * Accept, Decline & Tentatively Accept meetings
  * Rich formatted email (HTML)
  * Reply/Forward state on email
  * GAL Lookup
  * Autodiscover
  * ABQ strings (device type and device model) provided
  * Remote Wipe
  * Password Required
  * Minimum Password Length
  * Timeout without User Input
  * Number of Failed Attempts

Microsoft did release the program to give enterprises a way to improve the support they can give to their users which are using several kinds of mobile devices.

On the 15th of April a new recommendation was published on the MsExchange Team blog: Enable Kerberos authenication for clients. One of the reasons is because NTLM might cause a bottleneck. Before Exchange 2010 SP1 Kerberos was not really an option. In SP1 Microsoft did introduce a functionality which made it possible to use an  alternate service account (ASA). This account needs to be assigned to all CAS Servers in the Array and needs to contain the correct service principale names (SPN&#8217;s).

To simplify the configuration Microsoft released a script called: _RollAlternateServiceAccountPassword.ps1_. Using this script it was possible to configure the ASA on all CAS Array members. Besides this the script contained an option to create a scheduled task which changes the password on pre-defined frequency.

Besides the new recommendation a .NET update caused some issues. By installing the update on an Exchange 2010 Server which has Windows 2008 SP2 of Windows 2008 R2 RTM as OS the following issues might occur:

  * Exchange Management Shell does not start
  * Exchange Management Console does not start
  * There might be a crash in Exchange Mailbox Replication Service (it is not
  
    clear yet if this is related)
  * Event Viewer might have trouble opening

On the 20th of April Microsoft did release an update to fix this issue.

**May**

On the 16th of May an announcement was made about changes which are made to in the hardware virtualization support for Exchange 2010. These changes were only applicable for Exchange 2010 SP1:

  * The Unified Messaging server role is supported in a virtualized environment.
  * Combining Exchange 2010 high availability solutions (database availability
  
    groups (DAGs)) with hypervisor-based clustering, high availability, or migration
  
    solutions that will move or automatically failover mailbox servers that are
  
    members of a DAG between clustered root servers, is now supported.

The day after Kevin Allison announced SP2 on TechEd Atlanta. SP2 would contain a lot of fixes for issues customers reported and a few new features:

  * Outlook Web App (OWA) Mini
  * Cross-Site Silent Redirection for Outlook Web App
  * Hybrid Configuration Wizard
  * Address Book Policies

On TechEd Atlanta the new features were included in a presentation of  [Greg Taylor](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2011/EXL326). SP2 would be available in the second half of 2011.

**June**

On the 22 of June it was time for Rollup 4. First everything looked OK. But on the 13th of July Microsoft did publish a post which had as title _Exchange 2010 SP1 RU4 Removed from Download Center._

Rollup 4 introduced some issues when moving or copying folders. The subfolders and content would be deleted from these folders. But the items could recover the items by using the Recoverable Item folder.

It took 2 weeks before Rollup4v2 was released on the 27th of July.

**July**

On the 5th of July Microsoft did announce a new tool: the PST Capture tool. This tool could be used to search the network for PST files and import them in Exchange 2010. The tool was planned for in 2011.

**August**

On the 23rd of August Rollup 5 was released. Of cource a lot of people did hold back after the issues in the previous two Rollups. But Rollup 5 did not contain a lot of big issues.

In March of this year the Internet Explorer team did release the new version of Internet Explorer, IE 9. After a few days some issues where reported about IE 9 i.c.w. the Exchange Management Console (EMC). When closing the EMC the following message was displayed:

[<img title="EMC: Close all dialog boxes" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/04/ex_close-150x145.jpg?resize=150%2C145" alt="" width="150" height="145" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/04/ex_close.jpg)

In August the Exchange Team published a statement about the issue. The Exchange Team did investigate the issue together with the MMC and Internet Explorer Team for a solution. Finally a special hotfix was released which solved the issue. In december 2011 this hotfix was included in a security update for IE 9([KB 2618444](http://support.microsoft.com/kb/2618444)).

**October**

Rollup 6 was the latest Rollup which was release for Exchange 2010 SP1 in 2011. This Rollup was released by Microsoft on the 27th of October.

On the 11th of October the support ended for Exchange 2010 RTM. Starting from this date only support will be given on Exchange 2010 environment which are running SP1.

In Exchange 2010 SP1 the /hosting parameter was introduced. By using this parameter to install Exchange it was possible to create a multi-tenant Exchange 2010 environment. The solution offerered delivered a small set of functions to end users compared to an on-premise Exchange 2010 environment. Besides this it doesn&#8217;t contain any automation tools for example for creating users.

In October Microsoft announced that the /hosting parameter would not be futher developed. Hosting parties who already implemented Exchange this way will still be supported by Microsoft according to the Exchange Support Cycle.

**November**

On DevConnections, begin November, it was time for some new about SP2.  Kevin Allison announced that SP2 would be released at the end of November/begin December.

**December**

Eventually on the 12th of December Microsoft did publish the following message on the MsExchangeTeam blog:

_I had previously mentioned that Exchange 2010 Service Pack 2 would be coming this year – and it’s here! I’m pleased to announce the availability of Exchange Server 2010 Service Pack 2 which is ready to download._