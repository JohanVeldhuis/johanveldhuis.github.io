---
id: 1218
title: Which schema version belongs to which Exchange
date: 2009-05-07T21:29:11+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1218
permalink: /which-schema-version-belongs-to-which-exchange/
categories:
  - Exchange
---
During a search I found this nice kb article which explains how you can see which schema version you are using for Exchange and AD.

To find out which version you are using you will need to use a tool such as adsiedit. Below the full path where you can find the information plus a short overview which explains which versionnumber belongs to which Exchange version:

_&#8220;CN=ms-Exch-Schema-Version-Pt,CN=Schema,CN=Configuration,DC=domain,DC=local&#8221;
  
_ 
  
Check the value filled in at the following parameter _rangeupper_

4397 -> Exchange Server 2000 RTM
  
4406 -> Exchange Server 2000 with Service Pack 3
  
6870 -> Exchange Server 2003 RTM
  
6936  -> Exchange Server 2003 with Service Pack 2
  
10628 -> Exchange Server 2007
  
11116 -> Exchange 2007 with Service Pack 1

For more information have a look at the site below

<a href="How to find the current Schema Version" target="_blank">How to find the current Schema Version</a>