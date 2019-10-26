---
id: 3338
title: Relinquishing job because the mailbox is locked
date: 2013-12-20T20:46:32+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3338
permalink: /relinquishing-job-mailbox-locked/
categories:
  - Office 365
---
During a migration to Office 365 I had this issue. The migration of a mailbox was stalled several times with the following entry logged in the migration log _Relinquishing job because the mailbox is locked_. Sometimes this occurs only once but I have seen times that the mailbox will get stuck in this phase.

_12/20/2013 9:24:08 AM [DB4PR04MB459] The Microsoft Exchange Mailbox Replication service &#8216;DB4PR04MB459.eurprd04.prod.outlook.com&#8217; (15.0.842.8 caps:01FF) is examining the request._ _12/20/2013 9:24:09 AM [DB4PR04MB459] Connected to target mailbox &#8216;Primary (4ca8eac9-f378-4e82-8d07-f984c64176e8)&#8217;, database &#8216;EURPR04DG029-db041&#8217;, Mailbox server &#8216;DB4PR04MB459.eurprd04.prod.outlook.com&#8217; Version 15.0 (Build 842.0)._ _12/20/2013 9:24:09 AM [DB4PR04MB459] Connected to target mailbox &#8216;Archive (07121074-d871-4db9-9f4e-153010131a50)&#8217;, database &#8216;EURPR04DG029-db041&#8217;, Mailbox server &#8216;DB4PR04MB459.eurprd04.prod.outlook.com&#8217; Version 15.0 (Build 842.0)._ _12/20/2013 9:24:14 AM [DB4PR04MB459] Connected to source mailbox &#8216;Primary (4ca8eac9-f378-4e82-8d07-f984c64176e8)&#8217;, database &#8216;MB_Others&#8217;, Mailbox server &#8216;CAS02.corp.local&#8217; Version 14.3 (Build 158.0), proxy server &#8216;CAS01.corp.local&#8217; 14.3.151.0 caps:05FFFF._ _12/20/2013 9:24:15 AM [DB4PR04MB459] Connected to source mailbox &#8216;Archive (07121074-d871-4db9-9f4e-153010131a50)&#8217;, database &#8216;MB\_Archives\_Large&#8217;, Mailbox server &#8216;CAS02.corp.local&#8217; Version 14.3 (Build 158.0), proxy server &#8216;CAS01.corp.local&#8217; 14.3.151.0 caps:05FFFF._ _12/20/2013 9:24:15 AM [DB4PR04MB459] Relinquishing job because the mailbox is locked. The job will attempt to continue again after 12/20/2013 9:29:15 AM._

When searching in Googl you will see several tips but most of them will point to TMG or a Firewall which will block the large amount of requests Office 365 sends because it thinks it&#8217;s unsafe. Microsoft has published a Knowledge Base article about this which you can find [here](http://support.microsoft.com/kb/2654376).

The solution Microsoft offers is raising the value of the _Custom Limit in the_ _Flood Mitigation Settings._ Microsoft will tell you to raise this number to a higher value but it depends on the amount of mailboxes how high you will configure this value.

[<img alt="TMG Flood Migration settings" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/12/2654412-294x300.jpg?resize=294%2C300" width="294" height="300" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/12/2654412.jpg)

Of course this is a nice solution but it might require the modification of the value multiple times. Despite this value will be applied to all IP addresses including those from evil users. There must be a nicer solution. A more suitable solution is to not apply the Flood mitigation settings to the IP addresses of Office 365.

To configure this it is recommended to create a computer group which contains the separate IP addresses and subnets which are being used by Office 365. In the image below you can see an example.

[<img alt="Floot Mitigation - IP Exceptions" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/12/Floot-Mitigation-IP-Exceptions-300x150.png?resize=300%2C150" width="300" height="150" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/12/Floot-Mitigation-IP-Exceptions.png)

For a complete overview of the IP addresses used by Office 365 you van visit the following pages:

[Exchange Online Protection IP addresses](http://technet.microsoft.com/en-us/library/dn163583(v=exchg.150).aspx)
  
[Office 365 URLs and IP address ranges](http://onlinehelp.microsoft.com/en-us/office365-enterprises/hh373144.aspx)

It is recommended to visit both pages and add the IP&#8217;s and subnets to the computer group. Once the group is created add the group to the _IP Exceptions_ tab. Once the configuration has been activated in TMG you wille see that the migrations will continue and will not stop anymore. This last benefit has another benefit the migration of a mailbox will be completed faster.