---
id: 685
title: 'Powershell: overview of users with an ActivSync device'
date: 2008-08-12T20:34:20+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=685
permalink: /powershell-overzicht-van-gebruikers-met-een-activsync-device/
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
During my visit on the forum I found a question on how you can see which user has an ActiveSync device attached to their profile. Quite a good question I thought and I decided to search on Technet and Google. There is a Powershell command which can give you an overview of the users who have attached an ActivSync device to their profile:

Get-CASMailbox | where {$_.HasActiveSyncDevicePartnership} | select Name