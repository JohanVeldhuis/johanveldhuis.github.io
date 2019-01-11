---
id: 1179
title: First look at Exchange 2010 Beta
date: 2009-04-17T22:07:45+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1179
permalink: /first-look-at-exchange-2010-betaeerste-blik-op-exchange-2010-beta/
categories:
  - Exchange
---
Exchange 2010 beta has been released for several days and of course I have installed it myself. The coming weeks  I will publish several articles about the changes in Exchange 2010 Beta. Ofcourse it is a beta so it could be that some features will not be available in the final version.

In this article I will zoom in at the mailbox part and then specificly to the Exchange Management Console.

When you open the Exchange Management Console and go to _mailbox_ via _organizational configuration_ you will see the following tabs:

[<img class="alignnone size-thumbnail wp-image-1180" title="Mailbox tabs" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox-150x66.jpg?resize=150%2C66" alt="Mailbox tabs" width="150" height="66" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox.jpg?resize=150%2C66&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox.jpg?zoom=2&resize=150%2C66&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox.jpg?zoom=3&resize=150%2C66&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox.jpg)

You can see 2 news tabs here:

  * database management
  * database availability group

First database management, on this tab your can create a mailbox and enable a database copy. The greatest difference is that there are no storage groups anymore but only databases.

When getting the properties of the database you will see 4 tabs instead of 3. I think this is done because on specific tabs more information is displayed.

[<img class="alignnone size-thumbnail wp-image-1181" title="Mailbox database general tab" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_4-150x150.jpg?resize=150%2C150" alt="Mailbox database general tab" width="150" height="150" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_4.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_4.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_4.jpg)

On the general tab you will see a few new fields:

  * _mounted on server_: here you can see on which mailbox server the database is mounted
  * _master_: this is the server which is master of the specific database
  * _master type_: this is the type of the server which is the master of the database
  * _servers that have a copy of this database_: this field will contain all servers that have a copy of the database

[<img class="alignnone size-thumbnail wp-image-1182" title="Mailbox database maintenance" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_5-150x150.jpg?resize=150%2C150" alt="mailbox_5" width="150" height="150" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_5.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_5.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_5.jpg)

The tab _maintenance_ is a new tab compared with Exchange 2007. The fields displayed on this tab where previously displayed on the general tab. The only new field is _circular logging,_ this was  displayed on Storage Group level in Exchange 2007.

On the two other tabs: _Limits_ en _Clients_ there has nothing been changed.

When you are searching for the option local continious replication you can spent a lot of time before finding it. LCR is not available anymore in Exchange 2010 just as almost every high availability options, these options have been replaced by a new option called:  _Database Availability Group_, this will be discussed later in this article.

Configuring the database copy is really easy and can be done fully via the EMC.

[<img class="alignnone size-thumbnail wp-image-1184" title="Mailbox database copy" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_8-150x150.jpg?resize=150%2C150" alt="Mailbox database copy" width="150" height="150" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_8.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_8.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_8.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_8.jpg)

Only a few fields need to be filled in:

  * the server which you would like to copy the database to, this can be only a server which is in the same DAG group as the master server.
  * replay lag time, the delay before the logs will be replayed on the other mailbox server
  * truncation lag time,  the delay before logs will be truncated on the other mailbox server
  * preferred list sequence number, the priority of the copy, this copy is used when the database needs to be activated on another mailbox server, for example when an other server needs to be activated because the master server went down.

When the datbase copy is configured you can view the status by getting the properties of the database in the lower part of the screen.

[<img class="alignnone size-thumbnail wp-image-1186" title="Mailbox database general tab" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_2-150x150.jpg?resize=150%2C150" alt="Mailbox database general tab" width="150" height="150" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_2.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_2.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_2.jpg)

On the first tab you can easily see how many logs need to be copied/replayed, how many logs have been copied/replayed and what the curren priority is.When having a look at the status tab you can see several status messages of several items:

[<img class="alignnone size-thumbnail wp-image-1187" title="Mailbox database status tab" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_3-150x150.jpg?resize=150%2C150" alt="Mailbox database status tab" width="150" height="150" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_3.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_3.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_3.jpg)

In Exchange 2007 this can only be done via Powershell, but now you can do it via the EMC. The button _view_ is only active when failures happen during the copy of the database.

The second tab is called _database availability group_. This option makes it possible to copy a database to a maximum of 16 Exchange 2010 servers. The DAG monitor will keep an eye on database and if needed will perform an automatic database-level recovery of a database, server, or network issue. 

Before you can use the DAG functionality you will need to create a DAG group. This group contains all servers which will have a copy of the specific database

[<img class="alignnone size-thumbnail wp-image-1185" title="Database availability group" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_9-150x150.jpg?resize=150%2C150" alt="Database availability group" width="150" height="150" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_9.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_9.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_9.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/mailbox_9.jpg)

Configuring the DAG group goes really easy, a few fields need to be filled in:

  * _database availability group name_::name of the database availability group
  * _file share witness share_: name of the share that willbe created on the HUB server
  * _file share witness directory_: the name of the directory where the files need to be placed in
  * _network encryption_: when does traffic need to be encrypted
  * _network compression_: when does traffic need to be compressed

This is the end of the first article about Exchange 2010 beta.