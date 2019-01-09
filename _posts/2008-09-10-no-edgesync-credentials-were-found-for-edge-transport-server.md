---
id: 822
title: No EdgeSync credentials were found for Edge transport server
date: 2008-09-10T22:04:01+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=822
permalink: /no-edgesync-credentials-were-found-for-edge-transport-server/
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
This week I have been busy with a nice issue I found on the MsExchange forum. It started with an environment which had 2 Hub server where one could send mails to the internet but the otherone not. After asking somethings concerning Edge subscription I received the answer that the Edge subscription was renewed and the followign message was the result:

_No EdgeSync credentials were found for Edge transport server edge.test.local on the local Hub Transport server. Remove the Edge subscription and re-subscribe the Edge Transport server._

So we tried the following, remove the Edge Subscripion and send/reveive connectors and recreate anything.. This also didn&#8217;t solve the issue, after some advises from other users the person who created the threat came with the answer. He renewed the certificates with the CA and then recreated the Edge Subscription. After this everything worked OK, so if having issues with Edge subscriptions don&#8217;t forget the certificates.