---
id: 1119
title: Mail flow issues in co-existence scenario
date: 2009-02-25T00:36:27+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1119
permalink: /mail-flow-issues-in-co-existence-scenariomail-flow-problemen-in-een-co-existence-scenario/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2007
---
In a lot of cases Exchange 2007 wil be installed in the current Exchange 2003 environment. During the setup you will have to choose the Exchange 2003 bridgehead server to use for sending mail to the other organization and the internet. After this a routing group connector will be created which will be used to transport mail.

It can happen that after the installation mail will flow only one way or it won&#8217;t flow in both directions. When you will have a look at the mail queue you can see that mails are in it.

Below a few reasons which can cause this issue and if you have an issue how to solve it.

**recreate the connector**

Before we can recreate the connector we will need to remove the old one. This van be done via the Powershell commands below, in this example the Routing Group Connector is called _Ex072Ex03 RGC_ :

_Remove-RoutingGroupConnector -Identity &#8220;Exchange Administrative Group (FYDIBOHF23SPDLT)\Exchange Routing Group (DWBGZMFD01QNBJR)\Ex072Ex03 RGC&#8221;_ 

As the command above will only delete the connector in the Exchange 2007 environment we will need to execute the _remove-routinggroupconnector_ command again to delete it in the Exchange 2003 environment.

_Remove-RoutingGroupConnector -Identity &#8220;Ex2003 Administrative Group\Ex2003 Routing Group\Ex072Ex03 RGC&#8221;_ 

Next we will create the new connector, this can be done via the Powershell command below:

_New-RoutingGroupConnector -Name &#8220;Interop RGC&#8221; -SourceTransportServers &#8220;Ex207.company.local&#8221; -TargetTransportServers &#8220;Ex03.company.local&#8221; -Cost 100 -Bidirectional $true -PublicFolderReferralsEnabled $true_

With the command above both the routing group connector in Exchange 2007 and 2003 will be created and Public Folders can be synchronized via this connector

**check the default virtual SMTP server settings**

In some cases the _default virtual SMTP server_ has been modified. This can cause some issues, check the following items:

  * check if no _smarthost_ has been defined, if this is the case then remove it and create a new connector which is used to send to the internet. If it already exists then specify the smarthost there.
  * check if besides _anonymous_ authentication _integrated windows authentication_ is also enabled