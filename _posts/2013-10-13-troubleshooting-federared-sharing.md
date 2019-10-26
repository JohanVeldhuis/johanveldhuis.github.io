---
id: 3286
title: 'Troubleshooting Federated Sharing &#8211; part I'
date: 2013-10-13T20:18:23+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3286
permalink: /troubleshooting-federated-sharing/
categories:
  - Exchange
---
 By using federated sharing it is possible to exchange free/busy informative between different Exchange organizations. This can be done by using the Microsoft Federation Gateway (MSFG) when no direct trust exists between the Active Directories. The MSFG is in this case responsible for providing a ticket which is used for authentication. By using a ticket a CAS can contact the CAS from the other organization to retrieve the free/busy information.

To use this feature several things will need to be configured:

  * trust with the Microsoft Federation Gateway
  * organizational relationship must be configured
  * autodiscover and EWS must allow WS Security authentication
  * the reverse proxy needs to allow unauthenticated traffic to the following url&#8217;s:
  *   * /EWS/exchange.asmx/WSSecurity
      * /autodiscover/autodiscover.svc/WSSecurity
      * /autodiscover/autodiscover.svc

Several sites contain a step-by-step plan on how to configured this. An overview of those sites can be found on the end of this article.

When you setup these things everything should work, indeed should. In most cases it will work but in some cases you will need to perform some troubleshooting. In this serie of blogs we will have a look how you can validate that it works and perform some troubleshooting in case something doesn&#8217;t work.

But how can you troubleshoot these issues? First of all it is very useful if you have a contact person who has access to the other Exchange organization. In most cases this isn&#8217;t a big issue but when using Office 365 or another form of hosting this can be very hard sometimes.

To start the troubleshooting process you mostly would like to verify your own Exchange organization first. Things that could be checked are:

  * verify if autodiscover allows WS Security for authentication
  * verify the external EWS url
  * verify if Exchange Web Services will allow WS Security for authentication

If your Exchange organization contains multiple CAS then Powershell is your friend and you can use several cmdlets to verify the steps above:

_Get-AutodiscoverVirtualDirectory|select server, WSSecurityAuthentication_

[<img alt="Get-AutodiscoverVirtualDirectory" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/10/Get-AutodiscoverVirtualDirectory-300x20.png?resize=300%2C20" width="300" height="20" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/10/Get-AutodiscoverVirtualDirectory.png)

You will get an output like above. Verify if the value of the column _WSSecurityAuthentication _is set to _true_

If WSSecurity is not _true_ then use the following cmdlet to enable it:

_Get-AutodiscoverVirtualDirectory|Set-AutodiscoverVirtualDirectory -WSSecurityAuthentication:$true_

Using this cmdlet the authentication method will be configured but to offer this authentication type you will need to perform an _IISReset_. Additional you can verify if the _svc-integrated_ _handler_ is attached to the autodiscover virtual directory:

[<img alt="IIS" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/10/IIS-300x193.png?resize=300%2C193" width="300" height="193" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/10/IIS.png)

Next step is to verify the Exchange Web Services, this can be done by using the _Get-WebServicesVirtualDirectory_ cmdlet_:_

_Get-WebServicesVirtualDirectory|select server, ExternalUrl, WSSecurityAuthentication_cmdle

[<img alt="Get-WebServicesVirtualDirectory" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/10/Get-WebServicesVirtualDirectory-300x21.png?resize=300%2C21" width="300" height="21" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/10/Get-WebServicesVirtualDirectory.png)

Again the same rule apples _WSSecurityAuthentication _needs to be set to _true_. Besides this the _ExternalUrl_ needs to contains a valid value. This url needs to accessible from the internet. If this is not the case it simply won&#8217;t work.

In case that _WSSecurity_ is not _true_ enabled it by using the following cmdlet:

_Get-WebServicesVirtualDirectory|Set-WebServicesVirtualDirectory -WSSecurityAuthentication:$true_

The same applies for EWS as it did for autodiscover perform an _IISReset_ to activate the authentication method. Besides this verify if the _ws-security handler_ is attached to the EWS virtual directory.

If no external url is configured you will need to configure one. Before you do this make sure the certificate contains all the correct names. If you will configure a value but it is not part of your certificate you will get errors.

To verify if the certificate contains the correct names we will use Powershell again:

_Get-ExchangeCertificate|? {$_.Services -like &#8220;\*IIS\*&#8221;}|select Subject, CertificateDomains|FL_

Verify if the _CertificateDomains_ contain the FQDN you are planning to use for EWS, for example _mail.domain.com_ of _ews.domain.com_. If this name is not on the certificate you will need to renew your certificate.

If the certificate contains the name for the external URL then you can continue configuring it:

_Get-WebServicerVirtualDirectory|Set-WebServicesVirtualDirectory -Externalurl &#8220;https://ews.domain.com/EWS/exchange.asmx&#8221;_

Using the cmdlet above the external URL on all Client Access Servers will be configured the same. REMARK: in some scenarios this is not what you want. Please verify if this is the case in your scenario before configuring the external url.

When this has been configured and validated it is time to verify the Federation Trust and the Organization Relationship.

This can be done by starting with _Test-FederationTrustCertificate_ which will verify if the certificate used for the trust is correct and is installed on all CAS. During the creation of the trust the self-signed certificate will normally be distributed to all CAS in your environment. But in some cases this may not happen. If this is the case the CAS will be unable to authenticate against the Federation Gateway of Microsoft which will eventually result the autodiscover process to fail.

_Test-FederationTrustCertificate_

[<img alt="Test-FederationTrustCertificate" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/10/Test-FederationTrustCertificate-300x60.png?resize=300%2C60" width="300" height="60" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/10/Test-FederationTrustCertificate.png)

Verify that the _State_ column for all CAS contain the value _installed_.

Additionally you can run the _Test-FederationTrust_ cmdlet to verify if the Federation Trust really works. By default this cmdlet will use the _extest_ account:

_Test-FederationTrust_

If you don&#8217;t have an _extest_ account or you would like to use another user add the _UserIdentity_ parameter:

_Test-FederationTrust -UserIdentity user@domain.com_

This cmdlet will perform several tests and will output the results on the screen, verify if no errors did occur.

As final step of the process you can verify the _Organization Relationship_. This is only applicable if the other organization has issues when looking up the free/busy information for your mailboxes. By using an organization relationship you will give the other organization permission to retrieve free/busy information of your organization. If not all domains are listed here it can cause strange issues such as it works for domain A but not for domain B while they are located in the same Exchange environment.

To troubleshoot these kind of issues you can use two cmdlets:

  * _Get-OrganizationRelationShip, _ retrieves the current configuration
  * _GetFederationInformation,_ will send an autodiscover request to the other organization to retrieve the configuration

The following parameters are important in this case:

  * DomainNames
  * TargetApplicationUri
  * TargetAutoDiscoverEpr

One remark must be made about the _DomainNames_ parameter. In some cases this parameter doesn&#8217;t have to be the same for both cmdlets. Some organizations only want to share free/busy information with a specific domain and not all domains hosted by the other Exchange organization.

In this part of the series we did have a look which configuration items you will need to verify in your Exchange organization. Besides this we did had a look on how to fix them if they are configured incorrectly.

In the second part we will have a closer look at the reverse proxy and client part of troubleshooting.

Below are some pages which contain use full information about federated sharing:

Office 365 Community: How to configure TMG for Office 365: [open](http://community.office365.com/en-us/wikis/exchange/1042.aspx)
  
TechNet: How does Federated Calendar sharing work in Exchange 2010?: [open](http://blogs.technet.com/b/ucedsg/archive/2010/04/22/how-does-federated-calendar-sharing-work-in-exchange-2010.aspx)
  
TechNet: Exchange 2013: Sharing: [open](http://technet.microsoft.com/en-us/library/dd638083(v=exchg.150).aspx)