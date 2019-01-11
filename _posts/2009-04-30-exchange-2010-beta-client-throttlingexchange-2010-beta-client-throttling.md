---
id: 1212
title: 'Exchange 2010 Beta: Client Throttling'
date: 2009-04-30T20:20:17+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1212
permalink: /exchange-2010-beta-client-throttlingexchange-2010-beta-client-throttling/
categories:
  - Exchange
---
In Exchange 2010 Beta is _client throttling_ is __introduced. With client throttling policy you are able to limit the bandwidth used per user. Besides this, you are able to keep an eye on the resources consumed per user.

Besides the _default_ policy it&#8217;s possible to add additional policies which you can use to change settings for groups of users. Client throttling can only be managed by using Powershell:

  * _get-throttlingpolicy_, gives an overview of all throttling policies
  * _new-throttlingpolicy,_ creates a new throttling policy
  * _set-throttlingpolicy,_ modifies a current policy
  * _remove-throttlingpolicy_, deletes a throttling policy

The parameters which need to be used in combination with the Powershell commands are:

  * _MaxConcurrency,_ how many simultanious connections may a user create
  * _PercentTimeInCAS,_ which percentage of a minute may be used when executing a CAS command
  * _PercentTimeInAD,_ which percentage of a minute may be used when executing a LDAP request
  * _PercentTimeInMailboxRPC,_ which percentage of a minute may be used for a RPC request to the mailbox
  * _CPUStartPercent,_ at which CPU usage level throttling must be applied
  * _PowerShellMaxConcurrency,_ the maximum of remote Powershell commands which may be simulatious executed
  * _PowerShellMaxCmdlets,_ how many Powershell commands may be executed in a specific time-frame before throttling is applied
  * _PowerShellMaxCmdletsTimePeriod,_ with this parameter the time frame, in seconds, can be defined
  * _PowerShellMaxCmdletQueueDepth,_ the maximum Powershell tasls which may be executed by a user, a Powershell command may execute several tasks when executed. The advice is to set this value 3 times higher then the value being specified as _PowershellMaxConcurrency_

The settings being specified in the policy will be applied to the following Exchange components:

  * Microsoft Exchange ActiveSync 
  * Exchange Web Services
  * IMAP
  * Outlook Web Access
  * POP
  * PowerShell
  * Unified Messaging (UM)

For more information have a look at the pages below:

<a href="http://technet.microsoft.com/en-us/library/dd297964(EXCHG.140).aspx" target="_blank">Understanding Client Throttling</a>
  
<a href="http://technet.microsoft.com/en-us/library/dd351264(EXCHG.140).aspx" target="_blank">get-throttlingpolicy</a>
  
<a href="http://technet.microsoft.com/en-us/library/dd298094(EXCHG.140).aspx" target="_blank">set-throttlingpolicy</a>
  
<a href="http://technet.microsoft.com/en-us/library/dd351045(EXCHG.140).aspx" target="_blank">new-throttlingpolicy</a>
  
<a href="http://technet.microsoft.com/en-us/library/dd351178(EXCHG.140).aspx" target="_blank">remove-throttlingpolicy</a>