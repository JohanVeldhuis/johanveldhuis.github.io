---
id: 774
title: Strange mails in the queue
date: 2008-09-03T20:05:16+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=774
permalink: /strange-mail-in-te-queue/
categories:
  - Exchange
---
Maybe you have seen a mail queue with a lot of mails to strange domains. After further investigation most times you will find out that it will be NDR&#8217;s. When you zoom in to the messages you can recognize them because they have the following properties:

  * Sender address is empty, this will be displayed as <> in the Exchange Queue Viewer
  * Source IP is an invalid ip-address: 255.255.255.255
  * Subject contains the text Undeliverable

But what can you do about this? Turn on Recipient filtering on the Edge Transport or Hub Transport server. With this option you can check the AD if the user really exists before accepting the message. This will prevent a lot of &#8220;garbage&#8221; and prevents a lot of NDR&#8217;s in your mail queue who can&#8217;t be delivered.