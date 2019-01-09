---
id: 3213
title: Cleanup Shadow Redundancy Queues
date: 2013-06-23T20:49:29+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3213
permalink: /shadow-redundancy-queues-opschonen/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Scripts
---
Depending on your environment a Hub server will contain one of more shadow redundancy queues. You could clean them up by using the queue viewer but this can be a lot of work if you have multiple Hub servers in that case Powershell is the way to go.

The Cleanup_ShadowRedundancyQueue script verifies if there are shadow redundancy queues on a server with one of more messages in it. The script will removed messages from the queue that are at least one day old. You could of course change this option if you like.

The script uses one parameter _server_ which is used to specify the name of the Hub Transport server you would like to check.

The script can be downloaded via the link below:

[download](http://gallery.technet.microsoft.com/Cleanup-Shadow-Redundancy-a91df09f)