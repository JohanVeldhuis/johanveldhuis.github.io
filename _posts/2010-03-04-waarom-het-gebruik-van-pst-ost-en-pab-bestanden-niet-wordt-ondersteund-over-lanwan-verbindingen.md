---
id: 1852
title: Why the use of PST, OST and PAB files is unsupported over LAN/WAN Links
date: 2010-03-04T19:32:58+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1852
permalink: /waarom-het-gebruik-van-pst-ost-en-pab-bestanden-niet-wordt-ondersteund-over-lanwan-verbindingen/
categories:
  - Exchange
---
Sometimes you may have the discussion if it is supported to place these files on fileserver so they can be accessed via a LAN/WAN connection. The answer for this is no, it isn&#8217;t officially supported by Microsoft. But when you will try it in your environment it will work, so what are the reasons it isn&#8217;t supported?

The PST, OST and PAB files will be accessed by a method called file-access-driven. With this method special file access commands will be offered by the OS to read and write files. For writing files to local disks this is an excellent method but when writing to a fileserver via a LAN/WAN another method is used. This method is called network-access-driven and uses specific command from the OS to send/receive data from/to other systems which are connected to the network.

But what does Outlook when a PST is located on the network? Outlook will first try to use the file-access driven commands to read/write to the file. Because the file is not on the local disk but on the network, the OS will send the network-access-driven commands to the server where the file is located.

This will cause a lot of time  for the process to be completed because of all the extra steps.

[<img title="Schema" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/pst2.jpg?resize=359%2C57" alt="" width="359" height="57" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/pst2.jpg)

Besides the performance issues you might  get there are some other things which you should keep in mind:

  * files can get corrupted caused by network issues
  * writing- can take 4 times longer then read actions

If you want to get more information after reading this have a look at the sides below:

Ask the Performance team: Network stored PST files &#8230;. don&#8217;t do it! <a href="http://blogs.technet.com/askperf/archive/2007/01/21/network-stored-pst-files-don-t-do-it.aspx" target="_blank">open</a>
  
Configuring Outlook for Roaming Users <a href="http://office.microsoft.com/en-gb/help/HA011402691033.aspx" target="_blank">open</a>