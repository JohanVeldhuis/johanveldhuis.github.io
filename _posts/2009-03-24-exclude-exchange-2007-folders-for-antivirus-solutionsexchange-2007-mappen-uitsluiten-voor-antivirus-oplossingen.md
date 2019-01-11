---
id: 1138
title: Exclude Exchange 2007 folders for antivirus solutions
date: 2009-03-24T21:18:30+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1138
permalink: /exclude-exchange-2007-folders-for-antivirus-solutionsexchange-2007-mappen-uitsluiten-voor-antivirus-oplossingen/
categories:
  - Exchange
---
Virusscanners may not have the result you wanted always, especially on databases and log files they can cause strange issues. Below an overview of folders you will need to exclude from virusscanning when a virusscanner is running on your Exchange 2007 server:

**Mailbox server**

  * Exchange databases, checkpoint files, and log files for the specific storage groups
  
    _%Program Files%\Microsoft\Exchange Server\Mailbox folder_
  * Database content indexes
  
    _%Program Files%\Microsoft\Exchange Server\Mailbox folder_
  * General log files, zoals message tracking log files
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles\Logs folder
  
    %Program Files%\Microsoft\Exchange Server\Logging folder_
  * Offline Address Book files
  
    _%Program Files%\Microsoft\Exchange Server\ExchangeOAB folder_
  * IIS system files
  
    _%SystemRoot%\System32\Inetsrv folder_
  * OLE conversies
  
    _%Program Files%\Microsoft\Exchange Server\Working\OleConvertor folder_
  * Mailbox database temp folder
  
    _%Program Files%\Microsoft\Exchange Server\Mailbox\MDBTEMP_

**HUB Transport**

  * General log files
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles\Logs folder_
  * Message folders
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles folder_
  * De transport server role queue database, checkpoint and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\Queue folder_
  * De transport server role Sender Reputation database, checkpoint and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\SenderReputation folder_
  * De transport server role IP filter database, checkpoint and log files
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\IpFilter folder_
  * De temp folders which is used for conversions: OLE conversions
  
    _%Program Files%\Microsoft\Exchange Server\Working\OleConvertor folder
  
_ 

**Client Access** 

  *  De Internet Information Services (IIS) 6.0 compressie folder
  
      _%systemroot%\IIS Temporary Compressed Files_
  * IIS system files
  
    _%SystemRoot%\System32\Inetsrv folder_
  * De Internet gerelateerde  files
  
    _%Program Files%\Microsoft\Exchange Server\ClientAccess folder_

**Edge Transport**

  * De Active Directory Application Mode (ADAM) database and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\Adam folder_
  * General log files
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles\Logs folder_
  * Bericht mappen
  
    _%Program Files%\Microsoft\Exchange Server\TransportRoles folder_
  * De transport server role queue database, checkpoint and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\Queue folder_
  * De transport server role Sender Reputation database, checkpoint and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\SenderReputation folder_
  * De transport server role IP filter database, checkpoint and log files
  
     _%Program Files%\Microsoft\Exchange Server\TransportRoles\Data\IpFilter folder_
  *  De temp directories which is used for conversions: OLE conversions
  
     _%Program Files%\Microsoft\Exchange Server\Working\OleConvertor folder_

**UM**  

  * The grammar files
  
    _%Program Files%\Microsoft\Exchange Server\UnifiedMessaging\grammars folder_
  * Voice prompts
  
     _%Program Files%\Microsoft\Exchange Server\UnifiedMessaging\Prompts folder_
  * Voicemail files
  
     _%Program Files%\Microsoft\Exchange Server\UnifiedMessaging\voicemail folder_
  * Bad voicemail files
  
     _%Program Files%\Microsoft\Exchange Server\UnifiedMessaging\badvoicemail folder_