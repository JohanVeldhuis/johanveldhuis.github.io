---
id: 1879
title: Get-owavirtualdirectory does not return all CAS servers
date: 2010-03-25T20:07:14+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1879
permalink: /get-owavirtualdirectory-laat-niet-alle-cas-servers-zien/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2010/03/melding_2.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
By accident I found a bug in Exchange 2010. The issue only occurs in Exchange 2010 and if you have multiple CAS servers which are located in different sites and can&#8217;t communicate to eachother. Till now I only saw the issue with Exchange 2010 where an extra CAS server was added to the mainoffice. In this case this is the 3rd CAS server in the Exchange 2010 environment

Normally you will get a nice overview of all CAS servers when running the get-owavirtualdirectory command. But when no RPC traffic is allowed between the sites you will get the following result:

[<img title="get-owavirtualdirectory" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/melding_1-150x144.jpg?resize=150%2C144" alt="" width="150" height="144" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/melding_1.jpg)

As you can see the command will display the first CAS server but it goes wrong when it wants to connect to the 2nd CAS server. This is normal because it can&#8217;t connect to it via RPC. Normally you would expect that the query will continue to run and will display the other servers, NOT. After contacting Microsoft they confirmed that this is a bug which will be fixed in a future update.

Workaround: open RPC

[<img title="get-owavirtualdirectory" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/melding_2-150x105.jpg?resize=150%2C105" alt="" width="150" height="105" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/03/melding_2.jpg)