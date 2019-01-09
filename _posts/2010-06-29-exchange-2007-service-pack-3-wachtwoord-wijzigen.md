---
id: 1917
title: 'Exchange 2007 Service Pack 3: changing your password'
date: 2010-06-29T21:46:58+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1917
permalink: /exchange-2007-service-pack-3-wachtwoord-wijzigen/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2010/06/owa.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2007
---
One of the new features in Exchange 2007 Service Pack 3 is the ability for users to change their password before logging in. Before service pack 3 a user who&#8217;s password had expired needed to call the helpdesk to reset their password or use another solution. With this new feature a user will be redirected to another page where he/she can change the password.

But how does this work? In the OWA directory, which you can find here: Exchange\ClientAccess\OWA, you will find a directory called auth. This directory contains several files which are used for login and logout. But besides these files there are two new files expiredpassword.aspx and exppw.dll.

Before you can use the new functionality you will need to make an adjustment in the registry of the CAS server. Go to the following location in the registry:

HLKM\SYSTEM\CurrentControlSet\Services\MSExchange OWA

Create a new DWORD called _ChangeExpiredPasswordEnabled_ and change the value of the key to 1. This should look the same like below:

[<img title="OWA password change feature registry key" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/06/reg.jpg?resize=530%2C60" alt="" width="530" height="60" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/06/reg.jpg)

During the logon (logon.aspx) a check is done if the password is expired and if this is the case the user will be redirected to expiredpassword.aspx.

Before the user can change his/her password he will first needs to specify the old password. Once the password has change the user will be redirected to his/her mailbox.

[<img title="OWA password change page" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/06/owa-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/06/owa.jpg)