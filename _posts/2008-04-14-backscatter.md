---
id: 305
title: Backscatter
date: 2008-04-14T23:15:30+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=305
permalink: /backscatter/
categories:
  - Blog
---
Possibly you had this issue also the last couple of weeks, NDR&#8217;s for messages you don&#8217;t have send yourself. Together with one of my collegues we did some further research on it. This type of SPAM is called a Backscatter, at this moment there is not really a solution for it. BUt what is a backscatter exactly:

A spammer abuses an e-mail address, for example <jan@test.nl> and sends a lot of messages with <jan@test.nl> as sender to different domains, the change is really big that the recipient does not exist in the domain.

When a mailserver if configurered correctly it will check if the recipient adres does exist before accepting the message, the following shout happen:

_HELO spammer.domain.name</p> 

MAIL FROM: jan@test.nl

RCPT TO: nietbestaandegebruiker@utrecht.nl

550 User unknown</em>

But when the server is not configurered to check if the recipient exists it will accept the mail and the mailserve will try to deliver it. The mailserver will find out that the recipient does not exist and a NDR will be generated and will be sended to the sender address, in this case <jan@test.nl>

When this happens to thousands of people there will be generated thousands of NDR which will be send back to the abused address.

At this time there is not a really good solution for it. It is advisable to activtae recipient filtering and when you run Exchange activate  <a href="http://support.microsoft.com/kb/842851" target="_blank">SMTP Tarpiting</a> .  <a href="http://www.backscatter.org" target="_blank">Backscatter.org</a> has developed a list of addresses from mailservers that are not configured OK accordin to them. The following text can be found on their website:

_Email servers should be configured to provide Non-Delivery Reports (bounces) to local users only.</p> 

Unacceptable email from anywhere else should be rejected.</em>

In other words you shouldn&#8217;t permit NDR&#8217;s being send outside your company. Personaly I don&#8217;t think many companies will implement this. NDR&#8217;s are really usefull when someone receives a message from your mailserver that he has sended an e-mail to a non existing address and not waits for an answer that he will never receive.