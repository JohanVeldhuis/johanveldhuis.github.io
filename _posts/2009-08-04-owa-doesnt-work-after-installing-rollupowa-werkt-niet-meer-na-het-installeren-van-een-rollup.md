---
id: 1282
title: 'OWA doesn&#8217;t work after installing Rollup'
date: 2009-08-04T19:33:11+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1282
permalink: /owa-doesnt-work-after-installing-rollupowa-werkt-niet-meer-na-het-installeren-van-een-rollup/
categories:
  - Exchange
---
On several forums you will see that installing a rollup can break down OWA. One of the issues you can have is that a blank screen will be presented with in the url reason 0 as a parameter.

When you have this issue run the Powershell script updateowa.ps1. This script can be found in the Bin directory of Exchange.

After running the script OWA will work again.