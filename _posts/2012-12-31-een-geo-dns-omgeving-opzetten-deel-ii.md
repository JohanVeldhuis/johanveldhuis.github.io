---
id: 2625
title: 'Setting up a Geo DNS environment in your test lab &#8211; part II'
date: 2012-12-31T13:08:40+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2625
permalink: /een-geo-dns-omgeving-opzetten-deel-ii/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2012/12/connected.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
In the first part of this blog we did configure the Geo DNS server and the Database Availability Group. We now will continue with configuring the CAS role and after that perform some testing.

The first step is to set all the url’s to the same value. This because each user will use the same url when connecting from the internet and will be redirected to the correct datacenter using the GeoDNS solution.

Using the _Get-WebServicesVirtualDirectory _cmdlet we can see the current config. Because we only need a few parameters we will use the _|select _option to only select the parameters we need:

_Get-WebServicesVirtualDirectory|Select Identity, ExternalUrl, InternalUrl_

To set all the url’s to the same value we will use the _Set-WebServicesVirtualDirectory _cmdlet i.c.w. the _Get-WebServicesVirtualDirectory _cmdlet:

_Get-WebServicesVirtualDirectory|Set-WebServicesVirtualDirectory –ExternalUrl https://mail.johanveldhuis.nl/EWS/exchange.asmx -InternalUrl https://mail.johanveldhuis.nl/EWS/exchange.asmx_

After these URL&#8217;s have been fixed it’s time for the remaining URL’s to be corrected:

**OWA:**

_Get-OwaVirtualDirectory|Set-OwaVirtualDirectory –ExternalUrl https://mail.johanveldhuis.nl/owa
  
–InternalUrl https://mail.johanveldhuis.nl/owa_

**ECP:**

_Get-EcpVirtualDirectory|Set-EcpVirtualDirectory –ExternalUrl https://mail.johanveldhuis.nl/ecp
  
–InternalUrl https://mail.johanveldhuis.nl/ecp_

**OAB:**

_Get-OabVirtualDirectory|Set-OabVirtualDirectory –ExternalUrl https://mail.johanveldhuis.nl/OAB
  
–InternalUrl __https://mail.johanveldhuis.nl/OAB___

**ActiveSync:**

_Get-ActiveSyncVirtualDirectory|Set-ActiveSyncVirtualDirectory  -Internalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync  -Externalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync_

When the URL’s for the webservices have been configured it’s time to configure the Autodiscover url on both servers:

_Set-ClientAccessServer –Identity EX01 –AutodiscoverInternalUri https://autodiscover.johanveldhuis.nl/autodiscover/autodiscover.xml___

And for the next server:

_Set-ClientAccessServer –Identity EX02 –AutodiscoverInternalUri https://autodiscover.johanveldhuis.nl/autodiscover/autodiscover.xml___

Since we haven’t enabled Outlook Anywhere will need to enable it and configure it to use the correct FQDN. To do this we will need to use the _Enable-OutlookAnywhere cmdlet:_

_get-outlookanywhere|set-OutlookAnywhere -InternalHostname mail.johanveldhuis.nl -ExternalHostname mail.johanveldhuis.nl -InternalClientsRequireSsl: $true -ExternalClientsRequireSsl: $true_

Now we have configured all services with the correct url’s it’s time to generate a certificate request:

First we generate the request and put the output in a variable called $newcert:

_$newcert = New-ExchangeCertificate -GenerateRequest -SubjectName _
  
_&#8220;c=NL,o=Johan Veldhuis,cn=mail.johanveldhuis.nl&#8221; -DomainName &#8220;autodiscover.johanveldhuis.nl&#8221;  -PrivateKeyExportable $true_

Make sure you don’t forget the set the PrivateKeyExportable to true. This will give us the option to export the certificate including the private key which is needed on the other Exchange server.

Next step is to put the content of the variable in a txt file:

_newcert | out-file c:\install\csr.txt_

Now we can send the CSR to the CA. Once we received the certificate we can install it on the Exchange server which is used to create the CSR:

_Import-ExchangeCertificate –FileData ([byte []]$(Get-Content –Path &#8220;c:\install\certificate.cer&#8221; –Encoding Byte –ReadCount 0))_

Next step is to assign the certificate to the services:

_Get-ExchangeCertificate –ThumbPrint thumbprint_| _Enable-ExchangeCertificate –Services POP,IMAP,IIS,SMTP_

In this example you will need to replace _thumbprint_ by the _thumbprint _of the certificate we have installed. You can find the value of the thumbprint by running the following cmdlet:

_Get-ExchangeCertificate|select Subject,Thumbprint_

Once this step has completed we can proceed with the next server. First we need to export the certificate including the private key:

_$cert = Export-ExchangeCertificate -Thumbprint thumbprint -BinaryEncoded:$true -Password (Get-Credential).password_

This will export the certificate and will ask you for a password to protect the certificate as it includes the private key. The output is stored in a variable called $cert.

Once the output is stored in the variable it’s time to create the PFX file:

_Set-Content -Path &#8220;c:\certificates\cert.pfx&#8221; -Value $cert.FileData -Encoding Byte_

Copy the PFX file to the other Exchange server and import it:

_Import-ExchangeCertificate -FileData ([Byte[]]$(Get-Content -Path c:\certificates\cert.pfx -Encoding byte -ReadCount 0)) -Password:(Get-Credential).password_

Once it has been imported we can assign it just as we did on the other server:

_Get-ExchangeCertificate –ThumbPrint thumbprint_| _Enable-ExchangeCertificate –Services POP,IMAP,IIS,SMTP_

With this step we have completed the implementation of our Geo DNS solution.

As with every deployment now comes the most important step: verify if everything works.

There are various clients we can use for testing our Geo DNS solution among them are:

  * Outlook Web App (OWA)
  * Outlook

We will skip ActiveSync in this test but normally you would of course test each connection method which is available.

To perform these tests we will need to reconfigure our client so it matches one of the configured networks. For example:

IP: 192.168.2.100
  
Subnet: 255.255.255.0

Besides this don’t to change the DNS settings so the Geo DNS will be used for lookups.

Because all clients depend on DNS first verify if that works, although we checked it in the 1<sup>st</sup> part of this blog.

To test this we can use _nslookup:_

From a client in the 192.168.2.x range we will get this answer:

[<img title="DNS request" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/dns_1.png?resize=247%2C41" alt="" width="247" height="41" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/dns_1.png)

From a client in the 192.168.3.x range we will get this answer:

[<img title="DNS request" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/dns_2.png?resize=248%2C41" alt="" width="248" height="41" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/dns_2.png)

So far so good let’s verify if we can connect to OWA from both subnets. To perform this test simply open your favorite browser and browse to the OWA url, in this scenario https://mail.johanveldhuis.nl/owa:
  
[<img title="Outlook Web App" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/owa-300x202.png?resize=300%2C202" alt="" width="300" height="202" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/owa.png)

As you can see OWA is displayed correctly. Once this test has been performed you will need to change the network settings of the client again to match the other network. Then perform the same test again and you should still have a working OWA only then proxied via the other server.

As a final test we will perform several checks using Outlook. After configuring the profile you can see we’re connected to Outlook. When this is completed we verified that both the connection to the mailbox and autodiscover work:

[<img title="Outlook" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/outlook-300x300.png?resize=300%2C300" alt="" width="300" height="300" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/outlook.png)

Now let’s change the client’s network settings and see what happens. You might see a short disconnected but after a few seconds you are connected via the other server:

[<img title="Outlook connected" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/connected-300x16.png?resize=300%2C16" alt="" width="300" height="16" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/12/connected.png)

And Outlook continuous to synchronize the mailbox for the user. Besides this test you might want to verify some other things via Outlook:

  * verify of free/busy works
  * verify if Outlook can download the addressbook
  * verify if you can connect to the Exchange Control Panel using Outlook

Here ends the second and last part of how to build a Geo DNS solution in your test environment. Keep in mind that if you are planning to use Geo DNS you will need a “real” Geo DNS solution. This solution was only used for testing purposes and should not be used in a production environment.