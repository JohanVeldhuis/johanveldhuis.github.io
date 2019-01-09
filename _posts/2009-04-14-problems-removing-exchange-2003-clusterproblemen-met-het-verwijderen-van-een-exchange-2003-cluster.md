---
id: 1174
title: Problems removing Exchange 2003 cluster
date: 2009-04-14T21:10:43+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1174
permalink: /problems-removing-exchange-2003-clusterproblemen-met-het-verwijderen-van-een-exchange-2003-cluster/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2003
---
During one of my forum visits I found a really interesting issue. Someone tried to remove his old Exchange 2003 cluster but received the following error when trying to dit it:

Found no Disk resource for the disk that contains the folder &#8216;W:\EXCHSRVR&#8217;

When looking in the Cluster Administrator the resource was not visible, very strange. So we needed to remove the pointer to the w:\ disk by using ADSIEDIT.

Before performing such an action you will first need to create a backup of your AD.

Next execute the following steps:

&#8211; open adsiedit
  
&#8211; choose connect to
  
&#8211; change the domain to configuration
  
&#8211; expand CN=Configuration &#8230;
  
&#8211; expand CN=services
  
&#8211; expand CN=Microsoft Exchange
  
&#8211; expand CN=First organization (or your organization if different)
  
&#8211; expand CN=servers
  
&#8211; expand CN=_servername
  
_ &#8211; expand CN=Information Store

There you will find the First Storage group and other storage group. Get the properties of them both the storage group and the databases in it it and check if none of them points to the w:\disk
  
But in this case it was something else where we need to have a look at, perform the same steps as above but stop after expand CN=servers and continue with the steps below:

&#8211; get the properties of the_servername
  
_ &#8211; search for the value MsExchDataPath
  
&#8211; check if the pointer is not listed

After this try to remove the Exchange cluster again.