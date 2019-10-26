---
id: 834
title: Scoped Send Connector
date: 2008-09-17T23:01:59+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=834
permalink: /scoped-send-connector/
categories:
  - Exchange
---
Normally creating a send connector is not really exited. The next step in the wizard is used for giving the domain for which the send connector needs to be used. But when you have a look at the bottom of the screen you will find the option _scoped send connector,_ but what is the effect of enabling this option.

When the option is activated the send connector can only be used by Hub Transport servers in the same AD site. When deactivated it can be used by all Hub Transport servers in the Exchange Organization.

Of course we can enable this option also when creating the send connector via Powershell, this can be done via the parameter _IsScopedConnector_. This parameter can have the value $true and $false.

  * _$true,_ this connector can be used by the Hub servers in the same AD site
  * _$false,_ this connector can be used by all Hub servers in the Exchange organization