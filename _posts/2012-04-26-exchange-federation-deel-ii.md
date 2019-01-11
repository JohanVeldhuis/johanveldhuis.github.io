---
id: 2438
title: 'Exchange Federation &#8211; part II'
date: 2012-04-26T20:17:58+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2438
permalink: /exchange-federation-deel-ii/
categories:
  - Exchange
---
**Exchange Federation**

In the first part of the article we did had a look at how Exchange Federation Works. After that we had a look at how to configure a Federation Trust and Organizational Configuration.

In this part of the article we will continue with configuring the federation. Most Exchange CAS Servers are placed behind a firewall and in most cases a reverse proxy is placed in front of it too.

**Reverse proxy configuration**

You can for example use the Threat Management Gateway of Microsoft.  We will assume that the default rules for publishing the Web Services are already configured. The authentication is performed by the TMG instead of the CAS Servers. In most cases Form Based Authentication, Basic or NTLM/Kerberos is used for authentication

The authentication methods can’t be used for the Federation Trust and Organizational Configuration. Because the credentials of a user will be verified by the Microsoft Federation Gateway (MFG) and not by a domain controller.

Because this authentication type is not permitted by the TMG for the several sites the traffic will be blocked. This can be solved by creating separate rules in the TMG for the following sites:

  * /EWS/Exchange.asmx/wssecurity
  * /Autodiscover/Autodiscover.svc
  * /Autodiscover/Autodiscover.svc/wssecurity

The TMG will need to passthrough the traffic  directly to the CAS Server instead of authenticating.

**Troubleshooting cmdlet’s**

Such as with most things configuring a Federation Trust and Organizational Configurational will not work smoothly always. For example you may think it works but when testing it you will get an error.

Exchange 2010 SP1 contains several test cmdlets to verify the functionality:

  * Get-FederationOrganizationIdentifier
  * Get-FederationInformation
  * Get-FederationTrust
  * Get-OrganizationRelationship
  * Test-OrganizationRelationship
  * Test-FederationTrust

_Get-FederationOrganizationIdentifier_

With this cmdlet we will retrieve the following information:

  * Who is the organization identifier for the Exchange organisatie;
  * What are the additional domains which are configured for federation;
  * Who is the contact for the trust;
  * Is the domain proof TXT validated by the MFG

_Get-FederationInformation:_

This cmdlet can be used after a configuration trust has been configured. The cmdlet will retrieve the following information:

  * Federated domain names;
  * Target URLs of the external Exchange organisation;

Example:

_Get-FederationInformation –DomainName domain.com_

_Get-FederationTrust:_

Using this cmdlet an overview will be displayed of the configured federation trust of the organization. The following information will be used when the _|FL_ parameter is used:

  * ApplicationIdentifier;
  * ApplicationUri attributes;
  * Certificaat details;
  * Token details;

_Get-OrganizationRelationship:_

Using this cmdlet the settings for the configured organization relationship will be displayed. Information which is being displayed by using this cmdlet:

Example:

_Get-OrganizationRelationShop –Identity TrustedDomain_

_Test-OrganizationRelationship_

Using this cmdlet you can test the organization relationshop is configured correctly and i fit Works. This cmdlet needs to be run i.c.w. a valid useraccount.

Voorbeeld:

_Test-OrganizationRelationship –UserIdentity_ [_johan@domain.com_](mailto:johan@domain.com) _–Identity domain.com –Confirm_

The _UserIdentity_ parameter is the account for which a security token will be requested. The _Identity_ is the name of the organization relationship which needs to be tested.

_Test-FederationTrust_

Performs several tests to validate that the federation trust works correctly. The following tests will be performed:

  * Can a connection be made to the MFG;
  * Are the certificates valid;
  * Can a security token be requested from the MFG.

Example:

_Test-FederationTrust –UserIdentity_ [_johan@domain.com_](mailto:johan@domain.com)__

In the example above the useraccount will be specified as the _UserIdentity._ When no UserIdentity is specified the default test mailbox will be used. The default test mailbox can be created by using the _New-TestCasConnectivityUser.ps1_ script.

**Troubleshooting**

**_Certificates_**

One of the issues you will propably not see many times is an invalid certificate. This can be caused because the certificate is not valid anymore because the certificate is expired.

But it may also occur when you try to request a new certificate. It sounds a bit strange but I did had this issue one. The MFG’s are placed in the GMT timezone. When the Exchange environment is located in another timezone it can occur that the certificate will be generated in the future from MFG perspective. The solution for this issue is wait. In the case of GMT+1 you will have to wait one hour and then try it again

**_Incorrect external URL for EWS_**

Because federation is depending on the Exchagne Web Services it is important that the correct external URL’s are configured. When this is not the case the EWS url will not be available and so no free/busy information will be displayed.

To solve this issue you will need to configure the external URL by using the Exchange Management Shell:

_Set-WebServicesVirtualDirectory -Identity Server\EWS* -ExternalUrl_ [_https://mail.domain.com/EWS/exchange.asmx_](https://mail.domain.com/EWS/exchange.asmx)__

Besides this it’s important that the URL is published correctly by the reverse proxy.

**_Changes are not active_** **_immediately_**

In case a change is made in the federation it might not be effective immediately. This is caused by the fact that caching is used which will result in the old configuration to be used till the cache expires.

For a federation between two Exchange 2010 environments or an Exchange 2010 and Office 365 this can take up to 7 hours.

**_Autodiscover doesn’t work_**

Although the autodiscover functionality is not required for configuring the federation it is important to let the federation work eventually. Verify the autodiscover service url is accessible on the lan but also from the internet. If autodiscover doesn’t work correctly this will cause that the other Exchange 2010 environment can’t resolve the necessary information.

Here ends the second part and last part of the Exchange Federation series. If you&#8217;ve got any questions about it don&#8217;t hesitate to contact me.