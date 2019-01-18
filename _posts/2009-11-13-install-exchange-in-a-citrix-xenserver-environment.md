---
id: 1673
title: Install Exchange in a Citrix Xenserver environment
date: 2009-11-13T21:22:53+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1673
permalink: /install-exchange-in-a-citrix-xenserver-environment/
categories:
  - Exchange
---
[<img title="Exchange setup error" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/11/Capture-150x150.jpg?resize=150%2C150" alt="Exchange setup error" width="150" height="150" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/11/Capture.jpg)

Today I brought a new Exchange environment in the air. This time it was a greenfield situation, an environment which is completely seperated from the old environment. A big part of the server environment is virtualized, one of them is the Exchange server. Citrix XenServer was selected as the virtualization environment, and as it is listed on the list on the Microsoft site it should not be a problem.

So after the design was approved by the customer we started with the installation. Since some small things needed to be done on other servers I opened Xencenter so I can easily get access to all servers. It should not be a big problem you may think, till Exchange started with preparing the AD. After a few minutes the following error was displayed _you do not have permissions to read the security descriptor on cn=deleted  objects,cn=configuration,dc=ishw,dc=local._ Very strange because the account had enough permissions and the replication between the dc&#8217;s went OK. So I started to search for the cause of the issue and found a few possibilities:

&#8211; change the driveletter of the cd/dvd-rom, this was not an option since the installation was placed on a fileshare
  
&#8211; fix the permissions with ADAM, as this option brings some risks with it I skipped this one and saved it for later
  
&#8211; install it via the console, a little bit probelematic with a vm, so i tried RDP with the /console or /admin option

This last optionwas the solution, so XenCenter will make a RDP connection without the /console or /admin option. If your planning to install Exchange in a XenServer environment keep an eye on this.

Below some interesting articles&#8221;

Microsoft Support Policies and Recommendations for Exchange Servers in Hardware Virtualization Environments <a href="http://www.windowsservercatalog.com/results.aspx?&bCatID=1521&cpID=0&avc=0&ava=0&avq=0&OR=1&PGS=25" target="_blank">open</a>
  
Security descriptor error during Exchange Server 2007 schema extension <a href="http://exchangeserverpro.com/security-descriptor-error-during-exchange-server-2007-schema-extension" target="_blank">open</a>
  
Technet Forum: Exchange 2007 Install Error : Read Security Descriptor <a href="http://social.technet.microsoft.com/Forums/en/exchangesvrdeploy/thread/8375a3ac-f977-45fa-8baf-6335caa4b519" target="_blank">open</a>