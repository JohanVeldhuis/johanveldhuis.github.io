---
id: 28
title: Nice bug in Dreamweaver CS3
date: 2007-11-01T11:01:01+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=28
permalink: /leuk-bugje-dreamweaver-cs3/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Blog
---
[![Dreamweaver CS3](/wp-content/uploads/2008/03/dreamweaver.thumbnail.jpg)](/wp-content/uploads/2008/03/dreamweaver.jpg "Dreamweaver CS3") 

During playing around with Dreamweaver I discovered a nice problem this weekend. Files who were created with Dreamweaver couldn&#8217;t be opened anu more. When you did this Dreamweaver crashed. I had some extensions installed so first I deleted those, but that was not the solution . I decided to search on the internet and saw that a lot of people had this issue. The problem was caused by the winter-time that was adjust also in the USA. A bug that was not found during the beta test of the product. The solution is really simple. Delete the file WinFileCache*.dat from the application data\Adobe\Dreamweaver 9\Configuration directory and your problem is solved. If you use Vista then you can find the file in the following directory AppData\Roaming\Adobe\Dreamweaver 9\Configuration