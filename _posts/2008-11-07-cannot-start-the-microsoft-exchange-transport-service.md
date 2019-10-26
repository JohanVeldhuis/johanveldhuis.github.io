---
id: 939
title: Cannot start the Microsoft Exchange Transport service
date: 2008-11-07T21:57:08+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=939
permalink: /cannot-start-the-microsoft-exchange-transport-service/
categories:
  - Exchange
---
As each version of a software package each package will need some tricks to solve issues. With Exchange 2007 this is also the case. It can happen that the Microsoft Exchange Transport service won&#8217;t start. When you have this issue you may see several events with the ID 5023. This was the case which I found on a forum. The cause of this issue appears to be an empty _MsExchHomeRoutinggroup_ attribute.

To solve this issue we need to use ADSIEdit. First make a backup before making the changes as the change can cause more problems then you have at this moment.

Next you will need to follow the following procedure:

  * open ADSIEdit and choose to open the _configuration context_
  * search the attribute with the value _Exchange Administrative Group_
  * get the properties of the _Exchange Routing Group_ object
  * copy the value of _distinguishedName_
  * search for the _Servers_ object under the _Exchange Administrative Group_ 
  * get the properties of the HUB serverand search for the _msExchHomeRoutingGroup_ attribute
  * open _msExchHomeRoutingGroup_ and fill in the value which you copied in step 4
  * check if Exchange 2007 server is displayed in the ESM
  * restart the _Microsoft Exchange Transport service_

The procedure and more information can also be found in a KB article from Microsoft, see the link below.

<a href="http://support.microsoft.com/kb/948000" target="_blank">open</a>