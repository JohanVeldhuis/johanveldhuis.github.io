---
id: 1112
title: Installation of Groupshield changes authentication method
date: 2009-02-19T22:06:36+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1112
permalink: /installatie-van-groupshield-pas-authenticatie-methode-aan/
categories:
  - Exchange
---
[<img class="alignnone size-medium wp-image-1113" title="McAfee GroupShield" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/02/groupshield_microsoft_exchange_135x120.jpg?resize=135%2C120" alt="" width="135" height="120" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/02/groupshield_microsoft_exchange_135x120.jpg)

Are you almost finished with implementing Exchange, you install Groupshield and the authentication method used is changed. This is what I experienced today during an Exchange 2007 installation. The authentication method before the installation of Groupshield was mostly basic authentication and some integrated authentication.

Next you install Groupshield and after that it is not possible anymore to login with only the username and you will need to login as domain\username. Very strange because when I checked the Exchange Management Console and IIS everything was OK.

The only way to fix this issue is to change the authentication mode and then revert it back to the one you want.