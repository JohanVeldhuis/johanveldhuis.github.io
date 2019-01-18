---
id: 2708
title: 'The Exchange 2013 alphabet: Client Access Server'
date: 2013-02-07T22:37:50+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2708
permalink: /the-exchange-2013-alphabet-client-access-server/
categories:
  - Exchange
---
This is the 3rd blog in the Exchange 2013 ABC serie. In this blog we will look at the Client Access Server component. Let&#8217;s first have a look at a little history of client access in the previous versions.

**History**

In Exchange 2003 clients could connect via two ways:

  * Directly to the Back-end server
  * Via a Front-end server which proxied the connection to the correct Back-end server

Starting from Exchange 2007 Microsoft decided to create a separate server role which was used to handle the client access called the Client Access Server (CAS). This server could be either installed:

  * As a separate server
  * On the same server as the Hub Transport Server
  * On the same server as the Hub Transport and Mailbox Server aka multirole server (only allowed if clustering for the Mailbox Server was not used)

In Exchange 2010 Microsoft did continue to separate the roles but there was a big change in the support colocation of server roles on one server. Compared to Exchange 2007 it was now supported to collocate the CAS, Hub Transport and Mailbox Server role even if the Mailbox Server would be a part of a Database Availability Group (DAG). So this created the following options:

  * As a separate server
  * On the same server as the Hub Transport Server
  * On the same server as the Hub Transport and Mailbox Server aka multirole server

**Exchange 2013**

So now we had a brief look at the past let’s have a look at how Microsoft did arrange it starting from Exchange 2013. Well it looks like they have updated the Client Access part so it matches the architecture as it was in Exchange 2003.

The Client Access part of Exchange 2013 consist of two pieces:

  * CAS role
  * Mailbox Server role

Let’s explain it in more detail. The CAS role from Exchange 2013 contains three components:

  * Client access
  * SMTP
  * UM Routing

So what happens when a request from a client arrives? The Client Access component authenticates the session and then proxies the connection to the Mailbox Server which hosts the active copy of the Mailbox Database containing the mailbox of the user. Clients will never make a direct connection to the components hosted on the Mailbox Server role. All connections are made via the Client access component on the CAS role.

This is just one change in Exchange 2013. The most important change in Exchange 2013 is that clients won’t use RPC over TCP anymore but are using RPC over HTTP. This change has several benefits among them:

  * Clients only use HTTPS to connect so no large port range has to be opened on the firewall
  * HTTPS is more suitable if connecting over a network connection which has a high latency

So let’s discuss the points mentioned above. In some cases a firewall is placed between the clients and the servers. Although you could limit the RPC usage for as described in [this](http://social.technet.microsoft.com/wiki/contents/articles/864.configure-static-rpc-ports-on-an-exchange-2010-client-access-server.aspx) article. This still required multiple ports to be opened. Now Microsoft has decided to move to RPC over HTTP only port 443 is being used to access the resources of Exchange. A configuration change has to be made to make thsi possible. By default the OAB is available at port 80 so you will need to change this so it can also be accessed via 443.

That brings us to the second point which would normally not occur on LANs: latency. This has a high impact on RPC over TCP but RPC over HTTPS can handle this issues better although it’s still something you would like to be kept at a minimum in your LAN environment.

Another change in Exchange 2013 is the namespaces required for your environment. In a typical site resilient Exchange 2010 environment you could end up with 8 names which are required for your environment. Two of them where the names for the CAS Array. These names were set as RPC Client Access Server on the databases and would appear in the Outlook profile of the user:

[<img class="aligncenter size-medium wp-image-2711" title="Outlook profile" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Outlook-profile-300x80.png?resize=300%2C80" alt="" width="300" height="80" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Outlook-profile.png?resize=300%2C80&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Outlook-profile.png?w=445&ssl=1 445w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Outlook-profile.png)

Now in Exchange 2013 we don’t need to set the RPC Client Access Server parameter anymore. Instead of the CAS Array name we will connect to something like this: <MailboxGUI@corp.local>.

So what’s the advantage of this? Well maybe you remember the pop up that users received this pop up:

[<img class="aligncenter size-medium wp-image-2715" title="Outlook Pop up" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Pop-up-300x107.png?resize=300%2C107" alt="" width="300" height="107" srcset="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Pop-up.png?resize=300%2C107&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Pop-up.png?w=550&ssl=1 550w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/02/Pop-up.png)

Well that’s history starting from Exchange 2013. This since the server value does not change anymore. So if an administrator decides to move a mailbox the user won&#8217;t be prompted to restart Outlook anymore.

**Load Balancing**

And what about load balancing has this changed? Yes this has changed. In Exchange you would need to setup session affinity and use layer 7 load balancing for some of the protocols. In Exchange 2013 you don&#8217;t have to do anything with layer 7 just use layer 4 functionality of the load balancer. Besides this session affinity is not required anymore. This because it will have no effect if the session is arriving via another CAS this since rendering of for example OWA happens on the Mailbox Server. So if a session is lost and is reconnected via another CAS it will still arrive at the same Mailbox Server which performed the rendering.

But what about the authentication? After the user has logged in an authentication cookie is provided which is encrypted with the CAS&#8217;s SSL certificate. When the client is connected via another CAS the authentication cookie is decrypted. For this proces to work it is imported that all CAS will share the same certificate.

Here ends the third blog in the Exchange 2013 ABC series. In this blog we discussed the changes in the Client Access Server component. In the next blog we will have a look at Database Availability Groups in Exchange 2013. Below are some interesting links about the Client Access Server of Exchange.

**Useful links:**

**Robert’s Rules of Exchange: Multi-Role Servers:**

<a href="http://blogs.technet.com/b/exchange/archive/2011/04/08/robert-s-rules-of-exchange-multi-role-servers.aspx" target="_blank">http://blogs.technet.com/b/exchange/archive/2011/04/08/robert-s-rules-of-exchange-multi-role-servers.aspx</a>

**Exchange 2013 Client Access Server:**

<a href="http://blogs.technet.com/b/exchange/archive/2013/01/25/exchange-2013-client-access-server-role.aspx" target="_blank">http://blogs.technet.com/b/exchange/archive/2013/01/25/exchange-2013-client-access-server-role.aspx</a>