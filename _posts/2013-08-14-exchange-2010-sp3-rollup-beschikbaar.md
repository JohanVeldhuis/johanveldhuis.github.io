---
id: 3252
title: Exchange 2010 SP3 Rollup 2 released
date: 2013-08-14T09:00:50+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3252
permalink: /exchange-2010-sp3-rollup-beschikbaar/
categories:
  - Exchange
---
Microsoft has released Exchange 2010 SP3 Rollup 2 yesterday. This rollup will fix the following issues:

  * <div>
      <a href="http://support.microsoft.com/kb/2837926">2837926</a> Error message when you try to activate a passive copy of an Exchange Server 2010 SP3 database: &#8220;File check failed&#8221;
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2841150">2841150</a> Cannot change a distribution group that contains more than 1,800 members by using ECP in OWA in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2851419">2851419</a> Slow performance in some databases after Exchange Server 2010 is running continuously for at least 23 days
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2853899">2853899</a> Only the first page of an S/MIME signed or encrypted message is printed by using OWA in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2854564">2854564</a> Messaging Records Management 2.0 policy can&#8217;t be applied in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2855083">2855083</a> Public Folder contents are not replicated successfully from Exchange Server 2003 or Exchange Server 2007 to Exchange Server 2010
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2859596">2859596</a> Event ID 4999 when you use a disclaimer transport rule in an environment that has Update Rollup 1 for Exchange Server 2010 SP3 installed
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2860037">2860037</a> iOS devices cannot synchronize mailboxes in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2861118">2861118</a> W3wp.exe process for the MSExchangeSyncAppPool application pool crashes in an Exchange Server 2010 SP2 or SP3 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2863310">2863310</a> You cannot send an RTF email message that contains an embedded picture to an external recipient in an Exchange Server 2010 SP3 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2863473">2863473</a> Users cannot access Outlook mailboxes that connect to a Client Access server array in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2866913">2866913</a> Outlook prompts to send a response to an additional update even though the response request is disabled in an Exchange Server 2010 environment
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2870028">2870028</a> EdgeTransport.exe crashes when an email message without a sender address is sent to an Exchange Server 2010 Hub Transport server
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2871758">2871758</a> EdgeTransport.exe process consumes excessive CPU resources on an Exchange Server 2010 Edge Transport server
    </div>

  * <div>
      <a href="http://support.microsoft.com/kb/2873477">2873477</a> All messages are stamped by MRM if a deletion tag in a retention policy is configured in an Exchange Server 2010 environment
    </div>

Especially when you are planning to migrate from Exchange 2010 from Exchange 2003 or Exchange 2007 this rollup is recommended. The rollup fixes an issue which can occur with Public Folder replication between Exchange 2003/2007 and Exchange 2010. Because replicating the public folder content is one of the steps you might see this issue if you won&#8217;t deploy Exchange 2010 SP3 rollup 2.

The second interesting thing in the release notes is a fix for the MsExchangeSyncAppPool which crashes. This issue occurs only when offering ActiveSync services to your end-users and you will use Apple devices. In this case it can happen that the CPU usage on the CAS is high (between 80% and 100%). Users might in this case not be able to sync their mailbox content because throttling is applied. Cause of this issue is the throttling mechanism. Exchange 2010 SP3 Rollup 2 contains a fix for this issue which should prevent this issue from occurring again.

Looking at the third issue you may think what? Slower performance which is experienced by users when their mailbox is hosted in a database which his created after Exchange 2010 SP3. This problem occurs only if the database is online for more then 23 days.

You can download Exchange 2010 SP3 rollup 2via the link below:

[download](http://www.microsoft.com/en-us/download/details.aspx?id=39835 "Exchange 2010 SP3 Rollup 2 download")