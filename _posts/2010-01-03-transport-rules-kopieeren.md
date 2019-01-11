---
id: 1791
title: Copy transport rules
date: 2010-01-03T21:52:42+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1791
permalink: /transport-rules-kopieeren/
categories:
  - Exchange
---
In Exchange 2010 the transport rules functionality have been expanded, as the configuration of Hub servers is saved in the AD transport rules will also be saved there. This has an advantage that multiple Hub servers in the same Exchange organization can use these transport rules.

When having an Edge server this is a little bit more complicated because the Edge is not a member of the AD and has a local ADLDS which makes replication not possible. If you have one Edge it&#8217;s not a very big problem to configure the transport rules again. But if you have multiple Edge servers this can be a very time consuming job. In this case you can use the commands _Export-TransportRuleCollection _and _Import-TransportRuleCollection_. You can run both commands on both the Hub and Edge transport servers.

With the command below we ensure that we make an export of the transport rules to the export directory which is located on our local harddrive.

_$file = Export-TransportRuleCollection
  
Set-Content -Path &#8220;C:\Export\TransportRules.xml&#8221; -Value $file.FileData -Encoding Byte_

Next step is to copy the xml file to the other Edge servers and run the import command.

_[Byte[]]$Data = Get-Content -Path &#8220;C:\Import\TransportRules.xml&#8221; -Encoding Byte -ReadCount 0
  
Import-TransportRuleCollection -FileData $Data_

This will import the transportrules.xml on the server.

When you make a lot of changes to transport rules it might be usefull to create a script which exports and imports the transport rules.

Below an example script to export the transport rules. This script uses a batch and a Powershell file, the batch is used in the scheduled task to automaticaly run the export, you can also choose to copy the complete command from the batch and place it in the scheduled task. The scheduled task can then be executed every hour or every day depending on your needs. When the command has been executed an entry will be made in the application log. One remark on this script is that you will need to share the export folder and give the account who executes the scheduled task the correct permissions on it:

**_exporttransportrules.cmd_**
  
_PowerShell.exe -command &#8220;. &#8216;C:\Program Files\Microsoft\Exchange Server\V14\bin\RemoteExchange.ps1&#8217;; Connect-ExchangeServer -auto; C:\Export\exporttransportrules.ps1&#8221;_

_**exporttransportrules.ps1
  
** $file = Export-TransportRuleCollection
  
Set-Content -Path &#8220;C:\Export\TransportRules.xml&#8221; -Value $file.FileData -Encoding Byte
  
$evt=new-object System.Diagnostics.EventLog(&#8220;Application&#8221;)
  
$evt.Source=&#8221;Export transport rules&#8221;
  
$infoevent=[System.Diagnostics.EventLogEntryType]::Information
  
$evt.WriteEntry(&#8220;Transport rules have been exported&#8221;,$infoevent,70)_

OK now we have the export part we also need to import part:

**_importtransportrules.cmd_**
  
_PowerShell.exe -command &#8220;. &#8216;C:\Program Files\Microsoft\Exchange Server\V14\bin\RemoteExchange.ps1&#8217;; Connect-ExchangeServer -auto; C:\Import\importtransportrules.ps1&#8221;_

_**importtransportrules.ps1
  
** _[Byte[]]$Data = Get-Content -Path &#8220;\\sourceserver\export\TransportRules.xml&#8221; -Encoding Byte -ReadCount 0
  
Import-TransportRuleCollection -FileData $Data
  
_ $evt=new-object System.Diagnostics.EventLog(&#8220;Application&#8221;)
  
$evt.Source=&#8221;Import transport rules&#8221;
  
$infoevent=[System.Diagnostics.EventLogEntryType]::Information
  
$evt.WriteEntry(&#8220;Transport rules have been imported&#8221;,$infoevent,70)_

The import part is almost the same, only the export-transportrulecollection has been changed to import-transportrulecollection and the path to import has been changed to point to the source server.

But what happens in a co-existentse environment where you have transport rules in Exchange 2007 and Exchange 2010. As described earlier these transport rules are saved in the Active Directory for Hub servers, in Exchange 2010 this is another location as for Exchange 2007. During the setup the transport rules will be converted and placed in the right location. When the installation has finished both Exchange 2007 and Exchange 2010 have the same set of transport rules. But when you like to make changes to the transport rules you will need to make this change in both Exchange 2007 and Exchange 2010.

To export the Exchange 2007 transport rules only on a 2010 Hub server execute the following command:

_$ file = Export-TransportRuleCollection -ExportLegacyRules
  
Set-Content -Path &#8220;C:\Export\LegacyRules.xml&#8221; -Value $file.FileData -Encoding Byte_

If you like to have more info about the commands then have a look at the sites mentioned below:

Technet Export-TransportRuleCollection <a href="vhttp://technet.microsoft.com/en-us/library/bb124410.aspx" target="_blank">open</a>
  
Technet Import-TransportRuleCollection <a href="http://technet.microsoft.com/en-us/library/bb123582.aspx" target="_blank">open</a>