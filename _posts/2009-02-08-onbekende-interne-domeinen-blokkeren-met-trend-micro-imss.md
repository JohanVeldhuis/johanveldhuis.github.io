---
id: 1068
title: Block unknown internal domains with Trend Micro IMSS
date: 2009-02-08T00:10:00+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1068
permalink: /onbekende-interne-domeinen-blokkeren-met-trend-micro-imss/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Tutorials
---
Maybe you have seen it mails from unknown domains will be relayed via the internal mailserver or mailserver that is placed in the DMZ. Normally when configuring the mailservers correctly it&#8217;s not possibly to send mail from a domain which is not hosted on the internal mailserver. But it can also be that a virus is active on a mailserver which is allowed to relay.

In this tutorial I will explain how you can create a policy in Trend Micro IMSS to prevent this. The way of configuring is not really the way you think you have to do it, but the endresult will work.

[open](http://johanveldhuis.nl/?page_id=1049&lang=en)