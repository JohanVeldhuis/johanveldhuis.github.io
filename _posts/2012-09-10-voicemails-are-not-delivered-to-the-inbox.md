---
id: 2523
title: Voicemails are not delivered to the inbox
date: 2012-09-10T15:52:14+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2523
permalink: /voicemails-are-not-delivered-to-the-inbox/
categories:
  - Exchange
---
As you may already know Exchange 2010 has the option to deliver voicemails in a mailbox of a user. The SMTP protocol is used to deliver the message to the HUB server which delivers it to the mailbox server.

In case you have multiple receive connectors you might, if you have configured them incorrectly, have issues which will result in the following error:

_The Unified Messaging server encountered an error while trying to process the message with header file &#8220;C:\Program Files\Microsoft\Exchange Server\V14\UnifiedMessaging\voicemail\bee89072-35bb-4e28-8f7d-733029404602.txt&#8221;. Error details: &#8220;Microsoft.Exchange.UM.UMCore.SmtpSubmissionException: Submission to the Hub Transport server failed. The operation will be retried. &#8212;> Microsoft.Exchange.Net.ExSmtpClient.UnexpectedSmtpServerResponseException: Unexpected SMTP server response. Expected: 220, actual: 500, whole response: 500 5.3.3 Unrecognized command_

As you can see an error 500 5.3.3 occurs when the UM tries to deliver a message to the HUB  Transport server. By default the UM server will use it&#8217;s certificate to authenticate itself. One important thing here is that the receive connector will have the Exchange Server authentication option enabled. By default this will be the receive connector named client servername, for example Client EX003. This connector only accepts connections which are authenticated.

When creating a receive connector, for example for allowing applications to relay, you will need to protect it by specifying IP addresses or IP ranged. If you use the last option this may lead to strange issues. For example if the UM server has the IP address 192.168.1.25 and you will specify the 192.168.1.1/24 range as the valid remote range on the receive connector. This will result in authentication errors on the UM server because it tries to authenticate using the certificate. This because the UM server thinks it needs to authenticate using the certificate.

In case you still want to provide an IP range on the connector there is one solution: configure a seperate connector for the UM server IP address and correct authentication method.

This will cause the UM server to use this connector instead of the relay connector. The rule for receive connectors is use the most restrictive one.