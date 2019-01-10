---
id: 3147
title: 'Redmond: where&#8217;s my Exchange Admin Center'
date: 2013-04-18T20:05:05+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3147
permalink: /redmond-waar-is-mijn-exchange-admin-center/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2013/04/ECP-Exchange-2013.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
&nbsp;

Since CU1 is available it is possible to implement Exchange 2013 in an environment which contains Exchange 2010 SP3. This will create the option to migrate your resources to Exchange 2013. As you may now the Exchange Management Console (EMC) is replaced by the  Exchange Admin Center (EAC) a web based admin tool.

The EAC is accessible via the url _https://fqdn/ecp_ for those who are familiar with Exchange 2010 will see this is the same url as for the  Exchange 2010 Control Panel. When Exchange 2013 is implemented you would like to check somethings and maybe configure several things via the EAC.

To do this go to _https://fqdn/ecp _and you will see the following screen:

[<img alt="Exchange 2013: EAC login" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-login-300x174.png?resize=300%2C174" width="300" height="174" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-login.png)

Provide the username and password and login:

[<img alt="Exchange 2010: ECP" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-Exchange-2010-300x123.png?resize=300%2C123" width="300" height="123" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-Exchange-2010.png)

But what you will see is the Exchange Control Panel. But how can you get to the Exchange Admin Center?
  
To do this you will need to add an additional parameter to the url _https://fqdn/ecp?ExchClientVer=15._ The loginpage will be displayed again but after you have provided the login details you will see the EAC:

[<img alt="Exchange 2013 EAC" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-Exchange-2013-300x95.png?resize=300%2C95" width="300" height="95" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/ECP-Exchange-2013.png)

A simple solution but which can take pretty long before you have found this specific thing.