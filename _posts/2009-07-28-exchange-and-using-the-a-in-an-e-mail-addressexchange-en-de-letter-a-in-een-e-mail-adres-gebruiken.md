---
id: 1275
title: Exchange and using the ä in an e-mail address
date: 2009-07-28T20:49:27+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1275
permalink: /exchange-and-using-the-a-in-an-e-mail-addressexchange-en-de-letter-a-in-een-e-mail-adres-gebruiken/
categories:
  - Exchange
---
Last week I found a nice issue on a forum. A user who managed an Exchange server in a Scandinavian country had issues with using the letter ä in an e-mail address. When a user had this name the e-mail address was generated with an ae instead of the ä.

After some troubleshooting we found out that it had nothing to do with the Exchange settings. I searched further and found a knowledge base article from Microsoft which described the same issue. The problem is caused by incorrect regional settings before installing .NET 2.0. Make sure these are correct before installing .NET. to fix the issue stop the Exchange services, remove the .NET version(s), correct the regional settings and reinstall .NET.

In case of Windows 2008 it&#8217;s a little bit more complicated as it already contains .NET 2.0 by default. As soon as I found a solution for it I will let you know. There is a workaround, don&#8217;t use the letter ä in the e-mail address, but in some countries this is not an option.

<a href="http://support.microsoft.com/kb/948212" target="_blank">open</a>