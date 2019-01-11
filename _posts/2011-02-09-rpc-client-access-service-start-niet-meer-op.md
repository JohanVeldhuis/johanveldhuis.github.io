---
id: 2124
title: 'RPC Client Access Service doesn&#8217;t start anymore'
date: 2011-02-09T20:49:38+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2124
permalink: /rpc-client-access-service-start-niet-meer-op/
categories:
  - Exchange
---
In Exchange 2010 almost all connections are made via the CAS server, excluded the Public Folder connection. On the CAS server a service is running called the RPC Client Access Service which is used by Outlook to make a connection to the mailbox. When this service isn&#8217;t running no MAPI connections can be made to the server.

In most cases a restart of the service or reboot of the entire server will fix the issue. But it may happen that it won&#8217;t start at all. When the service doesn&#8217;t start anymore you won&#8217;t see much in the event log:

[<img title="RPC Client service doesn't start" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/02/error_rpc-300x121.jpg?resize=300%2C121" alt="" width="300" height="121" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/02/error_rpc.jpg)

Unfortunatly the logging methods for the RPC Client Access Service are minimal. During the startup process of the service it will use a config file. This file can be found in the _BIN_ directory of Exchange and has the following name _Microsoft.Exchange.RpcClientAccess.Service.exe.config._

In some cases this file may get corrupted, for example when an unexpected shutdown occurs. When this file is corrupt the service won&#8217;t start anymore.

The easiest way to fix this issue is to create a new config file with only four lines:

_<configuration>
  
 <runtime>         
  
           <generatePublisherEvidence enabled=&#8221;false&#8221; />
  
 </runtime>
  
</configuration>_

When the service does start after making this change we know that the problem is caused by the original config.  But with the four lines no logging will be done for the service, which might be necessary. So in that case we will need to do some further investigation and have a look at the config file.

_<configuration>
  
  <runtime>
  
    <gcServer enabled=&#8221;true&#8221; />
  
  </runtime>
  
**<generatePublisherEvidence enabled=&#8221;false&#8221;/>
  
**   <appSettings>_

In the example above the line _generatePublisherEvidence enabled_ is placed in the wrong location. The line needs to be placed between the runtime headers, when you have moved the line to the correct location you will be able to start the RPC Client Access Service again.

So when having problems with starting the RPC Client Access Service don&#8217;t forget to have a look at the config file.