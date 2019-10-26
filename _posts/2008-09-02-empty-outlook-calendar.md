---
id: 771
title: Empty the Outlook calender
date: 2008-09-02T20:14:38+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=771
permalink: /empty-outlook-calendar/
categories:
  - Exchange
---
I found a nice question on the MSExchange forum which I thought it may be interesting. It may happen that during an import there goes something wrong with the calender,  how can you clear all items from the calender ? The answer is via the Powershell with the following command:

```PowerShell
Export-Mailbox –Identity "mailbox" –PSTFolderPath "path to PST" –IncludeFolders "\Calendar”,”\Agenda” –DeleteContent –Confirm:$False
```