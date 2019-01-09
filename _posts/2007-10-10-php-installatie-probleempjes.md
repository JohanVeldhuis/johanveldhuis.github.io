---
id: 31
title: PHP installation issues
date: 2007-10-10T21:46:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=31
permalink: /php-installatie-probleempjes/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Blog
---
[![PHP](/wp-content/uploads/2008/03/php2.thumbnail.jpg)](/wp-content/uploads/2008/03/php2.jpg "PHP")As promissed I would report how the installation of PHP went on a new server. During the instllation the following parameters will be setup: upload\_tmp\_dir and session.save_path to the tmp directory from the user that is logged on. This can cause some really strange issues, so change the directory to one that can be accessed easily by every user. Besides this issue I got the issue that .php files were not recognized correctly. By adding the reference to php5isapi.dll again it worked OK. There needs to be fixed a lot to the installation of PHP despite it uses a MSI.