---
id: 1723
title: Autodiscover in a multiforest environment
date: 2009-11-30T22:32:08+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1723
permalink: /autodiscover-in-a-multiforest-environment/
categories:
  - Exchange
---
Autodiscover, a really nice feature of Exchange but it can cause headaches. When implementing it in a multiforest environment you will have to take care of some extra things. In this tutorial I will explain which steps are needed and will let you see what goes wrong when it is not configured correctly.

Below a forest overview of the forests in my test environment:

<a title="Multiforest" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/multiforest.jpg"><img class="alignnone size-thumbnail wp-image-1684" title="multiforest environment" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/multiforest-150x150.jpg" alt="multiforest environment" width="150" height="150" /></a>

In this environment the following forests have been created:
<ul>
	<li><em>demo.local</em>, the user forest. In this forests all user accounts will be created, this forest will contain a domaincontroller.</li>
	<li><em>exchange.local, </em>one of the Exchange resource forests. This forest contains an Exchange server with the HUB, CAS and mailbox role installed, besides this it's the domaincontroller for this forest.</li>
	<li><em>company.local, </em>the other Exchange resource forest. This forest also contains an Exchange server with the HUB, CAS and mailbox role installed and also will function as a domaincontroller for this forest.</li>
</ul>
OK now what do we want to achieve. The useraccounts will be created in the demo.local forest. All users will be placed in seperate OU's per Exchange resource forest. The next step will be to create the linked mailboxes in the resource forests. These forests will contain user accounts but all accounts will be disabled. Users will login to the demo.local domain and will configure their Outlook using autodiscover.

The steps to install a domain controller and install Exchange will be skipped, and I will assume that you have 3 forests containing the earlier mentioned servers including the domain controller and Exchange roles.

First we will create the trust between the forests. Before we can setup the trust we need to ensure that DNS records can be resolved correctly. This can be done by creating a forwarder to the DNS server responsible for the domain. So the DNS server in the user forest will contain a forwarder to the DNS server in the resource forest and vice versa.

Next step is to create the trust, this can be done via <em>netdom </em>command:

```Console
Netdom trust trusted_domain_name /domain: trusting_domain_name /verify
```

Or via Active Directory Domains and Trusts, this can be done via the wizard:

<a title="Create trust" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_1.jpg">
<img class="alignnone size-thumbnail wp-image-1685" title="Create trust" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_1-150x150.jpg" alt="Create trust" width="150" height="150" /></a>

Specify the name of the user forest.

<a title="Forest trust" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_2.jpg">
<img class="alignnone size-thumbnail wp-image-1686" title="Forest trust" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_2-150x150.jpg" alt="Forest trust" width="150" height="150" /></a>

In the next step you will specify the type of trust you want to create, in this case a forest trust.

<a title="Outgoing trust" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_3.jpg">
<img class="alignnone size-thumbnail wp-image-1687" title="Outgoing trust" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_3-150x150.jpg" alt="Outgoing trust" width="150" height="150" /></a>

Then we will define that the trust only needs to be an outgoing trust, this because users from the user forest only need to authenticate in the resource forest and not vice versa.

<a title="Create trust" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_4.jpg"><img class="alignnone size-thumbnail wp-image-1688" title="Create trust" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_4-150x150.jpg" alt="Create trust" width="150" height="150" /></a>

As an option you can also arrange that the trust will be created in both forests, for this you will need to specify an account with enough permissions.

<a title="Authenticated user" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_5.jpg"><img class="alignnone size-thumbnail wp-image-1689" title="Authenticate user" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_5-150x150.jpg" alt="Authenticate user" width="150" height="150" /></a>

Once specified click on <em>next</em>

<a title="Forest-wide authentication" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_6.jpg"><img class="alignnone size-thumbnail wp-image-1690" title="Forest-wide authentication" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_6-150x150.jpg" alt="Forest-wide authentication" width="150" height="150" /></a>

One of the lasts steps is choosing between forest-wide or selective authentication. With this we can configure if the complete forest gets access to the resource forest of that this will need to be configured per user.

After a short overview you must click on <em>next </em>to create the trust and the following screen will be displayed.

<a title="Trust created" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_7.jpg"><img class="alignnone size-thumbnail wp-image-1691" title="Trust created" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_7-150x150.jpg" alt="Trust created" width="150" height="150" /></a>

If you like you can perform an extra check.

<a title="Trust validation" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_8.jpg"><img class="alignnone size-thumbnail wp-image-1692" title="Trust validation" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_8-150x150.jpg" alt="Trust validation" width="150" height="150" /></a>

After the test is performed the test results will be displayed.

<a title="Results check" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_9.jpg"><img class="alignnone size-thumbnail wp-image-1693" title="Results check" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/trust_9-150x150.jpg" alt="Results check" width="150" height="150" /></a>

Before we will continue with the next steps we need to create the user in the user forest. This can be done via Active Directory Users &amp; Computers and can be a standard user. When the user is created we can create the linked mailbox, for this we need to open the Exchange Management Console or Exchange Management Shell.

For creating the linked mailbox via a commandline execute the following command:

```PowerShell
New-Mailbox -Database "Mailbox Database" -Name "Demo User" -LinkedDomainController "dc.demo.local" -LinkedMasterAccount demo\demouser -OrganizationalUnit Exchange\Users -UserPrincipalName </em><em><a href="mailto:demouser@exchange.local">demouser@exchange.local</a></em><em>-LinkedCredential:(Get-Credential demo\administrator)
```

Or using the GUI, once opened go to <em>recipient configuration </em>and select the <em>mailbox </em>item.

<a title="Recipient configuration" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_1.jpg"><img class="alignnone size-thumbnail wp-image-1694" title="Recipient Configuration" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_1-150x83.jpg" alt="Recipient Configuration" width="150" height="83" /></a>

Rightclick on the <em>mailbox </em>item and choose the option <em>new mailbox.</em>

<a title="New Mailbox" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_2.jpg"><img class="alignnone size-thumbnail wp-image-1695" title="New Mailbox" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_2-150x150.jpg" alt="New Mailbox" width="150" height="150" /></a>

A wizard will be opened.

<a title="Linked Mailbox" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_3.jpg"><img class="alignnone size-thumbnail wp-image-1697" title="Linked mailbox" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_31-150x150.jpg" alt="Linked mailbox" width="150" height="150" /></a>

Choose the option <em>linked mailbox </em>and click the <em>next </em>button<em>.</em>

<em><a title="New User" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_4.jpg"><em><img class="alignnone size-thumbnail wp-image-1698" title="New user" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_4-150x150.jpg" alt="New user" width="150" height="150" /></em></a></em>

After this you have the option to select an existing user or create a new user, keep in mind that this will be in the resource forest and not in the user forest.

<a title="New User step 2" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_5.jpg"><img class="alignnone size-thumbnail wp-image-1699" title="New user step 2" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_5-150x150.jpg" alt="New user step 2" width="150" height="150" /></a>

Fill in the required fields and press next to continue.

<a title="Create mailbox" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_6.jpg"><img class="alignnone size-thumbnail wp-image-1700" title="Create mailbox" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_6-150x150.jpg" alt="Create mailbox" width="150" height="150" /></a>

Select the database where you want to create the mailbox of the user and select an activesync and managed folder policy for this user if you like.

<a title="Master account" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_7.jpg"><img class="alignnone size-thumbnail wp-image-1701" title="Master account" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_7-150x150.jpg" alt="Master account" width="150" height="150" /></a>

In the next screen we will select the master account to which the mailbox will be need to assigned, this will be a user in the user forest. You can easily select the user by pressing on the browse button. When you have selected the user press next to continue.

A short overview will be displayed and when pressing next again the user and mailbox will be created.

<a title="Linked Mailbox Created" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_8.jpg"><img class="alignnone size-thumbnail wp-image-1703" title="Linked mailbox created" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/user_8-150x150.jpg" alt="Linked mailbox created" width="150" height="150" /></a>

As you can see in the screen above the user and mailbox have been created successfully.

When the mailbox is created we can perform some tests, this tests will not succeed as the user forest will not know anything about the autodiscover functionality in the resource forest.

First we will start Outlook and the following screen will be displayed.

<a title="Outlook - create profile" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_1.jpg"><img class="alignnone size-thumbnail wp-image-1706" title="Outlook - create profile" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_1-150x150.jpg" alt="Outlook - create profile" width="150" height="150" /></a>

We will fill in all the required information and press <em>next </em>to continue.

<a title="Outlook - error" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_2.jpg"><img class="alignnone size-thumbnail wp-image-1707" title="Outlook - error" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_2-150x150.jpg" alt="Outlook - error" width="150" height="150" /></a>

After several seconds Outlook will display a message that it can't setup a secure connection and that you will have the option to setup an unsecure connection, click on <em>next </em>to try this.

<img title="Outlook - unencrypted error" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_3-150x150.jpg" alt="Outlook - unencrypted error" width="150" height="150" />

This will also not succeed and Outlook tells you to verify the information. In this case we are 100% sure that the specified information is correct so why does Outlook will display the error.

This is what a client does when using the autodiscover functionality from the LAN:

<a title="Autodiscover workflow" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/autodiscover.jpg"><img title="Autodiscover workflow" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/autodiscover-150x150.gif" alt="Autodiscover workflow" width="150" height="150" /></a>

As you can see a query is done for a <em>Service Connection Point (SCP), </em>this object can be found in the configuration partition of the Active Directory which does not exist in the user forest.

To doublecheck this we will need to open adsiedit on a domain controller in the user forest. Once opened open the configuration partition and go to:

<em>CN=Services, CN=Configuration, CN=domain, CN=local</em>

<a title="Adsiedit - without autodiscover service" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/adsiedit_1.jpg"><img class="alignnone size-thumbnail wp-image-1709" title="Adsiedit - without autodiscover service" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/adsiedit_1-150x103.jpg" alt="Adsiedit - without autodiscover service" width="150" height="103" /></a>

To create the SCP in the user forest we will need to execute the following command on the Exchange server in the resource forest:

```PowerShell
Export-AutoDiscoverConfig -DomainController DomainControllerName -TargetForestDomainController TargetForestDomainControllerName -MultipleExchangeDeployments $true
```

I think the parameters are clear enough but maybe the last one will need some additional information. When the parameter <em>MultipleExchangeDeployments </em>is set to <em>TRUE </em>you will tell the forests that you have multiple Exchange forests. Not really exciting you may think but it is. The parameter will also export the <em>accepted domains </em>which are defined in the Exchange environment. When adding an extra <em>accepted domain </em>you will need to execute this command again to update the SCP object.

When you have a look with adsiedit again on the domain controller in the user forest you will see that the object for the autodiscover service has been created.

<a title="Adsiedit - with autodiscover service" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/adsiedit_2.jpg"><img class="alignnone size-thumbnail wp-image-1710" title="Adsiedit - with autodiscover service" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/adsiedit_2-150x130.jpg" alt="Adsiedit - with autodiscover service" width="150" height="130" /></a>

Per Exchange forest a folder will be created, in our case exchange.local and company.local.

When you will get the properties of the folder and have a look at the values of <em>keywords </em>and <em>serviceBindingInformation </em>you will see that it points to the resource forest. The <em>keyword </em>attribute contains the Active Directory Site of the site from which the CAS is a member. The <em>serviceBindingInformation </em>attribute contains the FQDN of the CAS server in the following format <a href="https://ex.exchange.local/autodiscover/autodiscover.xml">https://ex.exchange.local/autodiscover/autodiscover.xml</a>. When the replication has succeeded between the user forest and the resource forest it's time to try it again so we will start Outlook.

<a title="Outlook - create profile" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_4.jpg"><img class="alignnone size-thumbnail wp-image-1711" title="Outlook - create profile" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_4-150x150.jpg" alt="Outlook - create profile" width="150" height="150" /></a>

We will fill in the required info and will press <em>next</em>

<a title="Create Outlook profile succesfully" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_4.jpg"><img class="alignnone size-thumbnail wp-image-1712" title="Create Outlook profile succesfully" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_5-150x150.jpg" alt="Create Outlook profile succesfully" width="150" height="150" /></a>

As you can see above the automatic configuration of Outlook has succeeded and we can use Outlook to confirm this.

<a title="Outlook test e-mail configuration" href="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_21.jpg"><img class="alignnone size-thumbnail wp-image-1715" title="Outlook test e-mail autoconfiguration" src="https://johanveldhuis.nl/wp-content/uploads/2009/11/outlook_21-150x150.jpg" alt="Outlook test e-mail autoconfiguration" width="150" height="150" /></a>

Interesting links:

MsExchange Team: Configuration Tips and common troubleshooting steps for multiple forest deployment of Autodiscover service <a href="http://msexchangeteam.com/archive/2008/02/13/448127.aspx" target="_blank">open</a>
Technet: White Paper: Exchange 2007 Autodiscover Service <a href="http://technet.microsoft.com/en-us/library/bb332063.aspx" target="_blank">open</a>
Technet: How to create a linked mailbox <a href="http://technet.microsoft.com/en-us/library/bb123524.aspx" target="_blank">open</a>