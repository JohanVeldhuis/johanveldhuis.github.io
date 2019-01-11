---
id: 817
title: 'OWA and ActiveSync won&#8217;t work anymore'
date: 2008-09-07T21:04:17+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=817
permalink: /owa-and-activesync-werken-niet-meer/
categories:
  - Exchange
---
Today I discovered a strange issue in my Exchange 2007 test environment both OWA and ActiveSync didn&#8217;t work anymore. A strange .NET error was displayed that if I wanted more info I needed to change a XML file. As I didn&#8217;t had changed many on the system I first looked if all services were running, this was the case. The next step was checking the event logs also there was nothing strange to find. The last step was IIS on first sight everything appeared to be OK but after investigating the .NET tab of the virtual folder OWA I discovered that it was set to 1.1 instead of 2.0. After changing this everything worked OK.