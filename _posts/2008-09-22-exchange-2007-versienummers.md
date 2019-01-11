---
id: 839
title: Exchange 2007 versionnumbers
date: 2008-09-22T22:51:42+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=839
permalink: /exchange-2007-versienummers/
categories:
  - Exchange
---
Such as every software Exchange also has a versionnumber. Below a short overview of versionnumbers:

  * Exchange 2007 RTM  8.0.685.24 or 8.0.685.25
  * Exchange 2007 SP1   8.1.0240.006

It looks a little strange 2 versionnumbers for the RTM version but when you will look in different places you will see they are used both.

  * Exchange Management Console/Exchange Management Shell/Outlook 8.0.685.24
  * Register/MOM 8.0.685.25

One exception to this is the Edge Transport Server this will be listed as version 8.0.685.25 where ever you look.

On first sight no problem using the different version number but when you look in the About Exchange 2007 option under the help menu you will see another versionnumber 685.018. The last one is solved in service pack 1.

When you have installed service pack 1you will see the versionnumbers have changed to 8.1.0240.006. Except the one from the Edge Transport server, this will stay the same unless you setup a new Edge subscription. This is because the Edge Transport does not modify values in Exchange unless you setup a new Edge subscription.

When you want to know the exact version of the specific roles you will need to have a look in the registry:

_HKEY\_LOCAL\_MACHINE\SOFTWARE\Microsoft\Exchange\v8.0\<Role>\ConfiguredVersion_ 

The parameter _configuredversion_ is a string value in the following format _x.x.xxx.x, _for example 8.1.0240.006

  * _8,_ the major build number
  * _1,_ the service pack which is installed
  * _240,_ the build number
  * _006, _the minor build number