---
id: 1821
title: Make OCS client available in OWA
date: 2010-01-20T22:43:19+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1821
permalink: /make-ocs-client-available-in-owa/
categories:
  - Exchange
---
Microsoft has released OCS 2007 R2 Web Service provider a while ago, with this piece of software you will make a limited OCS client available via OWA. In this tutorial I will explain how you can get the OCS client working together with the OWA from Exchange 2010. You can download the software using the link below:
<ul>
	<li><a href="http://www.microsoft.com/downloads/details.aspx?displaylang=en&amp;FamilyID=ca107ab1-63c8-4c6a-816d-17961393d2b8" target="_blank">Download OCS 2007 R2 Web Service Provider</a></li>
	<li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=B3B02475-150C-41FA-844A-C10A517040F4&amp;displaylang=en">Hotfix 968802</a> (UcmaRedist)</li>
</ul>
Before installing the software make sure you have a certificate installed which is trusted by the OCS server. When you've downloaded the requested files you can start installing them. The file CWAOWASSPMain contains four seperate files and the patch file consists of one MSP file, the files need to be installed in the following order:
<ul>
	<li>vcredist_x64</li>
	<li>UcmaRedist.msi</li>
	<li>UcmaRedist.msp</li>
	<li>CWAOWASSP</li>
</ul>
When the files are installed it's time to build the configuration. First we need to gather some information about the certificate being used by the IIS service, you can do this by running the following command in Powershell <em>get-exchangecertificate |fl</em>. You will get an overview of all installed certificates on the CAS server search for the one that is used for IIS, this one can be recognized by checking the entries after the <em>services</em> label. From this certificate we need the values of two fields:
<ul>
	<li>Issuer</li>
	<li>SerialNumber</li>
</ul>
<a href="https://johanveldhuis.nl/wp-content/uploads/2010/01/certificate.jpg"><img class="alignnone size-thumbnail wp-image-1811" title="Get-Exchangecertificate |fl" src="https://johanveldhuis.nl/wp-content/uploads/2010/01/certificate-150x150.jpg" alt="" width="150" height="150" /></a>

Now we copied the values it's time to make the modifications to the OWA configurationfile, you can find it in the following directory <em>c:\Program Files\Microsoft\Exchange\v14\ClientAccess\Owa</em>. Here you will find <em>web.config </em>, which contains the configuration for Outlook Web Access. Before modifying it create a backup of the file, this will let you quickly restore to the original configuration in case OWA doesn't work anymore after the modifications. Then open the web.config using a text editor such as Notepad and search for the line containing the following word <em>IMPoolName </em>this is the firstline of the section which needs to be changed. Once found change the following lines:
<ul>
	<li>IMPoolName: fill in the name of the OCS pool</li>
	<li>IMCertificateIssues: use the value just copied from issuer, example: CN=company-DC01-CA, DC=Company, DC=Local</li>
	<li>IMCertificateSerialNumber: use the value justr copied from serialnumber, example: 61580B7D00000000000E</li>
</ul>
Once done save the file. Next step is to add the OCS client to the OWA, this can be done by using the <em>Set-OwaVirtualDirectory –InstantMessagingType. </em>On the internet you will find several stories about the value that needs to be entered after the <em>InstantMessagingType</em> parameter. The Technet documentation will tell you to use the <em>OCS</em> parameter but in some cases this won't work according to several forum posts i found. If this is the case try <em>1</em> as the value for the parameter and check if it works. Although I don't think the parameter is the issue since I've tried it in a working environment and Exchange gave the message that nothing had changed. To activate OCS in OWA you will need to run the command below to set the <em>InstanteMessagingType</em> parameter: <em></em>

```PowerShell
Set-OwaVirtualDirectory -InstantMessagingType 1
```

o<em>r </em>

```PowerShell
Get-OwaVirtualDirectory -server servernaam |Set-OwaVirtualDirectory -InstantMessagingType 1
```

The Exchange side is completed, now it's time for the OCS side. For this you will need to open the OCS administration tool and get the Front End properties of the pool. Here you will find the <em>authorized hosts</em> tab. Here you will need to add the following items:
<ul>
	<li>FQDN of OWA</li>
</ul>
<a href="https://johanveldhuis.nl/wp-content/uploads/2010/01/add_authorized_host.jpg"><img class="alignnone size-thumbnail wp-image-1812" title="Add Authorized host" src="https://johanveldhuis.nl/wp-content/uploads/2010/01/add_authorized_host-150x150.jpg" alt="" width="150" height="150" /></a>

When the fqdn has been added restart the Front End service to make the modifications active. Once the service is started again you will see the OCS client once logged in using OWA.

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/01/user.jpg"><img class="alignnone size-thumbnail wp-image-1813" title="OCS client in OWA" src="https://johanveldhuis.nl/wp-content/uploads/2010/01/user-150x150.jpg" alt="" width="150" height="150" /></a>

As you can see you can set your own status and see the status of other users. Besides this the left menu has been extended with a contactlist which corresponds with your contactlist in the MOC client.