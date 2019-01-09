---
id: 8
title: VPC does not want to start anymore
date: 2008-03-13T20:54:43+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=8
permalink: /vpc-niet-meer-op-te-starten/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Blog
---
[![](/wp-content/uploads/2008/03/vpc.thumbnail.jpg)](wp-content/uploads/2008/03/vpc.jpg "Virtual")

Nice program Virtual PC till you are gone use the file on different PC&#8217;s. I made an image to test somethings and thought, why not using it on another pc. I connected my usb disk to the other machine and tried to start the VPC but no go. I got an error that it was in use on another pc and that the file was read-only. The first part could not be it so I started to search. The problem will be caused by a permission issue, a normal user only has read and execute rights which is to less to start a VPC. After changing the right on the file it worked again.