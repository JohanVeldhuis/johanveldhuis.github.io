---
id: 890
title: Block backscatter mails with Exchange 2007
date: 2008-10-04T20:50:33+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=890
permalink: /blokkeer-backscatter-mails-met-exchange-2007/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Tutorials
---
[<img class="alignnone size-thumbnail wp-image-891" title="Transport Rule" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/10/step_31-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/10/step_31.jpg?resize=150%2C150&ssl=1 150w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads//customers/johanveldhuis.nl/johanveldhuis.nl/httpd.www/wp-content/uploads/2008/10/step_31.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads//customers/johanveldhuis.nl/johanveldhuis.nl/httpd.www/wp-content/uploads/2008/10/step_31.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/10/step_31.jpg)

It has been a while ago that I published a tutorial. This tutorial will describe how to block backscatter mails with Transport Rules. This tutorial will describe step by step how to create them. The block the backscatters we need to add 2 Transport rules. The first rule will add a tag to each mail which will be send to the internet. The second rule will check each mail that is a NDR for the specified tag

[open](http://johanveldhuis.nl/?page_id=873&lang=en)