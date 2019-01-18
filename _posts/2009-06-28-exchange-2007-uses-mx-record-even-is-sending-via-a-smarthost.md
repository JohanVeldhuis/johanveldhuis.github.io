---
id: 1241
title: Exchange 2007 uses MX record even is sending via a smarthost
date: 2009-06-28T20:11:43+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1241
permalink: /exchange-2007-uses-mx-record-even-is-sending-via-a-smarthost/
categories:
  - Exchange
---
Normally when using a smarthost you wouldn&#8217;t expect that the mailserver does a query for the MX record in DNS. Well it does in Exchange 2007 and Exchange 2010. A while ago I found a post on Technet from someone from Microsoft who mentioned this. I found it pretty weird so I thought let&#8217;s test it. And indeed when using a smarthost and making a networktrace you will find out that it does a query for the MX record in DNS.

Below a screenshot of the DNS part when using a smarthost:

[<img class="alignnone size-thumbnail wp-image-1242" title="Network trace when sending via a smarthost" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/06/mx-150x59.jpg?resize=150%2C59" alt="Network trace when sending via a smarthost" width="150" height="59" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/06/mx.jpg?resize=150%2C59&ssl=1 150w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/06/mx.jpg?zoom=2&resize=150%2C59&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/06/mx.jpg?zoom=3&resize=150%2C59&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/06/mx.jpg)

Also the quote below from Elan Shudnow confirms that a DNS query for the MX record is performed even when using a smarthost:

_There was a discussion about this on the Microsoft Distribution list I am a part of (for the Exchange 2010 TAP) and it was stated by two MS employees that a smart host which actually still try MX lookup first before it attempts the smart host.  Yes, a lot of us were surprised; including myself. The first guy sounded confident but the second guy said he believed but didn&#8217;t test it in months.  So take that as you will.  I haven&#8217;t done a network trace to see for sure so I&#8217;m not sure myself._

_(source_ [_http://forums.msexchange.org/DNS\_Forwarder\_breaks\_email/m\_1800512027/tm.htm_](http://forums.msexchange.org/DNS_Forwarder_breaks_email/m_1800512027/tm.htm)_)_

So this proves again how import correct DNS records are.<!-- <<< -->