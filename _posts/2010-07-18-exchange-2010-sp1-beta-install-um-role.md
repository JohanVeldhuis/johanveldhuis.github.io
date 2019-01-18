---
id: 1969
title: 'Exchange 2010 SP1 beta: install and configure UM role'
date: 2010-07-18T20:25:31+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1969
permalink: /exchange-2010-sp1-beta-install-um-role/
categories:
  - Exchange
---
In Exchange 2010 SP1 beta you will find a lot of changes. In this tutorial I will have a closer look at the Unified Messaging Role from Exchange 2010 SP1. 

Before starting the installation of the UM role you will need to ensure that you have installed the two prerequisits mentioned below: 
<ul>
	<li><a href="https://www.microsoft.com/downloads/details.aspx?FamilyID=cc5767da-e8d4-4f86-9086-e63553866a8e&amp;displaylang=en" target="_blank">Unified Communications Managed API 2.0, Core Runtime (64-bit)</a></li>
	<li><a href="https://download.microsoft.com/download/0/4/0/040235F1-3798-4B10-BB36-FAF870A8D559/Runtime/x64/SpeechPlatformRuntime.msi" target="_blank">Speech Platform</a></li>
</ul>
This is one of the new things in Service Pack 1, in the RTM version this was not necessary. In RTM you only needed to install the prerequisits using the Excahnge-UM.xml file. The files mentioned above are additional to this. Please pay attention when installing the <em>Unified Communications Managed API 2.0 </em>it might look the installation is done very quickly. But what is only done during the installation is extracting the files to <em>C:\Microsoft UCMA 2.0 RuntimeInstaller Package\amd64 </em>here you can find the file  <em>SetupUcmaRuntime </em>which does perform the installation of UCMA 2.0. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/ucma.jpg"><img class="alignnone size-thumbnail wp-image-1939" title="Installation UCMA 2.0" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/ucma-150x150.jpg" alt="" width="150" height="150" /></a> 

After the files have been installed you can start the installation of Exchange and select the Unified Messaging Role. Besides selecting the Unified Messaging Role don't forget to place a checkmark before <em>automatically install Windows Server Roles and Features required for Exchange Server. </em>This new option will install all Windows Server Roles and Features necessary for the installed Exchange role. 

Once installed it's time to start the <em>Exchange Management Console </em>and selecting the <em>UM Server </em>which can be found under the <em>organizational configuration tree.</em> On the <em>organizational configuration </em>level you can configure the following things: 
<ul>
	<li>dial-plan</li>
	<li>gateway</li>
	<li>hunt group</li>
	<li>auto attendant</li>
	<li>UM policy</li>
</ul>
Let's begin with creating the dial-plan. First we need to specify the name, the length of the extensions, URI type, VOIP Security and Country/Region code. Depending on what kind of implementation you are performing you might chose other options for the URI type and VOIP security. In this case the dial-plan will be used to attach the Exchange UM server to an OCS 2007 R2 environment. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-dialplan.jpg"><img title="Exchange 2010 new dial-plan" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-dialplan-150x150.jpg" alt="" width="150" height="150" /></a> 

In the next step we will need to add the servers attached to the dial-plan. In this case it's only one server but in an environment where you've got multiple UM servers you can easily add them all here. 

Before the dial-plan is created you will get an overview of the settings which will be used. When pushing the <em>New </em>button the dial-plan will be created. 

When the dial-plan is created you will see a warning. This warning is the result of the default configuration of the UM server. The UM Server is default configured to accept traffic using TCP. Since we configured the dial-plan to accept only traffic which is secured we will need to modify this option on <em>server configuration </em>level so that the server will accept TLS traffic. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-dialplan-finish.jpg"><img title="Exchange 2010 new dialplan finished" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-dialplan-finish-150x150.jpg" alt="" width="150" height="150" /></a> 

After the wizard has been closed you will need to get the properties of the dial-plan to configure the <em>subscriber-access. </em>This feature can be used by users to call their mailbox to, for example, check if new mails have arrived. Once you get the properties of the UM server select the <em>subscriber access </em>tab and add the extension which you would like to use fot this functionality. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/dialplan-subscriber-access.jpg"><img title="Exchange 2010 dialplan subscriber access" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/dialplan-subscriber-access-150x150.jpg" alt="" width="150" height="150" /></a> 

Next step in the process is to add the gateway to which the Exchange UM server will need to send it's traffic to. 

We will only need to specify a name, IP-address of FQDN of the gateway and the dial-plan which may use this gateway. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-umipgateway.jpg"><img title="Exchange 2010 new UM IP gateway" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/new-umipgateway-150x150.jpg" alt="" width="150" height="150" /></a> 

During the creation of the gateway a hunt group will be automatically created. In some cases it may be necessary to remove the hunt group and create a new one.  This because the <em>pilot identifier </em>will not be configured by default. If want to skip the creation of the hunt group don't select a dial-plan and attach the gateway manually to the dial-plan. 

Default a <em>UM Mailbox policy </em>will be created during the creation of the dial-plan. With this policy you may not have to change things as the settings are OK for your organization. But if you like to make changes to the text of the message which is send to the users when they are UM enabled then modify the policy. 

Beside the text there are a lot of other settings which are defined by this policy. For example the pin policies which you would like to apply to users: complexity, minimum pin length and wrong pin attempts. 

Optional it's possible to configure an auto attendant. This is an electronic operator which can transfer calls and play a menu to the caller with options which will transfer him/her to the correct department. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/new_aa.jpg"><img title="New UM Auto Attendant" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/new_aa-150x150.jpg" alt="" width="150" height="150" /></a> 

The configuration at <em>organizational configuration </em>level is finished and so it's to configure some things on <em>server configuration </em>level. Get the properties of the UM server and select the <em>UM Settings </em>tab. Change the value of the <em>startup mode </em>to <em>TLS </em>or <em>Dual </em>and press OK. 

A warning will be displayed that the Exchange UM service will need to be restarted and that you will need to verify that a valid certificate is assigned to the service. The certificate is important because we selected <em>secure </em>at the dial-plan. This will ensure that all traffic is secured using certificates for authentication. If an invalid certificate is used by one of the parties the communication will fail. 

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/umsettings_2.jpg"><img title="UM Settings" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/umsettings_2-150x150.jpg" alt="" width="150" height="150" /></a> 

If you decide to install the certificate later then you may have some issues with restarting the Exchange UM service. This because the self-signed certificate is not assigned to the Exchange UM service. 

Configuring UM can be dan a lot easier when using Powershell. Below you will find an overview of commands which you can use to create the configuration exactly as done via the GUI:

```PowerShell 
New-UMDialplan -Name Utrecht -UriType SipName -NumberOfDigitsInExtension 3 -VoIPSecurity Secured -AccessTelephoneNumbers "110" -CountryorRegion 030

New-UMIPGateway -Name "Utrecht VOIP Gateway"  -Address 192.168.1.250 -UMDialplan "Utrecht"

New-UMAutoAttendant -Name Utrecht_AA -UMDialPlan Utrecht -PilotIdentifierList "+313012345100" -SpeechEnabled $true

Set-UMserver -identity "ex" -DialPlans "Utrecht" -UMStartupMode "TLS"
```

If you like Powershell then I recommend to use it because configuring UM goes a lot faster.

New in SP1 are two additional expensions for the UM role, these can be found under <em>tools </em>in the Exchange Management Console:
<ul>
	<li>Call Statistics</li>
	<li>User Call logs</li>
</ul>
First the call statistics, this report utility can be used to generate overviews of calls which are processed by your Exchange UM server. This may be very usefull when you would like to get an overview of how much users will use the UM functionality of Exchange.

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/call.jpg"><img title="Call statistics" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/call-150x150.jpg" alt="" width="150" height="150" /></a>

Besides to the overall overview you can generate reports per user using the user call log. In this overview you can for example see how much calls a user receives and which quality the call was. This may be very usefull when troubeshooting the quality of calls

<a href="https://johanveldhuis.nl/wp-content/uploads/2010/07/user.jpg"><img title="User Call log" src="https://johanveldhuis.nl/wp-content/uploads/2010/07/user-150x150.jpg" alt="" width="150" height="150" /></a>

But what are the other changes in SP1 when looking at UM:
<ul>
	<li>you can assign a second dial plan to a user. In some scenario's ut may be usefull to assign a second extenstions to a user.</li>
	<li>cross-forest migration of UM-mailboxes is possible</li>
	<li>UM Settings can be managed using the Exchange Control Panel</li>
	<li>no support for Exchange 2010 SP1 in combination with Office Communication Server 2007</li>
</ul>
<span style="color: #ff0000;">Remark: all features and screenshots mentioned in this article are based on the beta of SP1 and may change in the final release.</span>