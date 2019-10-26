---
id: 2148
title: Event log errors after installing Exchange 2010 SP1 on a Mailbox Server
date: 2011-03-17T20:24:01+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2148
permalink: /event-log-errors-after-installation-of-exchange-2010-sp1-on-a-mailbox-server/
categories:
  - Exchange
---
After the installation of Exchange 2010 SP1 on a server which only contains the Mailbox Server role you might get a lot of errors in the event log.

[<img title="Event log errors" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/03/event-log2-300x107.jpg?resize=300%2C107" alt="" width="300" height="107" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/03/event-log2.jpg)

When looking specificaly at the errors you will see that they are caused by the Performance Counters. A reference is made to the following registry key_HKLM\Software\Microsoft\ExchangeServer\v14\Transport_ which can&#8217;t be opened.

[<img title="Event log error detail" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/03/event-log-300x143.jpg?resize=300%2C143" alt="" width="300" height="143" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/03/event-log.jpg)[](http://myuclab.nl/wp-content/uploads/2011/03/event-log2.jpg)

When you open regedit and search for the specific registry key you won&#8217;t find it. Really strange because the RPC Client Access Service will be installed on a Mailbox Server.

When having a look at the following <a href="http://support.microsoft.com/kb/982679/en-us" target="_blank">Knowledge Base</a> article you shouldn&#8217;t have to worry about the events because it doesn&#8217;t have effect on the performance of the Mailbox Server.  Personally I would don&#8217;t like errors in the event log, so how can you solve this issue?

Pretty simple:

  * Open the Exchange Management Shell
  * Run the following cmd: add-pssnapin Microsoft.Exchange.Management.PowerShell.Setup
  * Run the following cmd: new-perfcounters –definitionfilename &#8220;C:\Program Files\Microsoft\Exchange Server\V14\Setup\Perf\RpcClientAccessPerformanceCounters.xml&#8221;

By running these cmds we will install the Performance Counters needed for the RPC Client Access Service. Once installed the error won&#8217;t be displayed anymore.

If you like to have more information about removing or reloading the Performance Counters have a look at the site below:

<a href="http://blogs.technet.com/b/mikelag/archive/2010/09/10/how-to-unload-reload-performance-counters-on-exchange-2010.aspx" target="_blank">open</a>