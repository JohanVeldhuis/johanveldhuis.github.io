---
id: 1126
title: Exchange 2003 keeps resending the same mail
date: 2009-03-04T20:23:12+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1126
permalink: /exchange-2003-keeps-resending-the-same-mailexchange-2003-blijft-dezelfde-mail-versturen/
categories:
  - Exchange
---
Today I had a nice issue with Exchange. For some kind of strange reason Exchange 2003 kept sending the same mails.  Even when deleting the mails from the queue in the Exchange System Manager. A result of this was that the bandwidth was almost used 100% so I adjusted the simultaneous connections etc, without any effect.

So I decided to search for a solution for this issue. I found a post on expert-exchange which described almost the same issue. It adviced to use MFCMAPI to cleanup the temp table. The specific messages may get stuck in that table

After applying the solution the issue was solved indeed, below you will find the steps to solve the issue:

  * download and install <a href="http://support.microsoft.com/kb/291794/en-us" target="_blank">MFCMAPI</a>
  * choose _session_ and select _logon and display store tables_
  * if there are multiple profiles found you will be asked to select a profile, in this case select the _administrator_ profile
  * an overview of the mailbox and public folders will be displayed. Select _MDB_  and choose the option _get mailbox table_
  * an overview of all mailboxes found in the store will be displayed. Search for the mailbox of _SMTP_
  * search in the left pane for _Temp Tables_
  * delete all sub folders below the _Temp Tables, _when asked if the messages need to be _hard deleted_ choose to do this
  * restart the _SMTP service_