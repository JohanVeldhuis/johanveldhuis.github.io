---
id: 2052
title: Changing the e-mail address Forefront Protection for Exchange 2010 uses
date: 2010-11-26T21:34:42+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2052
permalink: /het-e-mail-adres-wat-gebruikt-wordt-door-forefront-protection-for-exchange-2010-aanpassen/
categories:
  - Exchange
---
Forefront Protection for Exchange 2010 makes it possible to check messages for virusses and spam. Just like every other software Forefront can send messages when an infected message is found. By default Forefront generates an e-mail address during the installation. This may be something you don&#8217;t want but where can you change the e-mail address? You would expect that it can be changed in the console but you won&#8217;t find it there. To change the e-mail address you will need edit the registry.

[<img class="alignnone size-medium wp-image-2057" title="ForeFront Registry" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/11/ForeFront-Registry-300x46.jpg?resize=300%2C46" alt="" width="300" height="46" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/11/ForeFront-Registry.jpg?resize=300%2C46&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/11/ForeFront-Registry.jpg?w=480&ssl=1 480w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/11/ForeFront-Registry.jpg)

When you willl browse to the following key: _HKEY\_LOCAL\_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Forefront Server Security\Notifications\FromAddress_ you will find the address which is configured to send the notifications. Change the value to the address you like, reboot the Forefront services and your finished.