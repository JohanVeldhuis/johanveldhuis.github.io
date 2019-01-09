---
id: 1923
title: 'MapiExceptionNetworkError: Unable to make connection to the server. (hr=0x80004005, ec=2423)'
date: 2010-07-03T22:08:59+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1923
permalink: /error-mapiexceptionnetworkerror-unable-to-make-connection-to-the-server-hr0x80004005-ec2423/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
During a migration of a mailbox from one forest to a new Exchange Forest I encountered the following problem:

_(PID 5396, Thread 640) Task New-MoveRequest writing error when processing record of index 0. Error: Microsoft.Exchange.MailboxReplicationService.MailboxReplicationTransientException: Service &#8216;net.tcp://cas001.lab.local/Microsoft.Exchange.MailboxReplicationService&#8217; encountered an exception. Error: MapiExceptionNetworkError: Unable to make connection to the server. (hr=0x80004005, ec=2423)_

_Diagnostic context:</p> 

&#8230;&#8230;   

Lid: 12952   dwParam: 0x6BA      Msg: EEInfo: prm[3]: Long val: 1722

Lid: 16280   dwParam: 0x6BA      Msg: EEInfo: ComputerName: n/a

Lid: 8600    dwParam: 0x6BA      Msg: EEInfo: ProcessID: 2268

Lid: 12696   dwParam: 0x6BA      Msg: EEInfo: Generation Time: 2010-06-30 12:15:24:818

Lid: 10648   dwParam: 0x6BA      Msg: EEInfo: Generating component: 8

Lid: 14744   dwParam: 0x6BA      Msg: EEInfo: Status: 1722

Lid: 9624    dwParam: 0x6BA      Msg: EEInfo: Detection location: 1442

Lid: 13720   dwParam: 0x6BA      Msg: EEInfo: Flags: 0

Lid: 11672   dwParam: 0x6BA      Msg: EEInfo: NumberOfParameters: 1

Lid: 8856    dwParam: 0x6BA      Msg: EEInfo: prm[0]: Unicode string: EX02

Lid: 45169   StoreEc: 0x977    

Lid: 52465   StoreEc: 0x977    

Lid: 60065 

Lid: 33777   StoreEc: 0x977    

Lid: 59805 

Lid: 52209   StoreEc: 0x977    

Lid: 19778 

Lid: 27970   StoreEc: 0x977    

Lid: 17730 

Lid: 25922   StoreEc: 0x977      &#8212;> Microsoft.Exchange.MailboxReplicationService.MailboxReplicationTransientException: Exception details: MapiExceptionNetworkError (80004005): MapiExceptionNetworkError: Unable to make connection to the server. (hr=0x80004005, ec=2423)</em>

But what is the cause of this error? Well there are multiple causes of this issue. The message _MapiExceptionNetworkError_ tells you that there is a problem connecting to a server. The next question is which server? This can be found on the rule starting with _Lid 8856,_ when looking at the end of the rule you will see the name of the server, in this case EX02.

When looking a little bit further in the log you will see the _0x80004005_ error code which might be caused by an authentication problem.

This last option could be easily verified by performing the _new-moverequest_ again and this time with the correct credentials.

But when this does not work which things can cause can you check:

  * is the server reachable
  * check the firewall settings on both sides
  * can you resolve the server on NETBIOS name

I admit the last option is a little bit strange, but in this case caused the issue. On the NIC the default DNS suffixes where registered but not the old one. After adding the old suffix in the TCP/IP configuration the command worked without any issues.