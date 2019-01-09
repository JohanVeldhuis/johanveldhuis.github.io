---
id: 2017
title: 'ForeFront Protection for Exchange 2010: Unexpected SMTP server response. Expected: 220, actual: 500, whole response: 500 5.3.3 Unrecognized command'
date: 2010-09-24T21:41:49+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2017
permalink: /forefront-protection-for-exchange-2010-unexpected-smtp-server-response-expected-220-actual-500-whole-response-500-5-3-3-unrecognized-command/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2010/09/forefront_ex2010.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
Despite a lot of people will use an antivirus/antispam solution in the cloud some people will like to have an additional Exchange aware antivirus product installed on their Exchange servers. One of the products which can be used for this is ForeFront Protection for Exchange 2010.

This software can be installed on the Edge, CAS/Hub and the Mailbox server. In most cases people decide to install it only on one server but in some cases it might be necessary to install it on all servers. The last situation may give the following issue:

[<img title="forefront_ex2010" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/09/forefront_ex2010-300x88.jpg?resize=300%2C88" alt="" width="300" height="88" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/09/forefront_ex2010.jpg)

You will find this event only on the server which hosts the Mailbox server role and as a result you won&#8217;t receive any notification when, for example, an engine could not be updated.

As you can see in the event it got some issues while setting up the SMTP connection to the CAS/Hub server to send the message. When you will have a look, with for example Wireshark to monitor the network traffic, you will see that it tries to authenticate using anonymous tls.

To solve this issue there are, depending on your Exchange environment, two solutions:

  * create a seperate receive connector
  * switch off the anonymous users authentication option for the default receive connector

The first option must be used when mail from the internet is delivered directly to your CAS/Hub server. In this case the _anonymous users _on the _permissions group_ tab must be enabled, if you do not enable this option you won&#8217;t be able to receive e-mail from the internet. This connector can be created by using the Exchange Management Shell:

_new-receiveconnector -Name &#8220;Forefront&#8221; -MaxRecipientsPerMessage 5000 -Fqdn mail.domain.local -Bindings &#8216;0.0.0.0:25&#8217; -RemoteIPRanges &#8216;10.0.0.11-10.0.0.11&#8217; -MaxInboundConnectionPerSource Unlimited -MaxInboundConnectionPercentagePerSource 100 -SizeEnabled EnabledWithoutValue_

The above command will create a receive connector which can only be used by a server which IP address is 10.0.0.11, all other clients can&#8217;t use this connector.

The second option will be used when you have an Edge server in the DMZ which is responsible for receiving mail from the internet.