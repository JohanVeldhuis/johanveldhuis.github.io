---
id: 925
title: Event ID 2050 on CAS Server
date: 2008-10-25T19:46:51+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=925
permalink: /event-id-2050-on-cas-server/
categories:
  - Exchange
---
I have been very busy this week so I did not had many time to blog. Yesterday and today I visited a forum to have a look for interesting issues. One item I found was about Event ID 2050 on a CAS server. When looking at the details of the event you will see the following:

_Process IISIPMC4F9B6B7-0BB9-449F-99DA-B205432B1C43 -AP &#8220;MSEXCHANGEOWAAPPPOOL (PID=3404). The shared memory heap could not be created. This may be caused if physical memory limits have been exceeded. It may also be caused if too many other processes are running DSAccess. You may be able to resolve this error by restarting the Exchange server that logged this event_

With this message you can go several ways so I started with googeling on the issue. You will discover soon that it has to do something with the application pool of IIS. As you can see in the event details it is the MSEXCHANGEOWAAPPPOOL. In this case the MSEXCHANGEOWAAPPPOOL __didn&#8217;t ran under the correct account. It needs to run under the local system account so after correcting this it worked. Microsoft has published an KB article about this, below you will find the link.

<a href="http://support.microsoft.com/default.aspx?scid=kb;en-us;906907" target="_blank">open</a>