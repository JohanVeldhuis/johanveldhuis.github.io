---
id: 1235
title: 'Can&#8217;t mount Exchange Database: error 0xfffff764'
date: 2009-06-13T20:05:57+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1235
permalink: /cant-mount-exchange-database-error-0xfffff764exchange-database-kan-niet-gemount-worden-error-0xfffff764/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange
---
It doesn&#8217;t happen daily that one or more databases will get corrupt in your Exchange 2003 environment and can&#8217;t be mounted anymore. But it can happen when for example a database will not be shutdown normally which can be caused by a systemcrash.

One of the errors  you may get is 0xfffff764 i.c.w. event ID 9519, but what does this exactly mean.

This messages will tell you that the streaming file of the database is missing. The streaming file is used to stream data received from the internet to. This data is not converted to Exchange native data but will stay the same as received from the internet. The data will stay in their till a MAPI client retrieves the data. When this happens the data will be moved to the EDB file and the data will be converted to Exchange native data. After this it is not possible anymore to move the data back to the STM file.

But what are the options you have in this case:

  * restore the most recent STM file
  * run eseutil with the /createstm option

The first option is the best one but when you don&#8217;t have a backup of the STM file only the last option is available. With this option eseutil need to be run with the option /createstm to create a new STM file. As the STM only contains content and the EDB file contains pointers and header information the EDB file is used to rebuild the STM file. The content however will can not be recovered. When end users do not use a MAPI client this may lead to a great los of data.

So ensure you will have a backup of the STM file to prevent problems.