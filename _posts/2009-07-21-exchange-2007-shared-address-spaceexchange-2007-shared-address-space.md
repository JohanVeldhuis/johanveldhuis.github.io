---
id: 1251
title: Exchange 2007 shared address space
date: 2009-07-21T20:10:49+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1251
permalink: /exchange-2007-shared-address-spaceexchange-2007-shared-address-space/
categories:
  - Tutorials
---
Sometimes you will find the situation having several types of mailservers within one organization, for example Exchange in combination with another mailserver.

But how can you arrange that Exchange will accept the mail, checks if the recipient exists on the Exchange server and if not will forward it to the other mailserver,

In this tutorial we will ensure that mail which is send to the domain johanveldhuis.nl will be accepted by Exchange and if the user does not exist Exchange will forward it to the other mailserver.

[open](http://johanveldhuis.nl/?page_id=1256&lang=en)