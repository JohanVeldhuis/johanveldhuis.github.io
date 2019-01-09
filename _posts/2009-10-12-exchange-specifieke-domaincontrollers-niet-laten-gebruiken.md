---
id: 1368
title: Exclude domain-controllers to be used by Exchange
date: 2009-10-12T21:37:19+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1368
permalink: /exchange-specifieke-domaincontrollers-niet-laten-gebruiken/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
aktt_notify_twitter:
  - 'no'
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
As you may already know Exchange does a discovery to find the domain controllers  in the AD. When you have a look at the application event log you will see events with the source _MsExchange ADAccess _and Event id _2080. _This event will be seen every 15 minutes, this because the check is performed every 15 minutes.

The event can contain the following info:

_Event Type: Information
  
Event Source: MSExchangeDSAccess
  
Event Category: Topology
  
Event ID: 2080
  
Computer: Ex01
  
Description:
  
Process MAD.EXE (PID=1808). DSAccess has discovered the following servers with the following characteristics:
  
(Server name | Roles | Reachability | Synchronized | GC capable | PDC | SACL right | Critical Data | Netlogon | OS Version)
  
In-site:
  
dc01.domain.com  CDG 7 7 1 0 0 1 7 1
  
dc02.domain.com  CDG 7 7 1 0 1 1 7 1_

Out-of-site:

For more information, click <http://search.support.microsoft.com/search/?adv=1>.

Nice all those shortnames and numbers but what do they mean:

  * _servername,_ the first column contains the servername of the domain controller
  * _roles,_ which roles does the domain controller fullfill: C the domain controller will be used as a configuration domain controller, D a domain controller and G a domain controller which is also a global catalog server. When seeing a &#8211; this means that the role is not fullfilled by the domain controller
  * _reachability,_ each 15 minutes a connection is made to the server. When the server fullfills the role of global catalog server it tries to connect on port 3268,  when this succeeds the value 0x1 will de displayed. When a connection can be made to port 389 the server knows it is a domain controller and will display the value 0x2. When the server is also a configuration domain controller again a connection is made to port 389. If this succeeds it will get the value 0x4. When a server fullfills multiple roles all values will be added up, for example when a server fullfills 3 roles: 0x1+0x2+0x4=0x7.
  * _synchronized, _when the _isSynchronizedflag _is set on the rootDSE of the domain controller this value will be set to true. The values in the column are used in the same way the are used in the collumn _reachability_.
  * _GC capable, _is the domain controller also a Global Catalog Server
  * _PDC,_ is the domain controller also the PDC for the domein
  * _SACL right, _are the rights correct for DSAccess to read the SACL
  * _Critical Data_, this will tell you if DSAccess found the Exchange Server in the configuration partition of the domain controller.
  * _Netlogon Check,_ can a connection be made to the netlogon server of the domain controller
  * _OS version,_ when this value is 1 it will tell you the domain controller has a OS which is Windows 2003 Service Pack 3 minimal.

It may happen that you don&#8217;t want to use a specific domain controller. But how can you configure this ?

You can do this with the command: _set-exchangeserver -identity exchange.domain.com -StaticExcludedDomainControllers dc.domain.com_

When you would like to specify the configuration domain controller, domain controller(s) and global catalog server(s) yourself use the following command: _set-exchangeserver -identity exhange.domain.com_ -S_taticConfigDomainController dc01.domain.com -StaticDomainController dc01.domain.com,dc02.domain.com -StaticGlobalCatalogs dc01.domain.com_

Technet set-exchangeserver <a href="http://technet.microsoft.com/en-us/library/bb123716.aspx" target="_blank">open</a>