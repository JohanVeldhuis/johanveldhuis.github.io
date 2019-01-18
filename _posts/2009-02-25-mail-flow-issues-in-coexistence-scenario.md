---
id: 1119
title: Mail flow issues in coexistence scenario
date: 2009-02-25T00:36:27+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1119
permalink: /mail-flow-issues-in-coexistence-scenario/
categories:
  - Exchange
---
In a lot of cases Exchange 2007 wil be installed in the current Exchange 2003 environment. During the setup you will have to choose the Exchange 2003 bridgehead server to use for sending mail to the other organization and the internet. After this a routing group connector will be created which will be used to transport mail.

It can happen that after the installation mail will flow only one way or it won&#8217;t flow in both directions. When you will have a look at the mail queue you can see that mails are in it.

Below a few reasons which can cause this issue and if you have an issue how to solve it.

**recreate the connector**

Before we can recreate the connector we will need to remove the old one. This van be done via the Powershell commands below, in this example the Routing Group Connector is called _Ex072Ex03 RGC_ :

```PowerShell
Remove-RoutingGroupConnector -Identity 'Exchange Administrative Group (FYDIBOHF23SPDLT)\Exchange Routing Group (DWBGZMFD01QNBJR)\Ex072Ex03'
```

As the command above will only delete the connector in the Exchange 2007 environment we will need to execute the _remove-routinggroupconnector_ command again to delete it in the Exchange 2003 environment.

```PowerShell
Remove-RoutingGroupConnector -Identity 'Ex2003 Administrative Group\Ex2003 Routing Group\Ex072Ex03 RGC'
```

Next we will create the new connector, this can be done via the Powershell command below:

```PowerShell
New-RoutingGroupConnector -Name 'Interop RGC' -SourceTransportServers 'Ex207.company.local' -TargetTransportServers 'Ex03.company.local' -Cost 100 -Bidirectional $true -PublicFolderReferralsEnabled $true
```

With the command above both the routing group connector in Exchange 2007 and 2003 will be created and Public Folders can be synchronized via this connector

**check the default virtual SMTP server settings**

In some cases the _default virtual SMTP server_ has been modified. This can cause some issues, check the following items:

  * check if no _smarthost_ has been defined, if this is the case then remove it and create a new connector which is used to send to the internet. If it already exists then specify the smarthost there.
  * check if besides _anonymous_ authentication _integrated windows authentication_ is also enabled