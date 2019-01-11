---
id: 1024
title: Winmail.dat
date: 2008-12-27T23:25:14+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1024
permalink: /winmaildat/
categories:
  - Exchange
---
Maybe you have seen it an e-mail with a winmail.dat file as attachment. This is caused by a sender which sends an e-mail in RTF format to a user that has an e-mail client which does not support RTF.

In Exhange you can have this issue also when forwarding mails to a mailcontact, this can be solved in two ways:

  * per mailcontact
  * per remote domain

First per mailcontact, for this you will need to get the properties of the mailcontact. You will then see the _general_ tab, this contains the information below:

[<img class="alignnone size-thumbnail wp-image-1025" title="peruser" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/12/peruser-150x66.jpg?resize=150%2C66" alt="" width="150" height="66" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2008/12/peruser.jpg?resize=150%2C66&ssl=1 150w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads//customers/johanveldhuis.nl/johanveldhuis.nl/httpd.www/wp-content/uploads/2008/12/peruser.jpg?zoom=2&resize=150%2C66&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2008/12/peruser.jpg)

With the option _use MAPI rich text format_ you can specify if this needs to be applied always, never or that the default value needs to be used.

The other way is by defining this per remote domain, this can be configured by selecting the Hub Transport Server and open the _remote domains_ tab. Here you can specify a seperate domain for which you want to specify the settings. When you already have configured a remote domain for which you want to change this just get the properties of it. Then go to the tab _Format of original message sent as attachment to journal report._

Here you will find the following information:

[<img class="alignnone size-thumbnail wp-image-1026" title="RTF per domain" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2008/12/perdomain-150x79.jpg?resize=150%2C79" alt="" width="150" height="79" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/12/perdomain.jpg)

Below the _Exchange rich-text format_ you can define if this will be used always or never. Besides this you can define that this setting is specified per individual user