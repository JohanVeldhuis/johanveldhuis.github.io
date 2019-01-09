---
id: 1372
title: New CAS-server not used by clients
date: 2009-10-19T21:01:59+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1372
permalink: /nieuwe-cas-server-wordt-niet-gebruikt-door-clients/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
aktt_notify_twitter:
  - 'no'
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
In Exchange 2010 clients will make a connection to the CAS server(s) instead of the mailboxserver. One exclusion for this are the Public Folders, they will still be accessed view the old way. One of the advantages of this is that client will lose connection for 30 seconds instead of for 1 minute during a failover.

Installing a new CAS-server shouldn&#8217;t cause much problems. When everything is going OK the _RpcClientAccessServer_ parameter will be updated automaticly with the new FQDN of the new CAS-server.

On several fora I found out that this will not always be the case, of course the final version isn&#8217;t released yet so it may be solved in that version. To explain how you can solve the issue I will give a short explanation of what happens and how you can fix it. 

When the parameter isn&#8217;t updated correctly, the clients can&#8217;t connect to Exchange anymore when the old CAS-server is removed. To prevend this from happening it&#8217;s advisable to check the parameter of the current mailbox databases, new databases will get the correct value of the parameter. To find out if the value is updated run the command _get-mailboxdatabase |fl_ when you only want to get the value of the parameter _RpcClientAccesServer _you can run it like this_ get-mailboxdatabase |fl RpcClientAccessServer,_depending on the which one you execute you will get an output:

_RpcClientAccessServer : cas.domain.com_

To update the value we need the execute the following command _set-mailboxdatabase -identity &#8220;mbdb&#8221; -RpcClientAccessServer &#8220;casarray.domain.com&#8221;_ 

When you would like to make your CAS high-available you may choose to build a load-balanced CAS environment. When you have set it up the next step is to define a new _Client Access Array_ in Exchange, their can be only one _Client Access Array_ per Active Directory site. To create a new array you will need to execute the following command _new-ClientAccessArray -name &#8220;CAS array&#8221; -FQDN &#8220;casarray.domain.com&#8221;._ After this you will need to repeat the steps described above to update the parameter of the mailbox database.

Below some usefull links:

Technet: new-ClientAccessArray <a href="http://technet.microsoft.com/en-us/library/dd351149(EXCHG.140).aspx" target="_blank">open</a>
  
Technet: set-mailboxdatabase <a href="http://technet.microsoft.com/en-us/library/bb124924(EXCHG.140).aspx" target="_blank">open<br /> </a>Technet: get-mailboxdatabase <a href="http://technet.microsoft.com/en-us/library/bb124924(EXCHG.140).aspx" target="_blank">open</a>