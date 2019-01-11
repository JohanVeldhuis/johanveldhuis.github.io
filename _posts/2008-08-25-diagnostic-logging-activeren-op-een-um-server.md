---
id: 751
title: Enable Diagnostic logging on a UM Server
date: 2008-08-25T19:52:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=751
permalink: /diagnostic-logging-activeren-op-een-um-server/
categories:
  - Exchange
---
If you are troubleshooting an issue some logging is really usefull. On the UM server diagnostic logging is enabled by default on the lowest level. In case you need to have more logging you should manually change it to a higher level.

Changing the logging level can be done in two ways:

  * via the registry editor
  * via Powershell

The first method is really simple

  * startup regedit
  * go to HKeyLocalMachine\System\CurrentControlSet\services\MSExchange Unified Messaging\Diagnostics
  * change the values from the item from which you need more logging. Valid values are: Expert 7, High 5, Medium 3, Low 1, Lowest 0

When you don&#8217;t want to change things in the registry yourself you can also do it via the Powershell, for example:

  * Set-EventlogLevel &#8220;UM01\MSExchange Unified Messaging\UMService&#8221; -level <Lowest | Low | Medium | High | Expert> 

This command will change the logging level for the UMService, other valid parameters are:

  * UMCore, change logging for theUMCore
  * UMWorkerProcess, change logging for the UMWorkerProcess
  * UMManagement, change logging for UMManagement
  * UMClientAccess, change logging for UMClientAccess
  * UMCallData, change logging for UMCallData

When you want to know what the current logging level is you need to execute the following Powershell command:

Get-EventlogLevel &#8220;UM01\MSExchange Unified Messaging&#8221;