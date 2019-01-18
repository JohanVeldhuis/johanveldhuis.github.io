---
id: 1232
title: Enable/disable ActiveSync
date: 2009-06-04T21:43:26+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1232
permalink: /enabledisable-activesync/
categories:
  - Exchange
---
Today I got a question if it was possible to disable ActiveSync in Exchange 2007. The answer: yes this is possible and goes really easy:

  * open the _IIS manager_
  * double click on the _servernaam_
  * double click on the _applicationpool_
  * right click on_MsExchangeSyncAppPool_ and select _Stop_

If you decide to switch it on again just perform the steps above but choose the option _start_ in the last step.