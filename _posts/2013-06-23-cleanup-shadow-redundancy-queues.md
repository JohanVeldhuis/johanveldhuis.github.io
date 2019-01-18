---
id: 3213
title: Cleanup Shadow Redundancy Queues
date: 2013-06-23T20:49:29+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3213
permalink: /cleanup-shadow-redundancy-queues/
categories:
  - Scripts
---
Depending on your environment a Hub server will contain one of more shadow redundancy queues. You could clean them up by using the queue viewer but this can be a lot of work if you have multiple Hub servers in that case Powershell is the way to go.

The Cleanup_ShadowRedundancyQueue script verifies if there are shadow redundancy queues on a server with one of more messages in it. The script will removed messages from the queue that are at least one day old. You could of course change this option if you like.

The script uses one parameter _server_ which is used to specify the name of the Hub Transport server you would like to check.

The script can be downloaded via the link below:

[download](http://gallery.technet.microsoft.com/Cleanup-Shadow-Redundancy-a91df09f)