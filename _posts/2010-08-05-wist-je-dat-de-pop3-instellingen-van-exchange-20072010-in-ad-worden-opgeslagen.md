---
id: 1982
title: Did you now pop3 settings of Exchange 2007/2010 will be stored in AD?
date: 2010-08-05T21:28:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1982
permalink: /wist-je-dat-de-pop3-instellingen-van-exchange-20072010-in-ad-worden-opgeslagen/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2010/08/pop3adsi.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
Pop3, you don&#8217;t see it very often these days but sometimes you will have to use it. Most times this is for legacy applications or applications which can&#8217;t work with the Exchange MAPI.

The pop3 connector has several options which can be configured, for example the banner which is displayed when making a connection to the server. This message may not be changed very often but when looking at the authentication method or the retrievel settings then you might make some changes to them.

[<img title="Exchange pop3 settings" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/pop3-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/pop3.jpg)

After making the necessary changes you will need to restart the pop3 service, either via the services MMC or via the command _net stop MSExchangePop3 _followed by _net start MSExchangePop3._ In an environment where you only have one domain controller this will work. But in an environment where you have multiple domain controllers this might take a while, despite you restarted the pop3 service.

The reason for this? Settings for the pop3 connector are stored in the Active Directory. You can find them in the _configuration_ partition of AD in the following folder:

_CN=Services, CN=Microsoft Exchange, CN=Administrative Groups,CN=Exchange Administrative Group  (FYDIBOHF23SPDLT),CN=Servers,CN=CASServer,CN=Protocols,CN=Pop3,CN=1_

When you get the properties of the object you will see the settings of the pop3 connector:

[<img title="pop3adsi" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/pop3adsi-150x109.jpg?resize=150%2C109" alt="" width="150" height="109" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/pop3adsi.jpg)

So keep in mind that if you change the pop3 settings in an environment with multiple DC&#8217;s it might take a while before the changes are applied.