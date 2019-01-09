---
id: 1796
title: 'Using %r in the e-mailaddress policy'
date: 2010-01-14T21:19:06+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1796
permalink: /r-gebruiken-in-een-e-mailaddress-policy/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
E-mailaddress policies always funny to work with them, sometimes you will have to puzzle a bit. Since Exchange 2007 you will have the possibility to use a wizard to create an e-mailaddress policy. Within the wizard a few templates are created which you can use. But sometimes you might want to create your own template. In that case you can use the following parameters:

  * **%s** : surename
  * **%g** : givenname
  * **%i** : initials
  * **%d** : display name 
  * **%m** : Exchange 2003 alias
  * **%rxy** : replaces the character after the r with the last character, in this example x is replaced by y.

As you can see you can use several parameters but what if you would like to use only the first 2 characters of the givenname. This can be simply done by adding the number 2 before the g, so %2g. Let&#8217;s give some examples, our user has the following name Piet van der Kolk.

  * **%d :** <pietvanderkolk@domain.com>
  * **%g.%s :** <piet.vanderkolk@domain.com>
  * **%1g.%s :** <p.vanderkolk@domain.com>
  * **%g.%r .%s :** <p.van.der.kolk@domain.com>

If you would like to have more examples then have a look at the site below. The site is made for Exchange 2003 but the parameters can still be used in Exchange 2010: 

Technet &#8211; How to modify an SMTP E-Mail Address by Using Recipient Policies <a href="http://support.microsoft.com/kb/822447" target="_blank">open</a>