---
id: 1832
title: Forefront for Exchange 2010 installation issue
date: 2010-02-03T21:05:59+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1832
permalink: /forefront-for-exchange-2010-installation-issue/
categories:
  - Exchange
---
I had a nice issue during the installation of Forefront for Exchange 2010. It began with an issue with the pre-release which caused the Exchange Transport service to stop after a failed update of Forefront. This had as result that several Forefront services didn&#8217;t start anymore. As the Exchange Transport service is dependent on the Forefront service this had as result that this service didn&#8217;t start anymore also. Which caused no mails could be send and received.

As the RTM is released it was a nice moment to install that one. So first removed the pre-release so this couldn&#8217;t cause any issues. After this the problems began, the first steps went OK till I reached the prerequisite check. This gave the following error: 

[<img src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/02/Capture-150x150.jpg?resize=150%2C150" alt="" title="Forefront for Exchange 2010 installation error" width="150" height="150" class="alignnone size-thumbnail wp-image-1831" srcset="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/02/Capture.jpg?resize=150%2C150&ssl=1 150w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/02/Capture.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/02/Capture.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/02/Capture.jpg)

First I checked the group membership of the user, these were:

  * local administrator
  * domain administrator
  * Exchange organization management groep

So this couldn&#8217;t cause issues because this should be enough. So I tried to connect to the domain controller on specific ports which was no issue at all. You may ask why does the setup needs to reach the domain controller? Well during the setup the computeraccount needs to be added to the Exchange Hygiene Management group. Because we had to make some changes in the firewall so the servers could reach some other domain controllers in another location.

As last step I wanted to show a collegue the issue and was surprised when the setup continued. So we started to investigate the issue. The problem was that the Exchange server couldn&#8217;t reach the domain controller which had the PDC and RID Master FSMO roles.

Now everything is fixed I can look back at a good learning moment en why the pre-release installation worked ? All servers where in the same location when that happened.