---
id: 316
title: Install Exchange 2007 in a Exchange 2003 environment
date: 2008-04-28T21:12:45+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=316
permalink: /Install-Exchange-2007-in-an-Exchange-2003-environment/
categories:
  - Exchange
---
<p style="PADDING-RIGHT: 0.6em; PADDING-LEFT: 0.6em; PADDING-BOTTOM: 0.6em; PADDING-TOP: 0.6em"><span>In this tutori<span>al</span> I will discuss the steps which are necessary to install Exchange 2007 server in Exchange 2003 environment. This solution can be used if you want to <span>migrate</span> from Exchange 2003 to Exchange 2007 and:</span></p>

<ul>
	<li>you want to use the current Active Directory</li>
	<li><span>you want to reuse the existing Exchange <span>environment</span>.</span></li>
</ul>
<span>If one of the conditions is not necessary or not possible you should use an other migration scenario, for example a cross-<span>forest</span> migration which can be used to build a new AD parallel to the old AD. This last option is a bit more work then installing an Exchange 2007 server in the current environment.</span>

Before we start you should check a few things:
<ul>
	<li>which mode is Exchange 2003 currently running ?</li>
	<li><span>which <span>servicepack</span> is installed for Exchange 2003 ?</span></li>
</ul>
These to points can be found out very easy:
<ul>
	<li>open he system manager and get the properties of the Exchange Organization,  look under the section"operation mode" and change it if necessary (<em>WARNING: this action can not be reversed)</em></li>
	<li><span><span>check if SP2 for Exchange 2003 is installed</span>, <span>this can be found under Add/remove programs</span></span></li>
</ul>
An easy tool to check these things is the <a href="http://www.microsoft.com/downloads/details.aspx?familyid=DBAB201F-4BEE-4943-AC22-E2DDBD258DF3&amp;displaylang=en" target="_blank">Exchange Best Practice Analyzer</a>, this tool has an option that can check you existing Exchange environment for Exchange 2007 readiness.

After we did the checks on the Exchange 2003 site we can install Exchange 2007 on a server. Before we start the install ensure that the following components are installed on it:

 
<ul>
	<li><span><span>install <a href="http://www.microsoft.com/downloads/info.aspx?na=22&amp;p=2&amp;SrcDisplayLang=en&amp;SrcCategoryId=&amp;SrcFamilyId=&amp;u=%2fdownloads%2fdetails.aspx%3fFamilyID%3d4c84f80b-908d-4b5d-8aa8-27b962566d9f%26DisplayLang%3den" target="_blank">MMC 3.0</a> <em><span>(Windows 2003 R2 <span>already has MMC 3.0 in it</span>)</span></em>

</span></span></li>
	<li><em></em><span><span>install</span> </span><a href="http://www.microsoft.com/downloads/info.aspx?na=22&amp;p=1&amp;SrcDisplayLang=en&amp;SrcCategoryId=&amp;SrcFamilyId=&amp;u=%2fdownloads%2fdetails.aspx%3fFamilyID%3d0856eacb-4362-4b0d-8edd-aab15c5e04f5%26DisplayLang%3den" target="_blank">.NET 2.0</a> <span>and the following <span>hotfix</span>, KB </span><a href="http://support.microsoft.com/kb/926776/" target="_blank">926776</a></li>
	<li><span><span>install</span> </span><a href="http://www.microsoft.com/downloads/info.aspx?na=22&amp;p=2&amp;SrcDisplayLang=en&amp;SrcCategoryId=&amp;SrcFamilyId=&amp;u=%2fdownloads%2fdetails.aspx%3fFamilyID%3d10ee29af-7c3a-4057-8367-c9c1dab6e2bf%26DisplayLang%3den" target="_blank">Powershell 1.0</a></li>
	<li><span><span>install</span> IIS when your are planning to install the Client Access Role on the same server as the mailbox role server.</span></li>
</ul>
<span><span>When you installed all pre-requisites we can start with installing Exchange 2007. If you have Exchange admin privileges but you can't create objects in AD because of the rights you have. Ask an administrator who has enough rights to execute the following commands:</span></span>
<ul>
	<li>setup /PrepareLegacyExchangePermissions of /PL</li>
	<li><span>setup /<span>PrepareDomain</span> of /p</span></li>
</ul>
<span><span>You may think I am missing one, this is correct setup /<span>PrepareLegacyExchangePermissions automaticly executes setup /<span>PrepareAD</span></span></span></span>

<span>I will skip the first three steps because you can choose what you want for those. You can for example end logs to Microsoft if it crashes.</span>

<span>We start with the part where we need to choose which components we like to install.</span>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-4.jpg"><img class="alignnone size-thumbnail wp-image-319" title="Exchange Server 2007 setup" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-4-150x150.jpg" alt="" width="150" height="150" /></a>

<span><span>You have two options here, which one you choose depends on how many servers you have. When you have only one server choose the option <em>Typical Exchange Server Installation</em> this will install the Hub Transport, Client Access, Mailbox Server and Exchange management tools. When you have multiple server then select the option <em>Custom Exchange Server Installation</em>.</span></span>

<span><span>When you made a choice press the <em>next</em> button</span></span>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-5.jpg"><img class="alignnone size-thumbnail wp-image-320" title="Mail flwo settings" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-5-150x150.jpg" alt="" width="150" height="150" /></a>

<span>We like to add Exchange 2007 to an existing Exchange 2003 environment, during the setup you need to decide how mail will be send between the Exchange 2003 and Exchange 2007 environment. This will automatically create a separate routing group connector. Via browse you can choose the server, normally this is the Exchange 2003 server which is the bridge-head server, where you would like to create a routing group connector with.</span>

<span><span>When you have selected the server press <em>next</em></span></span>

<span><span>The setup will check if all pre-requisites are met. If there is something wrong/not installed it will give you a warning. When all problems are solved you can continue with the Exchange installation, press <em>next</em></span></span>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-6.jpg"><img class="alignnone size-thumbnail wp-image-321" title="Readiness Checks" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/step-6-150x150.jpg" alt="" width="150" height="150" /></a>

<span>After waiting a while the setup is ready and you have an Exchange 2007 server in an Exchange 2003 environment.</span>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/ex2003_connectors.jpg"><img class="alignnone size-thumbnail wp-image-322" title="Exchange 2003 connectors" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/ex2003_connectors-150x66.jpg" alt="" width="150" height="66" /></a>

<span>When you start the System Manager from Exchange 2003 and have a look at the connectors you will see the <em>routing group connector</em>which is made during the setup. When you try to modify it you will receive a warning that it can be modified from a Exchange 8.0.30535.0 manager.</span>

<span>During the creation of the <em>routing group connector</em>there will be done a few actions more then only creating it. The setup also creates a seperate <em>administrative group</em> and an apart <em>routing group</em>. This two objects are created so that Exchange 2003 and Exchange 2007 can cooperate with each other. In Exchange 2003 you had the possibility to assign delegates per <em>administrative group</em>. In Exchange 2007 there is only one <em>administrative group</em> where all Exchange 2007 servers reside.  This group has the following name <em>FYDIBOHF23SPDLT</em>. According to some web page's this name is created during a cipher has, the original text is EXCHANGE12ROCKS!<em> </em></span>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/ex2003_admin.jpg"><img class="alignnone size-thumbnail wp-image-323" title="Administrative groups" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/ex2003_admin-150x50.jpg" alt="" width="150" height="50" /></a>

<span>Maybe you do now have a question ? Why is there an apart <em>routing group connector</em> created ? Exchange 2003 uses the <em>routing group connector </em>to decide how a mail is delivered to another Exchange Server. In Exchange 2007 this is done by creating separate sites in <em>Active Direcory</em>. The <em>routing group</em> created during installation is calles</span><span> </span><em>DWBGZMFD01QNBJR</em>.

<span>All the users that have a mailbox on the Exchange 2007 server need to be administrated via the <em>Exchange Management Console, </em>users who have their mailbox on an Exchange 2003 server need to be administrated from the <em>System Manager</em>.</span>

<span>Moving users from the old server to the new server is not an issue. The only disadvantage of it is that you can't do it via the GUI, you will have to do it via Powershell</span><em>move-mailbox -TargetDatabase "Ex2007 Server\First Storage Group\Mailbox Database -identity UserName</em>

<span>It's no issue to move mailboxes between Exchange 2003 and Exchange 2007 there is only one remark. Exchange 2007 has an other way of working with "rules" which are created by the clients. The parameter <em>IgnoreRuleLimitErrors</em> can be added to the command to prevent migrating the rules the user created in Outlook, this is only neede when moving a mailbox from Exchange 2007 to Exchange 2000/2003.</span>

<span>This was another tutorial on Exchange 2003, the next tutorial will probably be how to remove the Exchange 2003 server from the environment.</span>