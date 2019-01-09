---
id: 12
title: RDP very slow from a Vista machine
date: 2008-02-15T21:35:01+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=12
permalink: /rdp-rete-traag-vanaf-vista/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Blog
---
[![Remote Desktop Client](/wp-content/uploads/2008/03/rdp.thumbnail.jpg)](/wp-content/uploads/2008/03/rdp.jpg "Remote Desktop Client") 

This week I had a nice issue with Vista. A new server was very slow when using RDP to connect to it, when working via the console on the server everything was OK. After some troubleshooting I started searching on Google. And soon I found out that I was not the only one who had this issue. A few simple commands will solve the issue: netsh interface tcp set global autotuninglevel=disabled in some cases you need to type in some additional commands: netsh interface tcp set global rss=disabled the first sollution helped for me. The feature that is switched off is Autotuning, according to some websites, this will send/receive larger packages the XP did, not every router/switch can handle this.