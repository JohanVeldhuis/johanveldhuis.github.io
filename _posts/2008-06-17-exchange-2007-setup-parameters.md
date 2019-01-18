---
id: 372
title: Automate Exchange 2007 setup
date: 2008-06-17T21:46:11+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=372
permalink: /exchange-2007-setup-automatiseren/
categories:
  - Exchange
---
Such as most products have, the setup from Exchange 2007 can be made unattented. This can partitially be done by specifying parameters after the setup command.

The first parameter, if you have your forest and domains prepped, is mode, with this parameter you can specify the mode setup will be running in: install, uninstall, upgrade or recover.

<em>/mode:install</em>

/mode:uninstall

/mode:upgrade

<em>/mode:RecoverServer</em>

The next parameter is role, with this parameter you can specify which rol(es) need to be install(ed) on the server:

<em>/role(s):HubTransPort, HT, H </em>installs the HUB Transport role

<em>/role(s):ClientAccess, CA, C </em>installs the Cient Access role

<em>/role(s):MailBox, MB, M </em>installs the HUB Transport role

<em>/role(s):UnifiedMessaging, UM, U</em> installs the Unified Messaging role

<em>/role(s):EdgeTransport, ET, E </em>installs theEdge Transport role

<em>/role(s):ManagementTools, MT, T </em>installs the Management Tools

It is possible to combine the parameters, for example:

<em>/roles:H,C,M,T</em>

The parameters above will install the Hub Transport, Client Access and Mailbox rols + the management tools.

Besided  the parameters already mentioned you can give up several other parameters for example to change the install directory, below an overview of a few of them:
<ul>
	<li><em>/OrganizationName, /on</em> with this parameter you can specify an Exchange organization, this parameter is needed when no Exchange environment is currently active.</li>
	<li><em>/TargetDir, /t</em>with this parameter you can specify the install directory, default it is %programfiles%\Microsoft\Exchange Server.</li>
	<li><em>/DomainController, /dc</em>with this parameter you can specify the domaincontroller which is used for gathering the information that is needed and for writing some config issues in the Active Directory.</li>
	<li><em>/UpdatesDir, /u</em>if you don't want to install all updates manually after the setup you can use this parameter to install them automatically.</li>
</ul>
Besides the already mentioned parameters there are parameters for preparing the forest and domain for Exchange 2007:
<ul>
	<li> <em>/PrepareLegacyExchangePermissions, /pl </em>when you have installed an earlier version of Exchange you can't adjust the Active Directory for Exchange 2007. You should use this parameter to ensure that the previous Exchange versions will be working together with Exchange 2007. When you don't use this parameter it could be that the Recipient Update Service doesn't work OK anymore.</li>
	<li><em>/PrepareSchema, /ps </em>this parameter is used to prepare the schema for Exchange 2007. You should run the Exchange setup with this parameter on the Schema Master This parameter doesn't need to be specified when using PrepareLegacyPermissions<em>, </em>when using that it will be automatically done.</li>
	<li><em>/PrepareAD, /p </em>with this parameter you will prepare the forest. This parameter will also run the <em>PrepareDomain </em>parameter/action.</li>
	<li><em>/PrepareDomain, /pd</em>  will ensure that the domain will be prepared for Exchange 2007.</li>
	<li><em>/PrepareAllDomains, /pad</em>  this parameter is the same as the previous one, only this one will prepare all domains and subdomains.</li>
</ul>
Besides all the parameters mentioned there are a lot of more parameters that you can use, a full overview can be found on this <a href="http://technet.microsoft.com/en-us/library/bb288906(EXCHG.80).aspx" target="_blank">site</a>.