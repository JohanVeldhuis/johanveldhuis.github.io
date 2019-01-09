---
id: 1378
title: Exchange Single Instance Storage (SIS)
date: 2009-11-03T21:34:10+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1378
permalink: /exchange-single-instance-storage-sis/
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
Starting from Exchange 2010 Microsoft will not use single instance storage anymore. But what did single instance storage do and what are the pro&#8217;s/cons of it?

Single instance storage has been a part of Exchange since Exchange 4.0 and is a part of it until Exchange 2007 and did not change very much. Single instance storage will allow a message which has been sent to 50 users will be saved one time per mailstore. Exchange will place a pointer in the other mailboxes which point to the original message, this is applied both to the message and the attachment. Since Exchaneg 2007 Exchange will only apply SIS on the attachments. This will not be applied if  Exchange is upgraded to 2007 from Exchange 2000/2003. In this case it will apply SIS on both the message and attachment if the following statements are true:

  * the mailboxes must be kept together in the new database
  * a transistion instead of a migration is done to Exchange 2007

You may think, why is Microsoft not using SIS anymore in Exchange 2010?  The reason for this is quit simple, storage is cheaper nowadays. One of the benefits of SIS was that you need less space on the storage environment, one of the con&#8217;s was that it took more IOPS. Today the focus is more on reducing the IOPS instead of reducing the disk-capacity.

Below some usefull links:

Technet: understanding single instance storage <a href="http://technet.microsoft.com/en-us/library/aa998912(EXCHG.65).aspx" target="_blank">open</a>
  
MsExchange Team: single instance storage in Exchange 2007 <a href="http://msexchangeteam.com/archive/2008/02/08/448095.aspx" target="_blank">open</a>
  
Harold Wong&#8217;s Blog site: Exchange 2010 archiving and retention <a href="http://blogs.technet.com/haroldwong/archive/2009/06/19/exchange-server-2010-archiving-and-retention-06-10-09-questions-and-answers-log.aspx" target="_blank">open</a>