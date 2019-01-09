---
id: 755
title: Strange issues with Out of Office
date: 2008-08-27T20:54:20+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=755
permalink: /vreemde-issues-met-out-of-office/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange
---
Normally the Out of Office functionality isn&#8217;t really hard and you won&#8217;t have a lot of issues with it. But when you have issues they can be quite complicated. For example, if Out of Office is enabled but it doesn&#8217;t send the message to the sender. There are a few things you should check in this case. The problem is most times caused by the rule entry in the users mailbox. To clean this up you should start Outlook with the _/cleanrules_ option. When this doesn&#8217;t solve the issue you will have to do some Exchange &#8220;hacking&#8221;, this can be done with two tools:

  * <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=55fdffd7-1878-4637-9808-1e21abb3ae37&DisplayLang=en" target="_blank">MFCMapi</a>
  * <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=3d1c7482-4c6e-4ec5-983e-127100d71376&DisplayLang=en" target="_blank">MDBVU32</a>

With these tools you can have a look at the mailbox of the user on database level. With MFCMapi you can check is OOF is really enabled. When you discover that the rules might be corrupted  you will have to use MDBVU32 to solve it. With this tool you can remove the corrupted rules so the user can recreate them manually.

When you would like to have a goo manual you should have a look at the site below.

<a href="http://www.msexchange.org/articles_tutorials/exchange-server-2007/tools/troubleshooting-out-of-office.html" target="_blank">open</a>