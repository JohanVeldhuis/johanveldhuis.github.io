---
id: 2442
title: How to deal with a proxy server in an Exchange 2010 environment
date: 2012-05-13T20:49:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2442
permalink: /how-to-deal-with-a-proxy-server-in-an-exchange-2010-environment/
categories:
  - Exchange
---
In this blog we will have a look at what the impact of a proxy server in your Exchange 2010 environment. The article is split up in two parts. This since we will also have a look at the client part and what the impact of a proxy server for it.

In the environment we will assume that http and https access is only allowed via the proxy server for both servers and clients.

Let’s start with the server side from the Exchange environment and which impact a proxy server has on it. Before doing this we will need to know which features of Exchange will use http/https to perform specific tasks.

Exchange will use http/https for the following tasks:

  * Downloading updates for the anti-spam update service
  * Downloading updates for Microsoft Forefront Protection for Exchange Server
  * Certificate Revocation Lists (CRL) validation
  * Hybrid environments to connect to Windows Live/Office 365
  * Environments which are using the hosted archive solution
  * Several cmdlets such as _Get-FederationInformation_ and _Test-WebServicesConnectivity_

To solve this you can configure WinHTTP using the Netsh tool which is part of Windows Server since 2003. The tool can be found in the system32 folder.

To configure WinHTTP we first need to navigate to the WinHTTP context:

```Console
netsh
  
 netsh>winhttp
  
 netsh winhttp>
 ```

First thing you may want to check is if there is a proxy configured already. This can be done by using the following cmdlet:

```Console
show proxy
```

There are several ways you can configure WinHTTP using NetSh. For example if you already configured the proxy settings in IE you can use these as the source:

```Console
set proxy source=ie
```

But if you don’t want to configure the proxy in IE you can provide the configuration by using the following parameters:

  * proxy-server: FQDN or ip-address of the proxy including the portnumber
  * bypass-list: a list of hosts which can bypass the proxy

The steps for Windows 2003/2008 and 2008R2 are not the same so let’s have a look at both of them:

```Console
set proxy-server=proxy:8080 bypass-list =”*.local”

set proxy proxy-server=proxy:8080 bypass-list =”*.local”
```

You may ask yourself why use the bypass-list parameter? Well it is recommended to configure the local domain as bypass-list. This since both the EMC and EMS use the http protocol. If not configuring this it may have as result that you can’t connect to your Exchange Server by using the EMC/EMS.

Now we finished the server side let’s have a look at the client side. As you may know Exchange offers several services via http/https since Exchange 2007. Outlook 2007 clients and newer versions can benefit from these services.

The following services are offered by Exchange to the Outlook client via http/https:

  * autodiscover (default https): for automatic configuration
  * Exchange Control Panel (default https): for mail tracking (only Outlook 2010)
  * Exchange Web Services (default https): for example: calendar sharing, Free/busy , Out Of Office and MailTips
  * Offline Address Book (OAB) (default http): for downloading the OAB files

By default Outlook will use the proxy settings configured in Internet Explorer. So it’s really important to configure the proxy settings and specifically the proxy exclusions to prevent issues.

If you forgot to exclude the url’s by Exchange then you might get this kind of errors:

[<img title="Out Of Office fout" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/05/oof-300x58.jpg?resize=300%2C58" alt="" width="300" height="58" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/05/oof.jpg)

In the example above the user tries to enable his/her out of office. But since the EWS url is not excluded it can’t check the current status and displays this error.

So which url’s need to be excluded in the proxy list? A list is displayed below:

  * Autodiscover url
  * ECP url
  * EWS url
  * OAB url

Which internal url’s your Exchange environment is currently using can be found out by using the following cmdlets:

**Autodiscover url:**

```PowerShell
Get-ClientAccessServer |select AutoDiscoverServiceInternalUri
```

**ECP url:**

```PowerShell
Get-EcpVirtualDirectory |select InternalUrl
```

**EWS url:**

```PowerShell
Get-WebServicesVirtualDirectory | select InternalUrl
```

**OAB url:**

```PowerShell
Get-OabVitualDirectory | select InternalUrl
```

Optionally you may also want to add the Outlook Web App (OWA) url if you would like to offer webmail on the local network. In that case run the following cmdlet to see which OWA internal url is configured:

```PowerShell
Get-OwaVitualDirectory | select InternalUrl
```

Here ends the blog about a proxy server in an Exchange 2010 environment. Hope you liked the blog if you have any questions don&#8217;t hesitate to contact me.