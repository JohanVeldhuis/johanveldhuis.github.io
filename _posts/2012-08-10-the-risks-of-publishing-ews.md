---
id: 2509
title: The risks of publishing EWS
date: 2012-08-10T05:49:02+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2509
permalink: /the-risks-of-publishing-ews/
categories:
  - Exchange
---
**<span style="color: #ff0000;">update 4-3: changed a parameter because it was incorrect</span>**

Starting from Exchange 2007 several functionalities are offered via web services also known as Exchange Web Services (EWS). Functionalities offered by EWS are for example free/busy and Out Of Office.

Several clients can benefit from EWS among them Outlook 2007 and higher, Entourage with EWS extension and Outlook 2011. The last two clients are only available for Mac and don’t use MAPI to send/receive e-mail but do use EWS to do this. Another Mac related product is Apple Mail which works the same as Entourage and Outlook 2011.

On your local network this will not be the issue in most cases but if you are publishing your Exchange environment to the internet you might see some unwanted traffic. The reason why? Well if you are publishing EWS with the default authentication methods users can login using their username and password. Let’s give a short example:

_Your company only wants to allow users to use ActiveSync and OWA for e-mail access. Outlook Anywhere is not enabled since you only allow full Outlook access when users are connected via VPN._

Now comes the fun when using Entourage, Outlook 2011 or Apple Mail your users will be able to send/receive their mail. This because they are using EWS and EWS is published either directly or more secure via a reverse proxy. This because you can use to reverse proxy to prevent the publishing of EWS. Although this may not be an option as we will see later in this blog.

How to solve this? Well it depends if you are not having Entourage and Outlook 2011 client on your local network you can choose to block both clients.

To configure this on your Exchange server run the following cmdlet:

_Set-OrganizationConfig –EWSAllowEntourage $false –EWSAllowMacOutlook $false –EWSAllowApplicationAccessPolicy: EnforceAllowList_

Let’s explain the parameters used:

  * EWSAllowEntourage: specifies if Entourage is allowed or not
  * EWSAllowMacOutlook: specifies if Outlook 2011  is allowed or not
  * EWSAllowApplicationAccessPolicy: specifies if other applications are allowed to use EWS by using either allow (EnForceAllowList) or block (EnForceBlockList) specific applications/services

The last parameter is a little bit tricky since this will also block other applications/services that want to use EWS. This due to the fact that we not used the AllowList parameter.  A few examples of these applications/services are: OCS/Lync clients and BlackBerry Server.

To allow those applications we will need to find out which client is trying to connect EWS does use the user agent string. The user string can be found by searching in the IIS log for example:

_2012-08-03 12:07:40 192.168.1.2 POST /EWS/Exchange.asmx &#8211; 443 – 192.168.1.10 Microsoft+Office/12.0+(Windows+NT+5.1;+Microsoft+Office+Outlook+12.0.6425;+Pro)_

_2012-08-03 00:03:14 192.168.1.2 GET /autodiscover/autodiscover.xml &#8211; 443– 192.168.1.10 OC/4.0.7577.4051+(Microsoft+Lync+2010) 200 0 0 0_

Below a list of user agent strings used by some popular programs:

  * BlackBerry Servers: Mozilla/4.0+
  * Microsoft OCS 2007 R2: OC/3.5.\*.\*
  * Microsoft Lync 2010: OC/4.\*.\*.*
  * Microsoft Lync Web App: CWA/4.\*.\*.*
  * Microsoft Lync Phone Edition: OCPhone/4.\*.\*.*

Let&#8217;s change the earlier scenario a little bit:

__Your company only wants to allow users to use ActiveSync and OWA for e-mail access. Outlook Anywhere is not enabled since you only allow full Outlook access when users are connected via VPN._ The company decides to implement Microsoft Lync 2010 and wants to use all options including the Outlook integration options. Lync is allowed to be used without setting up a VPN connection._

&nbsp;

In this case we will need to exclude the Lync 2010 client from being blocked if it tries to use EWS:

_Set-OrganizationConfig –EWSAllowEntourage $false –EWSAllowMacOutlook $false –EWSApplicationAccessPolicy: EnforceAllowList –AllowList {“\*OC\*”}_

By using the above cmdlet we will only allow the OCS 2007 R2 and Lync 2010 client to use the EWS functionality.

Another way to block the EWS access is using your F5 appliance, if you have one of course. A good description on how to configure your F5 to support this can be found [here](http://www.confusedamused.com/notebook/publishing-exchange-web-services-remotely-only-for-lync/) written by fellow MVP Tom Pacyk.