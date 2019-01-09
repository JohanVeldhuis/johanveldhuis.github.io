---
id: 2572
title: Configure Exchange 2013 RTM via the Exchange Management Shell
date: 2012-10-29T20:21:13+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2572
permalink: /exchange-2013-rtm-configureren-via-the-exchange-management-shell/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2012/10/set-owavirtualdirectory.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2013
---
In the previous blog we had a look how we could install a multi-role Exchange 2013 server via the command prompt. In this blog we will have a look at how to configure this Exchange 2013 environment.

We will start with configuring the accepted domains, the domains for which Exchange will accept e-mail. By default the Active Directory domain is added. If you have corp.local as Active Directory domain this will be added as authoritative accepted domain to Exchange:

<p align="center">
  <img title="get-accepteddomain" alt="" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/get_accepteddomain-300x29.png?resize=300%2C29" width="300" height="29" data-recalc-dims="1" />
</p>

Authoritative means that Exchange is the only mail server which is responsible for this domain. When a message is sent to a non-existing user Exchange will reply with an error message immediately.

Because in most cases the Active Directory domain is not the same as the mail domain we will first need to add it. This can be done by using the _New-AcceptedDomain_ cmdlet, for example:

_New-AcceptedDomain -DomainName johanveldhuis.nl -DomainType authoritative -Name johanveldhuis.nl_

The parameter _DomainName_ specifies the domain, _DomainType_ will tell Exchange to configure it as an authoritative domain and with the last parameter _name_ we specify the name of the domain this makes it easier to identity it in the GUI and Shell.

Next step is to add the domain to the default e-mail address policy or even create a new e-mail address policy. By default Exchange 2013 contains one e-mail address policy, the default address policy, which will be applied to all users to which no other e-mail address policy applies. This policy contains only the Active Directory domain. There are two options:

  * Add the new domain to the default address policy
  * Create a new e-mail address policy for the new domain

In this example we will use the 2nd option. Because this will ensure that only an e-mail address is added containing the mail domain and not one with the Active Directory as domain part.

To create a new e-mail address policy we will use the _New-EmailAddressPolicy_ cmdlet:

_New-EmailAddressPolicy -Name &#8220;johanveldhuis.nl&#8221; -IncludedRecipients MailboxUsers -ConditionalCompany &#8220;Johan Veldhuis&#8221; -EnabledEmailAddressTemplates &#8220;SMTP:%g.%s@johanveldhuis.nl&#8221;_

In this example we will create an e-mail address policy with the name _johanveldhuis.nl._ This policy will be applied to all Mailbox users so not to contacts or mail-enabled users. We will add a filter using the ConditionalCompany. As last parameter we will specify the format of the e-mail address. In this case givenname.surename_@johanveldhuis.nl._ A complete overview of variables which can be used can be found <a href="http://technet.microsoft.com/en-us/library/bb232171.aspx" target="_blank">here</a>.

Now we have added the accepted domain and e-mail address policy it’s time to configure the internal and external URL’s.  In this example we will use the following URL&#8217;s:

  * webmail.johanveldhuis.nl: for Outlook Web App and the Exchange Control Panel
  * mail.johanveldhuis.nl: for EWS, the Offline Address Book and ActiveSync

We don’t configure Outlook Anywhere we will discuss this in a future blog.

To configure the URL’s we will use several cmdlets:

**Set-OwaVirtualDirectory:**

_Set-OwaVirtualDirectory -identity &#8220;EXCHANGE\owa (Default Web Site)&#8221; -InternalUrl_ _https://webmail.johanveldhuis.nl/owa_ _-ExternalUrl_ _https://webmail.johanveldhuis.nl/owa_

<p align="center">
   <img title="Set-OwaVirtualDirectory" alt="" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/set-owavirtualdirectory-300x24.png?resize=300%2C24" width="300" height="24" data-recalc-dims="1" />
</p>

When running the cmdlet above you will receive a warning that you also must change the url of the ECP virtual directory.

**Set-EcpVirtualDirectory:**

_Set-EcpVirtualDirectory -identity &#8220;EXCHANGE\ecp (Default Web Site)&#8221; -InternalUrl https://webmail.johanveldhuis.nl/ecp_  _-ExternalUrl https://webmail.johanveldhuis.nl/ecp_

**Set-WebServicesVirtualDirectory:**

_Set-WebServicesVirtualDirectory -identity &#8220;EXCHANGE\EWS (Default Web Site)&#8221; -InternalUrl_

https://mail.johanveldhuis.nl/EWS/Exchange.asmx -ExternalUrl

https://mail.johanveldhuis.nl/EWS/Exchange.asmx

**Set-OabVirtualDirectory:**

_Set-OabVirtualDirectory -identity &#8220;EXCHANGE\OAB (Default Web Site)&#8221; -InternalUrl_

https://mail.johanveldhuis.nl/OAB  -ExternalUrl

https://mail.johanveldhuis.nl/OAB

**Set-ActiveSyncVirtualDirectory:**

_Set-ActiveSyncVirtualDirectory -identity &#8220;EXCHANGE\Microsoft-Server-ActiveSync (Default Web_

Site)&#8221; -Internalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync  -Externalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync

As last step we will need to reconfigure the autodiscover URL. For those of you who are familiar with Exchange 2007 and higher this will be no surprise. For those who don’t Exchange will offer autodiscover functionality for auto configure Outlook/Entourage clients. By default a service connection point (SCP) is created. This SCP has the value in the following format http://serverfqdn/autodiscover/autodiscover.xml. Because this will create a single point of failure in a HA environment this has to be reconfigured. Although in our scenario we don’t have a HA environment yet we will reconfigure the autodiscover URL using the _Set-ClientAccessServer_ cmdlet:

_Set-ClientAccessServer –AutodiscoverInternalUri https://autodiscover.johanveldhuis.nl/autodiscover/autodiscover.xml___

Now all URL’s have been configured correctly it’s time to request a new certificate. This because Exchange 2013 has a self-signed certificate by default.

First we generate the CSR:

_$newcert = New-ExchangeCertificate -GenerateRequest -SubjectName_ 

_&#8220;c=NL,o=Johan Veldhuis,cn=webmail.johanveldhuis.nl&#8221; -DomainName &#8220;autodiscover.johanveldhuis.nl&#8221;,&#8221;mail.johanveldhuis.nl&#8221;  -PrivateKeyExportable $true_

In the example above we will store the request in a variable called _$newcert._ Because we want to have the option to install this certificate on another server we also specify that we want to be able to export the certificate including the private key.

Once we stored the request in a variable we will store the content to a text file:

_newcert | out-file c:\install\csr.txt_

Now we have the file we can request the certificate. As soon as we have received the certificate from the CA we can install it on the Exchange 2013 server:

_Import-ExchangeCertificate –FileData ([byte []]$(Get-Content –Path &#8220;c:\install\certificaat.cer&#8221; –Encoding Byte –ReadCount 0))_

As final step we will need to assign the certificate to the Exchange services:

_Get-ExchangeCertificate –ThumbPrint thumbprint_| _Enable-ExchangeCertificate –Services POP,IMAP,IIS,SMTP_

In this example you will need to replace _thumbprint_ by the _thumbprint_ of the certificate we have installed. You can find the value of the thumbprint by running the following cmdlet:

_Get-ExchangeCertificate|select Subject,Thumbprint_

The certificate will be assigned to POP3, IMAP, all web services and SMTP.

When you assign the certificate to the services you will receive a warning that the current certificate is being replaced. Accept this warning so the certificate will be assigned correctly to the services.

Before we can create users we only need to perform one step, configure the send connector:

_New-SendConnector -Internet -Name To_Internet -AddressSpaces *_

Using the cmdlet adobe we will create a send connector which has as name _To_Internet_. All messages to other mail domains will be send via this connector.

Here ends the blog about how to configure Exchange via the Exchange Management Shell. In the next blog we will have a look at how to create the mailbox types and provide extra functionalities to users such as UM.