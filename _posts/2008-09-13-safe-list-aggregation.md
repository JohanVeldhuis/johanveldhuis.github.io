---
id: 827
title: Safe List Aggregation
date: 2008-09-13T23:08:49+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=827
permalink: /safe-list-aggregation/
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
As you may no Exchange 2007 contains anti-spam agents. Besides this it&#8217;s possible for a user to create a _safe list_ which a user can add senders from which he receives mail but he/she wants to ensure that they are not marked as spam. With multi-layer spam solutions this can cause issues. It can happen that a mail is not accepted by the Edge Transport server while the user wants to receive the mail.

To solve this issue we can use _safe list aggregation_ this can be done by the Powershell command _Update-Safelist._ With this command the safe list of the user can be synchronised to the users object in AD. This is done via a method that will ensure that the safe list takes needs a very small amount of diskspace. The Edge Transport Server then can get these objects via the ADAM which is installed on it which will result in less false positives.

The negative thing of the command is that it is resource intensive, that&#8217;s why it isn&#8217;t executed automatically. When you would like this to happen you will need to create a Powershell script which will be executed automatically each day at 0:00 AM.

_Get-Mailbox | Update-SafeList –Type SafeSenders_

The command above will first get all the users who have a mailbox and will then update the safelist of the user. You see there is an extra parameter added, _type_ with this parameter we can tell the command which list needs to be updated to the user object. Other values are _both_ and _SafeRecipients._ Exchange only uses the _SafeSenders_ that&#8217;s why Microsoft recommands only to use this type and not the other two.