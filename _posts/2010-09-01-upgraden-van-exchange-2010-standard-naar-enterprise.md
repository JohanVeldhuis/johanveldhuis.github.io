---
id: 2001
title: Upgrading from Exchange 2010 Standard to Enterprise
date: 2010-09-01T18:45:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2001
permalink: /upgraden-van-exchange-2010-standard-naar-enterprise/
categories:
  - Exchange
---
As you may already know there are two versions of Exchange 2010 available:

  * Standard, which supports a maximum of 5 databases
  * Enterprise, which supports a maximum of 100 databases

In many cases the correct license will be installed immediately but in some cases it might be necessary to upgrade to the Enterprise edition. For example when your company buys another company and your Exchange environment will need to host all mailboxes of the employees of the other company which may not fit in your current database anymore. In these cases it might happen that you will reach the maximum of 5 databases which is the maximum of Standard Edition. But is it possible to upgrade to Enterprise in this case?

That was something which I thought was worth trying so I tested it in my lab environment. In the lab environment an Exchange 2010 Server Standard Edition is installed with the maximum of 5 databases. Now I want to add another database which would be the 6th database so this will have as a result that I would need to upgrade to the Enterprise Edition. In the Exchange Management Console you will not find the option anymore to fill in a license key so the only option left is the Exchange Management Shell.

By executing the following command:

_set-exchangeserver -productkey 123445-14553-53363-453463_

We will tell Exchange to use a new productkey, in this case a productkey for the Enterprise Edition. Just as like upgrading from a trail key to an official key you will need to restart the Information Store service.

[<img title="Exchange productkey" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/Exchange-License-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/Exchange-License.jpg)

Once restarted run the _get-exchangeserver_ cmdlet and you will see you have upgraded from Standard Edition to Enterprise Edition. But is there a way back? No there isn&#8217;t. You can only perform an upgrade and not a downgrade. When you try to do this you will receive the following error message:

[<img title="Exchange productkey" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/exchange-license-2-150x70.jpg?resize=150%2C70" alt="" width="150" height="70" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/exchange-license-2.jpg)

So don&#8217;t change the key before you are 100% sure that&#8217;s this is the way to go.