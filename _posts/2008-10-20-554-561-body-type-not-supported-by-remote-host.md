---
id: 921
title: 554 5.6.1 Body type not supported by Remote Host
date: 2008-10-20T20:52:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=921
permalink: /554-561-body-type-not-supported-by-remote-host/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2007
---
Last week I found a message on the Technet forum which contained a question about how to disable 8 bit mime in Exchange 2007. So I started some research on mime types.

How will the mime-type be determined for example, it&#8217;s not really difficult:

  * mail without an attachment or with a plain-text attachment, this will be delivered as a 7 bit Mime this because most text is 7 bit mime based.
  * mail with jpg attachment, this will delivered as a 8 bit mime standard, when the attachment will be detected the server will convert the body to the binary type which is 8 bits.

You may discover that not all servers will support 8 bit you may get the following error when you try to connect to this server and send an e-mail:

<span style="font-size: small; color: #000000; font-family: Calibri;"><em>554 5.6.1 Body type not supported by Remote Host</em></span>

<span style="font-size: small; font-family: Calibri;">But how can we solve this issue:</span>

  * <span style="font-size: small; font-family: Calibri;">upgrade to Exchange 2007 SP1, this contains a fix which should prevent this issue</span>
  * <span style="font-size: small; font-family: Calibri;">create a speciale send-connector which uses HELO instead of EHLO</span>

<span style="font-size: small; font-family: Calibri;">Besides this two options there exists a knowledge base article from Microsoft which tells you how you can change the smtp settings so each mail will be delivered to a 7 bit mime before it is send.</span>

<span style="font-size: small; font-family: Calibri;"><a href="http://support.microsoft.com/?id=262168">open</a></span>