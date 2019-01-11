---
id: 2244
title: Can’t remove the Exchange Virtual Server
date: 2011-06-10T19:42:21+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2244
permalink: /exchange-virtual-server-kan-niet-verwijderd-worden/
categories:
  - Exchange
---
During the removal of an Exchange 2003 cluster I had the issue that I couldn’t remove the Exchange Virtual Server from the Cluster Administrator.

In the event log nothing special was logged so it was time to dig into the log files which are created during this process. Since the removal of Exchange Virtual Server is a cluster related task the cluster log file was needed. This is located in the c:\windows\cluster directory.

When having a look at the log you will see that several settings are checked before the Exchange Virtual Server is removed.

_[11:21:42] Leaving ScTestAceOnObject
  
_ _[11:21:42] ANONYMOUS LOGON does have READ permissions for MDB objects on the organization
  
_ _[11:21:42] Checking to see whether the Exchange Domain Servers group has been DENIED Receive-As permissions on the Servers container(s)
  
_ _[11:21:42] Checking the ACL on the Servers container in the admin group &#8220;First Administrative Group&#8221;
  
_ _[11:21:42] Entering ScTestAceOnObject
  
_ _[11:21:42] Attempting to get DOB for DN &#8220;/dc=LOCAL/dc=Corp/cn=Configuration/cn=Services/cn=Microsoft Exchange/cn=Corp/cn=Administrative Groups/cn=First Administrative Group/cn=Servers&#8221;
  
_ _[11:21:42] Attempting to read security descriptor from DOB
  
_ _[11:21:42] Attempting to initialize CAce object
  
_ _[11:21:42] Testing to see if given ACE is present
  
_ _[11:21:42] Test succeeded; fACLPresent = TRUE, fExtraRights = FALSE
  
_ _[11:21:42] The ACE tested for is present in the ACL of this object
  
_ _[11:21:42] Leaving ScTestAceOnObject
  
_ _[11:21:42] The Exchange Domain Servers group has been DENIED Receive-As permissions on the Servers container(s)
  
_ _[11:21:42] The required permissions have already been set
  
_ _[11:21:42] Leaving ScDetermineIfLocalDomainServerGroupHasAlreadyBeenACLedOnExchangeCT
  
_ _[11:21:42] Entering ScFindRoutingGroupThatContainsServer
  
_ _[11:21:42] Leaving ScFindRoutingGroupThatContainsServer
  
_ _[11:21:42] ScPRQ_ServerIsNotHomeServerForPostmasterOfNonEmptyOrg (f:\tisp2\admin\src\udog\excommon\prereq.cxx:2981)
  
_ _Error code 0X80072030 (8240): There is no such object on the server.
  
_ _[11:21:42] CCompServer::ScCheckEVSPrerequisites (f:\tisp2\admin\src\udog\exsetdata\components\server\compserver.cxx:1405)
  
_ _Error code 0X80072030 (8240): There is no such object on the server.
  
_ _[11:21:42] ScSetupExchangeVirtualServer (f:\tisp2\admin\src\udog\exsetdata\exsetds.cxx:1541)
  
_ _Error code 0XC103FC97 (64663): Setup encountered an error while checking prerequisites for the component &#8220;Microsoft Exchange Server&#8221;:_ _0X80072030 (8240): There is no such object on the server.
  
_ _[11:21:42] Leaving ScSetupExchangeVirtualServer_

For example several ACL’s are verified. Besides the ACL checks the removal process will verify if the postmaster mailbox is homed on this server. By default the account used for installing Exchange 2003 will automatically be the postmaster. If the mailbox can’t be found, because it’s deleted, the process will be aborted.

But how can you solve it? Well first and easiest method maybe to restore the account and mailbox from the backup. If this is not possible you might decide to re-assign the postmaster mailbox to another account.

To re-assign the mailbox to another account you must use ADSIEDIT. Before making any changes with ADSIEDIT make sure you have a correct and recent back-up of your Active Directory.

Once you have confirmed this it’s time to make the change. Open the Configuration partition of Active Directory and expand the following nodes:

  * CN=Services
  * CN=Microsoft Exchange
  * CN=Organization Name, for example Corp

Get the properties of _CN=Global Settings_ and search for the attribute called _MsExchAdminMailbox_. You will see the value of this attribute has been a deleted object:

[<img class="alignnone size-medium wp-image-2245" title="Postmaster mailbox" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/06/adsiedit-270x300.jpg?resize=270%2C300" alt="" width="270" height="300" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/06/adsiedit.jpg?resize=270%2C300&ssl=1 270w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/06/adsiedit.jpg?w=405&ssl=1 405w" sizes="(max-width: 270px) 100vw, 270px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/06/adsiedit.jpg)

In this case the attribute has the value _CN=Exchadmin\0ADEL:bbf20ca9-7def-4e0f-bdd9-f9107c1643d6,CN=Deleted Objects,DC=Corp,DC=local_. The _DEL_ means the object doesn´t exist anymore. To solve this issue replace the value with a value of an existing user, for example _CN=Postmaster,DN=ServiceAccounts,DC=Corp,DC=local_.

 After AD replication has occurred you should be able to remove the Exchange Virtual Server using the Cluster Administrator tool.