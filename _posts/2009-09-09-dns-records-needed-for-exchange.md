---
id: 1312
title: DNS records needed for Exchange
date: 2009-09-09T21:32:00+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1312
permalink: /dns-records-needed-for-exchange/
categories:
  - Exchange
---
DNS records and Exchange, it&#8217;s not really hard but it&#8217;s very important to configure them correctly. Incorrect DNS records and especially pointer records can cause issues with mail delivery.

Which records are needed to send and receive mail with Exchange:

**A-record**, this record ensures that a namecan be translated to an ip-address, for example mail.domain.com
  
**PTR-record,** this record is used for reverse lookup. By performing a query for the IP-address and then check if this leads to the FQDN of the mailserver a cross check is done if the mailserver is really who he claims to be.
  
**MX-record**, you can have multiple records of this type. Each entry is a mailserver where mail can be delivered to. Each rule has a priority, depending on the priority the message will be delivered to a mailserver. For example: if you have 2 records one with a priority of 10 and another with a priority of 99. The sending mailserver will first try to deliver the mail to the server with the priority of 10 if that one doesn&#8217;t react it will deliver the mail to the mailserver with priority 99.
  
**SPF-record**, this type of record is optional. This record contains all FQDN&#8217;s/ip-addresses of servers who may send mail with your domain as sending domain. This can be used by the receiving mailserver to check if the mailserver who sends the e-mail if allowed to send mail from that specific domain.

Besides the DNS-records for sending and receiving DNS records are also used for autodiscover:

**A-record,** this record ensures just like the A-record for sending and receiving that the name will be translated to an ip-address, in the case of autodiscover this needs to be the following syntax: autodiscover.domain.com
  
**SRV-record**, this record can beused instead of the A-record to let Outlook 2007 users use the autodiscover service. This record contains external FQDN of the CAS-serve which the user usages to connect to Exchange. If you want to use this type of record ensure that any other A or CNAME record used for autodfiscover is removed.

For this kind of stuff there are enough tools, below a short overview of tools I use often:

EmailTalk, site with several tools: ptr, mx or spf record check  <a href="http://www.emailtalk.org/PTR.aspx" target="_blank">open</a>
  
MXtoolbox, site with several tools: mx record check, RBL check and test your mailserver from outside <a href="http://www.mxtoolbox.com/" target="_blank">open</a>
  
Microsoft SPF Record Wizard, site which helps to create a SPF record <a href="http://www.microsoft.com/mscorp/safety/content/technologies/senderid/wizard/" target="_blank">open</a>