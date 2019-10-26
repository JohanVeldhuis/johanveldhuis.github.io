---
id: 1329
title: Access is denied. HResult =-2147024891
date: 2009-09-16T21:28:26+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1329
permalink: /access-is-denied-hresult-2147024891/
categories:
  - Exchange
---
At least I had time to upgrade Exchange to SP2 and install Exchange 2010 RC in the same  organization. Everything went well on first sight. The only issue which I discovered was when opening the CAS server below the server configuration folder. In that case it displayed the following error message: &#8220;Unable to create IIS (Internet Information Services) Directory Entry. Error Message is: Access is denied. HResult =-2147024891.

After some searching on the internet I found the solution. The problem was caused by the group Exchange Trusted Subsystem, this one was not a member of the local administrators group on the Exchange 2007 servers.

After making the change and rebooting the Exchange 2010 RC server the problem was solved and I could continue with testing Exchange 2007 SP2 i.c.w. Exchange 2010 RC. In some cases you may need to reboot all Exchange servers.

But why the group Exchange Trusted Subsystem? This group is introduced in Exchange 2010, is a universal group and has read/write permissions on all Exchange objects in the Exchange organization. When navigating through the menu&#8217;s Powershell commands will be executed using a user which is a member of this group. To make this possible you will need to ensure that the group Exchange Trusted Subsystem has enough rights on the objects.