---
id: 173
title: Create a user via Powershell
date: 2008-03-16T12:05:42+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=173
permalink: /create-a-user-via-powershell/
categories:
  - Exchange
---
This tutorial will explain how you can create users via Powershell.

The first thing we need to do is start Exchange Management Shell, you will find it in the startmenu under <em>Microsoft Exchange Server 2007.</em>

<a title="Powershell" href="https://myuclab.nl/wp-content/uploads/2008/03/step1.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/step1.thumbnail.jpg" alt="Powershell" /></a>

As you can see above there are a few commands displayed for example a command is displayed to display the help functionality. There is also a nice joke build in the Exchange 2007 Powershell, when you type in get-exblog it opens Internet Explorer with the Exchange 2007 Community.

The next step is the command we will need to create the user, it will look something like the following:

```PowerShell
New-Mailbox -Alias <alias> -Name <name> -Database <Database name> -OrganizationalUnit <OU name> -UserPrincipalName <UPN value> 
```

When you execute this command there are a few parameters which are needed:
<ul>
	<li>alias</li>
	<li>name</li>
	<li>database</li>
	<li>organizationalunit</li>
	<li>userprincipalname</li>
</ul>
Below an example, this command will create a user <em>johan </em>with an UPN <em>johan@test.local</em> in the OU <em>utrecht</em> in the database <em>mailbox store.</em>

<a title="User aanmaken" href="https://myuclab.nl/wp-content/uploads/2008/03/step2.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/step2.thumbnail.jpg" alt="User aanmaken" /></a>

When you execute the command there is one thing missing, the password, Powershell will ask you for it.

<a title="Specify password" href="https://myuclab.nl/wp-content/uploads/2008/03/step3.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/step3.thumbnail.jpg" alt="Specify password" /></a>

When you typed in a password the user will be created and the the result will be like the screen below:

<a title="The user is created" href="https://myuclab.nl/wp-content/uploads/2008/03/step4.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/step4.thumbnail.jpg" alt="The user is created" /></a>

Of course there are more possibilities, the user we just created doesn't get assigned managed folders. By adding the parameter -ManagedFolderMailboxPolicy &lt;name policy&gt; the user will be assigned this policy and will get managed folders. There are a few other parameters:
<ul>
	<li>ActiveSyncMailboxPolicy</li>
	<li>ResetPasswordOnNextLogon</li>
	<li>WhatIf</li>
</ul>
Especially the last command is interesting if you are not sure what you are doing. This parameter will execute the command but not for real. The result will be displayed after it did the test run, if the result is OK you can remove the WhatIf and run it for real.