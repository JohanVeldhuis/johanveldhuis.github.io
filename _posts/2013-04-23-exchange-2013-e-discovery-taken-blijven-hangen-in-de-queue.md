---
id: 3154
title: 'Exchange 2013: e-Discovery tasks stay queued'
date: 2013-04-23T19:35:07+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3154
permalink: /exchange-2013-e-discovery-taken-blijven-hangen-in-de-queue/
categories:
  - Exchange
---
During some testing in a lab environment which contained Exchange 2010 SP3 and Exchange 2013 I found a strange issue. The e-discovery tasks all got stuck in the queue.

Let&#8217;s start with some background information. Since Exchange 2010 SP3 and Exchange 2013 CU1 it&#8217;s possible to install an Exchange 2013 server in an Exchange 2010 environment. This will give you the ability to migrate from Exchange 2010 to Exchange 2013. Before doing this it is recommended to perform some testing in a test environment.

The e-discovery functionality can be used to search for messages with for example specific keywords in specific or all mailboxes in an Exchange environment. Back to the issue.

After testing the same functionality on the Exchange 2010 SP3 server I found out that it worked correctly on that side. After some research the solution was pretty easy. As you might know Exchange contains a few special mailboxes. These mailboxes can&#8217;t be seen in the GUI and can only be found using the _Get-Mailbox_ cmdlet and using the _-arbitration _option.

[<img alt="get-mailbox -arbitration" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/arbitration-mailboxes-300x39.png?resize=300%2C39" width="300" height="39" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/arbitration-mailboxes.png)

When you have implemented Exchange 2013 in your current Exchange 2010 environment it is important to move the mailbox _SystemMailbox{e0dc1c29-89c3-4034-b678-e6c29d823ed9} _to a database hosted on an Exchange 2013 mailbox server.

The mailbox can be moved by using the _New-Moverequest _cmdlet:

_New-MoveRequest _SystemMailbox{e0dc1c29-89c3-4034-b678-e6c29d823ed9}  -TargetDatabase dbname__

Once the move request has migtrated the mailbox it might be necessary to restart the search. When looking at the status of the e-discovery now you will see that it proceeds and finally gets the status _completed_:

[<img alt="get-mailboxsearch" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/get-mailboxsearch-300x37.png?resize=300%2C37" width="300" height="37" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/get-mailboxsearch.png)

In the Technet documentation you will find a small description about this functionality. Using the e-discovery functionality in a coexistence scenario it is important to know that the mailbox search created on the Exchange 2013 environment can only be used to search Exchange 2013 mailboxes. If you would like to search the Exchange 2010 mailboxes you will need to perform a seperate e-discovery.

For more information about the e-discovery functionality you can have a look at the site below:

[Technet: In-Place eDiscovery](http://technet.microsoft.com/en-us/library/dd298021(v=exchg.150).aspx)