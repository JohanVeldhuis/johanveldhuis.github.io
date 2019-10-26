---
id: 2418
title: 'Exchange Federation &#8211; part I'
date: 2012-03-17T12:33:57+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2418
permalink: /exchange-federation-part-i/
categories:
  - Exchange
---
Since Exchange 2003 it&#8217;s possible to setup a federation between Exchange organizations. Compared to older Exchange versions configuring a federation between two organizations became quiet easy in Exchange 2010.
  
Although you might encounter some issues while configuring the federation.

In this series of blog articles we will have a look at several issues and will look how to troubleshoot these issues.

But to solve an issue it&#8217;s important to understand the concept. There for we will start with an explanation of how federation and how to configure it.
  
To build a federation between two companies two things will need to be configured:

  * Federation Trust;
  * Organization Relationship;

**Federation trust**
  
Before creating the Organization Relationship we will first need to configure a Federation Trust. This Federation Trust will be setup between the Exchange 2010 on-premises environment and the Microsoft Federation Gateway (MFG).

The MFG is the component in the federation setup which is responsible for authentication and providing authentication tickets. In this case the MFG is also known as the trust broker. The on-premises Exchange environment uses a certificate to authenticate itself to the MFG. The MFG is available in two sorts:

  * Business instance, used by Exchange 2010 SP1 and Microsoft Online Services;
  * Consumer instance, used by Exchange 2010 RTM, organizations who decide to use a 3rd party certificate and <Live@edu>;

Microsoft recommends to ensure that both organizations are using the same MFG.
  
Before you configure a federation trust it&#8217;s important to know if you will use federated delegation.
  
Using federated delegation it&#8217;s possible to share information between users in both environments. To use this functionality one of the requirements is that you will create a subdomain which is used for federated delegation. This subdomain may not be the same as the primary SMTP domain which is being used. This subdomain must be set as Organization Identifier. Microsoft recommends to create a subdomain called exchangedelegation.domain.com for this purpose. The MFG will use this subdomain to assign a unique identity to every user. This identity will be used to get a Security Assertions Markup Language (SAML) delegation token. Using this token users can authenticate themselves to the other Exchange organization.

Configuring a Federation Trust can be divided in the following steps:

  1. Create a Federation Trust;
  2. Retrieve the Domain Proof;
  3. Create DNS TXT record;
  4. Configure the Organization Identifier and additional domains for Federation;

The first step can be performed by using the Exchange Management Console (EMC) or Exchange Management Shell (EMS). Keep in mind that when you want to use a 3rd party certificate you can only create the Federation Trust using the EMS.

**Federation Trust**

_**EMC**_
  
The method below will create a trust with the MFG and creates a self-signed certificate for authentication:

  * Open the _EMC_;
  * Select the _Organization Configuration_;
  * Select the option _New Federation Trust_;
  * Click the option _New_;
  * Click _Finish_ to close the wizard;

**_EMS_
  
** 

```PowerShell  
Get-ExchangeCertificate | ?{$_.friendlyname -eq 'Exchange Federated Delegation'} | New-FederationTrust -Name 'Microsoft Federation Gateway'
```

**Domain Proof
  
** When the trust has been created we will need to retrieve the domain proof. The domain proof must be used to create a TXT record in the DNS. Using the domain proof a check will be performed if your really the owner of the domain.
  
The domain proof can only be gathered by using the EMS:

```PowerShell
Get-FederatedDomainProof –DomainName domain.com
```

Keep in mind that if you are going to use Federated Delegation you will need to perform this step for both the subdomain and the mail domains.
  
**Add domains to the Federated Trust**
  
When both the trust and domein proofs are created we can continue by adding the domains to the Federated Trust.
  
Before you can perform this step you will need to add the subdomain to the accepted domains of Exchange:

```PowerShell
New-AcceptedDomain -DomainName exchangedelegation.domain.com __-Name FederationDomain
```

When the cmdlet above has been executed we can configure the federation trust. This will need to be performed in two steps:

```PowerShell
Set-FederatedOrganizationIdentifier -DelegationFederationTrust 'Microsoft Federation Gateway' -AccountNamespace exchangedelegation.domain.com -Enabled $True
```

Using the cmdlet above we will configure the trust to use the subdomain as the organization identifier. The organization identifier is being used for authentication. During this process a check will be performed if the TXT records can be found in the DNS. If the record can be found the configuration will be updated.
  
To finalize the federation trust configuration you will need to add all the other domains to the trust. This can be done by using the Add-FederatedDomain cmdlet. Just like the previous cmdlet a check is being performed for the TXT record.

```PowerShell
Add-FederatedDomain -DomainName domain.com
```
  
Using this step the configuration of the Federation Trust has been completed.

Optionally you can also use the EMC to perform these steps. The advantage of this is that you can perform both steps via the same wizard.
  
****

**Create an Organization Relationship**
  
To share the free/busy information between the organizations its necessary to create an Organization Relationship.
  
Creating an Organization Relationship can be performed by using either the EMC or the EMS.

_**EMC**_

  * Open te EMC;
  * Select te _Organization Configuration_;
  * Select the option _New Orginization Relationship_;
  * Configure the name of the other organization on the _Introduction_ page, activate the Organization Relationship and soecify which information you want to make available to the other organization. Optionally you can assign a security group which let&#8217;s you only share the information of the members of the group;
  * On the _External Organization_ page either chose to manually or automatically configure the relationship. When chosing for the automatic way autodiscover will be used. If things change at the organization side you won&#8217;t have to change it manually.
  
    If selecting the manual method you will need to provide the following information:
  
    o _Federated domains_ of external Exchange organization: add both exchangedelegation.domain.com and domain.com;
  
    o _Application URI_ of the external Exchange organization: exchangedelegation.domain.com, this information will be used to request a  delegated token;
  
    o Autodiscover endpoint of external Exchange organization, this url will be used to retrieve the url&#8217;s of the CAS Server. This because the Free/Busy info will be retrieved by using EWS. The url will look like this:
  
    <https://autodiscover.domain.com/autodiscover/autodisover.svc/wssecurity>;
  * On the _New Organization Relationship_ page verify the configuration and press _New_ to create the Organization Relationshop.

_**EMS**_
  
```PowerShell
New-OrganizationRelationship -Name 'External Company' -DomainNames 'exchangedelegation.domain.com','domain.com' -FreeBusyAccessEnabled $true
  
-FreeBusyAccessLevel LimitedDetails -TargetAutodiscoverEpr 'https://autodiscover.domain.com/autodiscover/autodiscover.svc/wssecurity' -TargetApplicationUri &'exchangedelegation.domain.com'
```

In the example above we will configure the Organization Relationship manually. Autodiscover will be used to retrieve the EWS url&#8217;s.  If you would like to retrieve the _Domainnames, TargetAutodiscoverExpr_ and _TargetApplicationUri_ automatically you will need to create the Organization Relationship like this:

```PowerShell
Get-FederationInformation -DomainName domain.com | New-OrganizationRelationship -Name 'External Company' -FreeBusyAccessEnabled $true -FreeBusyAccessLevel -LimitedDetails
```

In the example above we will first retrieve the Federation Information of the domain. Next we will use the output of the _Get-FederationInformation_ to create the Organization Relationship.

**Clients
  
** To use the features offered by the Organization Relationship you will need to use one of the following clients:

  * Outlook 2010
  * Outlook Web App/Outlook Web Access
  * Outlook 2007

When using Outlook 2007 there&#8217;s one thing you should keep in mind. Typing in the SMTP address, just like in Outlook 2010/OWA, doesn&#8217;t work with Outlook 2007.  If Outlook 2007 is the only Outlook version which is in use you will need to add all users from the other organization as contacts so they will appear in the Global Address List.

**What happens when free/busy information is retrieved?**
  
But what happens when a user request free/busy information of a user in another organization?

In the workflow below a complete overview of the process:

[<img title="Federation free/busy workflow" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2012/03/Federation-free-busy-300x240.jpg?resize=300%2C240" alt="" width="300" height="240" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2012/03/Federation-free-busy.jpg)

  1. User provides a SMTP adress of another user in another organization;
  2. The CAS Server checks if Federation is configured;
  3. The CAS Server send a token request to the Microsoft Federation Gateway;
  4. The Microsoft Federation Gateway verifies if the source organization is trusted by the target organization;
  5. The Microsoft Federation Gateway sends a token back to the CAS Server which requested the token. The token is signed and encrypted with the public key of the target organization;
  6. The CAS Server sends the free/busy request to the CAS Server of the target organization;
  7. The Target CAS Server receives the token;
  8. The Target CAS Sever verifies if the organization which sends the request is in the trust list;
  9. The Target CAS Server checks which free/busy information may be displayed;
 10. The Availability Service requests the information from the mailbox;
 11. The answer is send back to the client;

Here ends the first part of how Federations can be used in Exchange 2010. In the next part we will have a look at how you can safely publish it to the internet and will start with some troubleshooting.

Technet &#8211; Understanding Federation [open](http://technet.microsoft.com/en-us/library/dd335047.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890)

Technet &#8211; Creating a Federation Trust [open](http://technet.microsoft.com/en-us/library/dd335198.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890)