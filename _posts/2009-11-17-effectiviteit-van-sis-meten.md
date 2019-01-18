---
id: 1677
title: Measure SIS effectiveness
date: 2009-11-17T21:16:19+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1677
permalink: /measure-sis-effectiveness/
categories:
  - Exchange
---
As Exchange 2010 is general available it may be nice to see the current effectiveness of Single Instance Storage on your current databases. It&#8217;s always nice to know what will happen if you will not be using Single Instance Storage anymore, in Exchange 2010 this is the case.

You can measure this by using the counters which will be added during the installation of Exchange, you will find them in the Performance Monitor under the objects:

  * MsExchangeIS mailbox
  * MsExchangeIS public

When the object is selected you will find the counter called Single Instance Ratio. Add it to perfmon en keep an eye on the statistics or save the results to a log file which can be investigated later.