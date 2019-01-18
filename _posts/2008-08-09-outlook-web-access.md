---
id: 605
title: Outlook Web Access
date: 2008-08-09T22:38:17+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=605
permalink: /outlook-web-access/
categories:
  - Exchange
---
When you have played with Exchange 2007 and Outlook Web Access earlier you may have seen a lot of differences between Outlook Web Access 2007 and 2003. There have been added nice features to the new version of OWA such as: you can access a file-server/sharepoint-server, you can restrict what files can be opened via OWA and how they are opened then.

Users can only use these functionalities if their mailbox is hosted on an Exchange 2007 mailbox server. The users who have their mailbox on an Exchange 2003 server will use the old version of OWA.

The OWA functionalities are delivered by the Client Access Server (CAS) if you had an Exchange 2003 environment running with OWA this functionality was provided by the Frontednd Server. When we zoom in to the Exchange Management Console en then have a close look ath the server configuration of  the CAS server you will discover that it hosts mutiple websites:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-sites.jpg"><img class="alignnone size-thumbnail wp-image-603" title="Diverse websites op de CAS server" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-sites-150x127.jpg" alt="" width="150" height="127" /></a>

The three that are important for Outlook Web Access are:
<ul>
	<li>owa, this is the 2007 version of OWA</li>
	<li>exchange, this is the 2003 version of OWA</li>
	<li>exchweb, this site contains most functionalities of OWA</li>
</ul>
Now you may ask yourself, what are those other directories used for:
<ul>
	<li>exadmin, this folder willl be used when you manage Public Folders from the Management Console</li>
	<li>public, this folder will be use when opening a Public Folder via OWA</li>
</ul>
We will restrict this tutorial to OWA 2007 only, so we will get the properties of the site named <em>owa.</em>

The first tab we see is <em>general:</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-general.jpg"><img class="alignnone size-thumbnail wp-image-604" title="OWA general tab" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-general-150x150.jpg" alt="" width="150" height="150" /></a>

You can't change much on this tab, it contains some information you may find interesting:
<ul>
	<li>which server is hosting the OWA</li>
	<li>under which website the OWA is placed</li>
	<li>for which Exchange version this OWA is responsible</li>
	<li>when has the website changed</li>
</ul>
There are two fields which you can fill in:
<ul>
	<li>internal url, here you need to define the url which users on the internal network use to access the OWA</li>
	<li>external url, here you need to define the url which users on the internet use to access the OWA</li>
</ul>
You need to pay attention to the url's when you are going to buy certificates that you buy one for the correct url.

The next tab is <em>authentication</em> on this tab we can setup the way the user has to login to OWA. The default setting is <em>Use form-based authentication </em>below this option you can choose three methods to fill in the username:
<ul>
	<li>Domain\username, the user logs in like this test.local\johan</li>
	<li>User Principale Name, the user logs in like this <a href="mailto:johan@test.local">johan@test.local</a></li>
	<li>User Name Only, the user fills in his username, in this case the field <em>logon domain </em>contains the domain where the user needs to login.</li>
</ul>
<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-auth.jpg"><img class="alignnone size-thumbnail wp-image-607" title="OWA Authentication" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-auth-150x150.jpg" alt="" width="150" height="150" /></a>

The next tab is <em>segmentation </em>on this tab we can control what options end-users will get when they use OWA. You can for example block the ActivSync integration or prevent the password changing in OWA.

 <a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-segment.jpg"><img class="alignnone size-thumbnail wp-image-612" title="OWA segmentation" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-segment-150x150.jpg" alt="" width="150" height="150" /></a>

On the tab <em>Public Computer File Access </em>you can decide how OWA will react if a user tries to open an attachment while logged into OWA from a public computer:
<ul>
	<li>OWA needs to convert the file via the Web ready functionality</li>
	<li>OWA needs to prevent the opening/downloading of the file</li>
	<li>OWA allows to open/download the file</li>
</ul>
 <a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-public.jpg"><img class="alignnone size-thumbnail wp-image-633" title="OWA Public Computer Files Access" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-public-150x150.jpg" alt="" width="150" height="150" /></a>

As you can see it has been changed a lot compared to OWA 2003. The first option <em>enable direct file access </em>let you configure which files the end-user may open without using the Web ready functionality. When you click on the <em>customise </em>button you can change the files allowed or blocked:
<ul>
	<li><em>allow, which files with the </em>extension/mime-code may be opened</li>
	<li><em>block, </em>which files with the extension/mime-code may not be opened</li>
	<li><em>force save, </em>which files with the extension/mime-code first need to be saved before opening.</li>
	<li><em>unknown files, </em>what does OWA need to do with  "unknown" files</li>
</ul>
You see there are a lot of possibilities and you can really make changes to allow or block a file. The default settings are quite good, if you won't allow mp3's being opened via OWA then you need to delete it from the <em>allow </em>list. The option <em>unknown files </em>will be used when an extension/mime-code is not defined in the other 3 lists. The  default option for <em>unknown files </em>is <em>Force Save </em>which tells OWA to first let the user download the file before opening it.

Another new feature in OWA is <em>WebReady Document Viewing, </em>this function will convert a file to a webpage with the build-in convertors. Normally this shouldn't be the case because the option <em>Force WebReady Document viewing when a converter is available </em>is disabled. OWA contains converters for the following filetypes:
<ul>
	<li>Excel files</li>
	<li>Word files</li>
	<li>Powerpoint files</li>
	<li>PDF files</li>
</ul>
I think this are the most used files which you want to open using this new function.  You don't need to have the application installed locally on your pc/laptop.

The last two options on this tab make it possible to open files on <em>remote file servers</em>. With <em>remote file servers </em>you are able to open files on:
<ul>
	<li>Windows File Shares</li>
	<li>Windows SharePoint Services</li>
</ul>
The <em>remote file servers </em>need to defined on another tab called <em>remote servers</em> this will come later on in this tutorial.

The next tab is <em>Private Computer Access </em>with this tab you can configure the same things as on the tab <em>Public Computer Access </em>only then for trusted computers/laptops. Default there are a few settings that are not the same as on the tab <em>Public Computer Access </em>for example the options to access Windows File Shares and Windows SharePoint Services is enabled.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-private.jpg"><img class="alignnone size-thumbnail wp-image-634" title="OWA Private Computer File Access" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-private-150x150.jpg" alt="" width="150" height="150" /></a>

On the last tab <em>remote file servers </em>you can setup which servers are accessable via OWA. You can easily set this up by adding a server to one of the two lists. It would be a lot of work to add all the file-servers that you want to block and for example allow only one. For this case you can use the option <em>unknown servers </em>the action defined there will be used for every server who isn't listed on the <em>allow </em>or <em>block </em>list. Default the action is <em>block. </em>

 <a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-remote.jpg"><img class="alignnone size-thumbnail wp-image-637" title="OWA remote file servers" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-remote-150x150.jpg" alt="" width="150" height="150" /></a>

As you can see there is only one button left that we didn't spoke about. The button <em>configuration </em>on the bottom of the tab. With this button we need to specify which domains need to be seen as internal domains. When a server is added from a domain that is not listed OWA will not see it as an internal server and will block access to it.

We now have spoken about all the tabs of OWA. The other things such as certificates will be handeled via the Powershell and IIS admin MMC.

When OWA is published on the internet it may be necessary to use a 3rd party certificate for the OWA, you can buy a certificate with for example VeriSign. OWA 2007 uses https and form-based authentication by default. Here a self-signed certificate is used, which can result in warnings from webbrowsers.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-certificaatfout.jpg"><img class="alignnone size-thumbnail wp-image-638" title="OWA certificate error" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-certificaatfout.jpg" alt="" width="104" height="27" /></a>

You will have to add a copy of the self signed certificate to the trusted root authority to prevent this error. You can get a copy of this certificate in two ways:
<ul>
	<li>via the website itself and then import it into the right store</li>
	<li>by exporting it via Powershell and import it in the right store</li>
</ul>
First via the website itself:
<ul>
	<li>go to the website</li>
	<li>click on continue when the warning is displayed.</li>
	<li>click on the certificate error button in the addressbar</li>
	<li>click on display certificate</li>
	<li>click on install certificate</li>
	<li>choose the option to save all certificates in the archive below</li>
	<li>select the trusted root authority via the browse function</li>
	<li>click on next en finish</li>
	<li>a warning will be displayed that you are importing a certificate, accept it</li>
	<li>a message will be displayed that the certificate is installed</li>
</ul>
All the steps above can be done on a client. All the steps below need to be executed from the CAS server:
<ul>
	<li>execute the following domain: <em>Get-ExchangeCertificate -DomainName mail.test.local</em></li>
	<li>an overview will be displayed with all certificates that are used by <em>mail.test.local</em></li>
	<li>then we need to export the certificate: <em>Export-ExchangeCertificate -Thumbprint 5113ae0233a72fccb75b1d0198628675333d010e -BinaryEncoded:$true -Path c:\certificates\export.pfx -Password:(Get-Credential).password</em></li>
	<li>when this command is executed it will prompt you for a username and password. The password is the only thing that is necessary to export and import the certificate.</li>
	<li>the last step is importing the certificate in the trusted root authorities on the client, optionally this can be done via a Group Policy.</li>
</ul>
<a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-cert.jpg"><img class="alignnone size-thumbnail wp-image-639" title="Get-Exchangecertificate output" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/owa-cert-150x103.jpg" alt="" width="150" height="103" /></a>

Both warnings will result in not displaying the message anymore. When a 3rd party certificate will be installed the steps above are not needed. The only thing you should arrange is that you trust the root certificate from the 3rd party.

When you choose to get a certificate from a 3rd party we first need to create a CSR and after that when receiving the file from the 3rd party install it.:
<ul>
	<li>start Powershell</li>
	<li>run the following command: <em>New-ExchangeCertificate -DomainName test.ocal -Force -FriendlyName OWA -GenerateRequest:$True -Keysize 2048 -Path c:\owa.req -privatekeyExportable:$true -SubjectName "C=NL, O=Test, L=Utrecht, S=Utrecht, CN=owa.test.local"</em></li>
	<li>this command will generate a CSR to get a certificate</li>
	<li>when we receive the certificate from the 3rd Party we need to install it</li>
	<li>importing is done by the following command: <em>Import-ExchangeCertificate -Path c:\certificaat.crt | Enable-ExchangeCertificate -Services "IIS"</em></li>
	<li>with the parameter<em>-Services </em>we can tell Exchange that this certificate may only be use for <em>IIS </em>in this case. Other options are <em>SMTP, IMAP </em>and <em>POP3.</em></li>
</ul>
If everything is configured we can check if OWA is working OK, this can be done in two ways:
<ul>
	<li>open <a href="https://owa.test.local/owa">https://owa.test.local/owa</a></li>
	<li>run the Powershell command: <em>Test-OwaConnectivity</em></li>
</ul>
I use OWA 2007 for a few months now and I must say it's working really good. I hope you have learned something from this tutorial.