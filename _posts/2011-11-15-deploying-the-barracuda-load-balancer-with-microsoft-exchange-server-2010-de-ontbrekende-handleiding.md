---
id: 2350
title: Deploying the Barracuda Load Balancer with Microsoft Exchange Server 2010 – the missing manual
date: 2011-11-15T20:28:26+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2350
permalink: /deploying-the-barracuda-load-balancer-with-microsoft-exchange-server-2010-de-ontbrekende-handleiding/
categories:
  - Exchange
---
 In a lot of Exchange environments you will see that a hardware load balancer is used to load balance the traffic to the Client Access Servers (CAS) and Hub Transport Servers (HUB).

In this article we will have a look at the Barracuda Load Balancers and specifically the two-armed setup. In this two-armed setup solution the Barracuda has two separate IP-addresses one on the WAN interface and one on the LAN interface.

### System configuration

This is the first pitfall which isn’t mentioned in the whitepaper Barracuda published for Exchange 2010. You will need to place Exchange in a separate VLAN/Subnet for this. Why? If you don’t do it there are a few thinks which don’t work:

  * Servers/applications which connect via RPC won’t be able to connect
  * The **Enable Client Impersonation** option can’t be used for the other protocols: SMTP/IMAP etc.

So for example if your company network contains two VLAN’s create another one which does contain Exchange.

The second thing is the gateway. Once of the requirements for the load balancer in a two-armed configuration is that the network configuration is modified so all traffic outside the subnet will be send to the load balancer.

In normal situations this is not a big issue but in a co-existence phase with for example Exchange 2003 it might be an issue. To solve this issue create a persistent route temporarily and remove it once Exchange 2003 has been removed.

### Rules

The rule part described in the whitepaper will described only the RPC and HTTP(s) part of the load balancer. But as probably a lot of organizations does are not the only two protocols who are used.

Most organizations also will use SMTP and IMAP, and some even POP3. In all cases it might be interesting to load balance those three protocols also.

But let’s start with having a look at HTTP because you can fine tune the parameters of this rule also. As discussed earlier the option **Enable Client Impersonation** is disabled by default. This will make it harder to troubleshoot because every client IP is replaced by the VIP of the Load Balancer. So change this option to enabled to ensure that the real client IP is written to the IIS log.

Both SMTP and IMAP can be published by using the service type **TCP Proxy**. Using this service type you also have the option to **Enable Client Impersonation** just like HTTP, which is published using the **Layer 7 &#8211; HTTPS **service type.

In the whitepaper you will find persistence time and session time-out. Both values are very important to configure correctly. Using values which are too high may cause a service to fail.

So what are the correct values to use? Well there are a few options. Let’s first have a look at the persistence time. Using this parameter we can configure the persistence time of a connection. Persistence is used to ensure a client will setup a connection to the same real server if it connects within the configured persistence time period. If you configure this value to high the following could happen. An application is using SMTP to send messages. The real server used by the client fails. But since the persistence time is not expired the client will be redirected to this server by the load balancer until the time has expired. This results in messages queuing up on the application server.

To prevent this kind of issues either configure no persistence or configure a low persistence time (for example 5 seconds). The first method is recommended.

The second parameter session time-out, how long does a session need to be kept before a connection is closed. In most cases a low value, or even a zero value, is the way to go. This since as long traffic is send across the connection it won’t be terminated.

At the end of this blog a complete overview is displayed which contains all necessary settings for the Exchange rules.

### SSL Offloading

One of the benefits of a load balancer is that you can use it to perform SSL Offloading. Using this feature you can move the encryption and decryption tasks from the Client Access Servers to the hardware load balancer. This has as advantage that the CPU of the Client Access Server will not have to do these tasks which are both CPU intensive.

The SSL Offloading configuration can be split in three parts:

  * Import the certificate
  * Configure the rules
  * Exchange configuration

#### Import the certificate

Importing the certificate on the load balancer is pretty straight forward. Before you start ensure that you’ve got a copy of the certificate including the private key and if applicable the intermediate certificates.

Once you’ve gathered all the stuff you can install it on the load balancer by going to the **certificate** page. On the certificate page provide the following information:

  * Name: an identifier for the certificate
  * Password: the password which is used to secure the certificate
  * Signed certificate: the location of the PFX file

[<img title="Upload SSL certificate" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/10/upload_ssl-300x70.jpg?resize=300%2C70" alt="" width="300" height="70" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/10/upload_ssl.jpg)

Press **Upload** to store the certificate on the load balancer and your ready to continue with the next step.

#### Configure the rules

SSL Offloading can only be performed on the rule that is used to load balance the web services, for example Outlook Web App, Exchange Control Panel, Autodiscover, Exchange Web Services and the Offline Address Book (optional).

Edit the rule which is created for load balancing the web services and go to the **SSL Offloading** section.

[<img title="Assign SSL certificate" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/10/assign_ssl-300x30.jpg?resize=300%2C30" alt="" width="300" height="30" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/10/assign_ssl.jpg)

The load balancer side has now been configured for SSL offloading. Now it’s time for the Exchange side.

#### Exchange configuration

The Exchange configuration part is explained very well on this Wiki page:

<a href="http://social.technet.microsoft.com/wiki/contents/articles/how-to-configure-ssl-offloading-in-exchange-2010.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890" target="_blank">Exchange Wiki Load Balancing</a>

For this reason I won’t explain the steps you will have to take. Although I recommend to use the script below which can also be found on the Wiki page:

_Set-OutlookAnywhere –Identity &#8220;$($env:COMPUTERNAME)\RPC (Default Web Site)&#8221; -SSLOffloading $true__
  
_
  
New-ItemProperty -Path &#8216;HKLM:\SYSTEM\CurrentControlSet\Services\MSExchange OWA&#8217; -Name SSLOffloaded -Value 1 -PropertyType DWORD_ 
  
_
  
Import-Module webadministration_
  
_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/OWA&#8221;__

_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/ECP&#8221;_

_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/OAB&#8221;_

_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/EWS&#8221;_

_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/Microsoft-Server-ActiveSync&#8221;_

_Set-WebConfigurationProperty -Filter //security/access -name sslflags -Value &#8220;None&#8221; -PSPath IIS:\ -Location &#8220;Default Web Site/Autodiscover&#8221;_

_iisreset /noforce___

(source: [http://social.technet.microsoft.com/wiki/contents/articles/how-to-configure-ssl-offloading-in-exchange-2010.aspx](http://social.technet.microsoft.com/wiki/contents/articles/how-to-configure-ssl-offloading-in-exchange-2010.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890))

### Test is everything works

The most important step if everything is configured is test if everything works. But how can you test all the services?

There are multiple options to test these services. All these tests can be run from a client so you don’t have to install the Exchange Management Tools on your machine.

#### Using Outlook

The easiest way is to use Outlook. Perform the following tasks to confirm Outlook can still function correctly:

  * Check if you can connect to your mailbox and if applicable the public folders
  * Force a complete download of the Offline Address Book
  * Check if you can enable/disable Out of Office
  * Check if you can view the free/busy information
  * Use the **Test E-mail Autoconfiguration** to confirm the autodiscover functionality still works

The only two things which can’t be tested using Outlook are Outlook Web App (OWA) and the Exchange Control Panel (ECP) if using Outlook 2007. If you are using Outlook 2010 you can test the ECP by for example going getting the message tracking info of a message.

#### Using Internet Explorer

The other method, although not comparable with Outlook, is using Internet Explorer. Using Internet Explorer you can only test the web services offered by Exchange:

  * Autodiscover: <https://autodiscover.domain.com/autodiscover/autodiscover.xml>
  
    This will give an Invalid Request 600 error
  * Exchange Web Services: <https://mail.domain.com/EWS/Exchange.asmx>
  
    Will give an XML output with several settings
  * Offline Address Book: <https://mail.domain.com/OAB/guid/oab.xml>
  
    Will give an XML output with references to the OAB files
  * Outlook Web App: <https://owa.domain.com/owa>

Will show you the Outlook Web App login page

  * Exchange Control Panel: <https://owa.domain.com/ecp>

Will show you the Exchange Control panel login

#### Using the Exchange Management Shell

As final option you could test it using the Exchange Management Shell. One important remark has to be made. You can’t perform the test cmdlet’s anymore from the servers this because the traffic won’t be accepted because it will create a loop in your network.

So to test the services you will need to perform them from a client which contains the Exchange Management Tools.

The following cmdlets can be used:

  * Autodiscover: **Test-OutlookWebServices**
  * Exchange Web Services: **Test-WebServicesConnectivity**
  * Exchange Control Panel connectivity: **Test-EcpConnectivity**
  * Outlook Web Apps: **Test-OwaConnectivity**
  * Test RPC connection: **Test-OutlookConnectivity**

Here ends the article about how to use the Barracuda Load Balancer in combination with Exchange 2010. As promised earlier below you will find the rules which you need to configure in the load balancer:

**RPC**

[table id=24 /]

[table id=25 /]

**Web** **Services**

[table id=32 /]

[table id=33 /]

**SMTP**

[table id=26 /]

[table id=27 /]

**IMAP**

[table id=28 /]

[table id=29 /]

**POP3**

[table id=30 /]

[table id=31 /]

Special thanks to GianPaolo Corona for providing the screenshots and assisting in getting this configuration working.

If you have some other config suggestions don&#8217;t hesitate to contact me.