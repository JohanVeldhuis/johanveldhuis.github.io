---
id: 186
title: Configure Exchange UMTestphone
date: 2008-01-08T22:07:42+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=186
permalink: /configure-exchange-umtestphone/
categories:
  - Exchange
---
This tutorial will help you to install the Exchange UMTestphone. This tutorial will not contain info on how to configure Exchange 2007 UM.

Microsoft has made this piece of software to let you test the Exchange 2007 UM funcionalities without needing extra hardware such as a PBX. In most cases I prefer to test on a client instead of a server. The only disadvantage of this software is that there is no installer for it so you need to copy some files manually. Lets start with the system requirements:
<ul>
	<li>working soundcard with a microphone, the microphone is not really needed.</li>
	<li>Microsoft .NET Framework 2.0</li>
	<li>working Exchange 2007 UM environment</li>
</ul>
De first systemrequirement is no problem in most cases; most laptops and desktops now a days contain one standard. The second systemrequirement most times is not an issue also. You could check easily is you have it installed already. Look if the following directory exists %SYSTEMROOT%\Microsoft.NET\Framework\v2.0.50727 exists. If you don't have it installed you can download it via the link below or install it via Windows Update:

<a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=0856EACB-4362-4B0D-8EDD-AAB15C5E04F5&amp;displaylang=en" target="_blank">Microsoft .NET Framework 2.0</a>

After downloading the software it's just a couple of clicks to have .NET 2.0 installed.

The last system requirement sounds logical; this is what we want to test.

Now that we met all systemrequirements we can begin with copying some files. You can find all files on the server which has the UM role installed on it. All files need to be copied to a folder, you don't need to create the folders that exist on the server.

There are two ways to copy the first three files, first we will use the official way as described on Technet.

You can't find the following three files via Windows Explorer, you need to copy them via a dos box:
<ul>
	<li>&lt;%windir%&gt;\assembly\GAC_32\Microsoft.Collaboration.Media\MediaVersionNumber\Microsoft.RTC.Collaboration.Media.dll</li>
	<li>&lt;%windir&gt;\assembly\GAC_MSIL\Microsoft.Collaboration\<em>CollaborationVersionNumber</em>\Microsoft.RTC.Collaboration.dll</li>
	<li>&lt;%windir%&gt;\assembly\GAC_32\SIPEPS\<em>SipsepsVersionNumber</em>\SIPEPS.dll</li>
</ul>
The CollabortionVerionNumber and SipsepsVersionNumber will let you see which version is currently running. For exampe a <em>CollaborationVersionNumber</em> can be 3.0.0.0__31bf385.

The other way is to copy the files straight from the Exchange server itself, this can be done via the Windows Explorer. The last way is the easiest way and as far as I have tested it works OK.

Besides the three files we already copied we need to copy a few files more, this can be done with the Windows Explorer:
<ul>
	<li>Exchange Server\bin\exchmem.dll</li>
	<li>Exchange Server\bin\extrace.dll</li>
	<li>Exchange Server\bin\Microsoft.Exchange.Common.dll</li>
	<li>Exchange Server\bin\Microsoft.Exchange.Diagnostics.dll</li>
	<li>Exchange Server\bin\Microsoft.Exchange.Net.dll</li>
	<li>Exchange Server\bin\Microsoft.Exchange.Rpc.dll</li>
	<li>Exchange Server\bin\ ExchangeUMTestPhone.exe</li>
	<li>Exchange Server\public\Microsoft.Exchange.Data.Common.dll</li>
</ul>
After all files have been copied you can start up the phone, this can be done by double clicking on the ExchangeUMTestPhone file.

<a title="UMTestPhone" href="https://myuclab.nl/wp-content/uploads/2008/03/testphone.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/testphone.thumbnail.jpg" alt="UMTestPhone" /></a>

The next step will be to setup the UMTestPhone, this can be done via tools en then choosing the option setup, you wil then get the following screen:

<a title="Setup UMTestPhone" href="https://myuclab.nl/wp-admin/h/wp-content/uploads/2008/03/setup.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/setup.thumbnail.jpg" alt="Setup UMTestPhone" /></a>

Fill in the following fields:
<ul>
	<li>server address: the ip-address/FQDN of the Exchange server</li>
	<li>caller id: the voicemailnumber of the Exchange UM environment</li>
</ul>
When you have finished all steps you only need to make one change on the Exchange server itself. The UM gateway needs to be modified so it points to the client that runs the UMTestphone. You can do this by opening the Exchange Management Console and then go ti <em>Organization Configuration</em> and choosing the option <em>Unified Messaging</em>. On the tab <em>UM IP Gateways</em> you can change the current gateway:

<a title="UM IP Gateway" href="https://myuclab.nl/wp-content/uploads/2008/03/image7.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image7.thumbnail.jpg" alt="UM IP Gateway" /></a>