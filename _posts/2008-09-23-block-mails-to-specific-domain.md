---
id: 843
title: Block mails to specific domain
date: 2008-09-23T22:20:36+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=843
permalink: /block-mails-to-specific-domain/
categories:
  - Exchange
---
In Exchange 2003 we could prevend sending to a domain with _delivery rectrictions._ In Exchange 2007 we can do this by using _transport rules _this can be created on the Hub Transport server. When we start the wizard and specify the name the next step is to define the _conditions_, here we choose the following options:

  * from users inside the organization
  * when a message header contains specific words, here we specify that we want to check the parameter _to_ which has the value _blockeddomain.com_ __

The next step is choosing the correct _action,_ we could for example bounce the e-mail back to the sender which contains a message that sending to this domain is prohibited by security settings.

  * send bounce message to sender with enhanced status code

The last step we could use is the _exceptions,_ this can be used to allow a specific address that is part of a domain that we will block.