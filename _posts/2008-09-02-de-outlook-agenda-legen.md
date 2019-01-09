---
id: 771
title: Clear the Outlook calender
date: 2008-09-02T20:14:38+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=771
permalink: /de-outlook-agenda-legen/
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
I found a nice question on the MSExchange forum which I thought it may be interesting. It may happen that during an import there goes something wrong with the calender,  how can you clear all items from the calender ? The answer is via the Powershell with the following command:

Export-Mailbox –Identity &#8216;mailbox&#8217; –PSTFolderPath &#8216;path to PST&#8217; –IncludeFolders &#8220;\Calendar”,”\Agenda” –DeleteContent –Confirm:$False