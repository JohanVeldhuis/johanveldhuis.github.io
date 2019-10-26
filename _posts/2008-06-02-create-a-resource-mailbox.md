---
id: 365
title: Create a resource mailbox
date: 2008-06-02T20:14:47+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=365
permalink: /resource-mailbox-aanmaken/
categories:
  - Exchange
---
In the previous versions of Exchange you need to do some tricks to create a resource mailbox. In Exchange 2007 it's a default option to create one, via the both the GUI and the shell.

First we will add a box via the <em>Exchange Management Console</em>. This goes nearly the same as creating a user, select one other option and you have a resource mailbox.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_1.jpg"><img class="alignnone size-thumbnail wp-image-356" title="New mailbox (room)" src="https://myuclab.nl/wp-content/uploads/2008/06/step_1-150x150.jpg" alt="" width="150" height="150" /></a>

In the first field we choose for a <em>room</em> or <em>equipment</em> <em>mailbox</em> in this example we choose for a <em>room mailbox</em>. And we will click <em>next </em>to continue.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_2.jpg"><img class="alignnone size-thumbnail wp-image-357" title="New user" src="https://myuclab.nl/wp-content/uploads/2008/06/step_2-150x150.jpg" alt="" width="150" height="150" /></a><a href="https://myuclab.nl/wp-content/uploads/2008/06/step_6.jpg"></a><a href="https://myuclab.nl/wp-content/uploads/2008/06/step_5.jpg"></a>

In the next screen you have the ability to create a new user or assign the box to an existing user. We will create a new user.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_3.jpg"><img class="alignnone size-thumbnail wp-image-358" title="New mailbox" src="https://myuclab.nl/wp-content/uploads/2008/06/step_3-150x150.jpg" alt="" width="150" height="150" /></a>

The next step will be providing the user details, in this case we will create a user called <em>boardroom</em>. The password is pure formality and you don't need it in most cases especially when you create a box which autoaccepts meetingrequests.

Click on <em>next </em>when ready

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_4.jpg"><em><img class="alignnone size-thumbnail wp-image-359" title="Mailbox settings" src="https://myuclab.nl/wp-content/uploads/2008/06/step_4-150x150.jpg" alt="" width="150" height="150" /></em></a>

In the <em>mailbox settings</em> screen we decide on which <em>mailbox server</em> the mailbox will be created and in which <em>storage group </em>and<em> mailbox database</em>. The two policy options you mostly don't user while creating a <em>resource mailbox.</em>

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_5.jpg"><img class="alignnone size-thumbnail wp-image-360" title="Mailbox created" src="https://myuclab.nl/wp-content/uploads/2008/06/step_5-150x150.jpg" alt="" width="150" height="150" /></a><a href="https://myuclab.nl/wp-content/uploads/2008/06/step_6.jpg"></a>

A few times clicking on next and the <em>resource mailbox</em> is created.

All the previous steps can be done faster with Powershell. Actually there are more option in Powershell then in the GUI. You can for example add the <em>-room </em>parameter to a resource mailbox of the type room to add accessoires. When choosing for a resource mailbox of the type <em>equipment</em> then you can use the -<em>equipment</em>  to do this.

```PowerShell
New-Mailbox -UserPrincipalName boardroom2@test.local -database "First Storage Group\Mailbox Database" -Name "Boardroom 2" -OrganizationalUnit Users -DisplayName "Boardroom 2" -ResetPasswordOnNextLogon $false -Room
```

With the command above we will create a <em>resource mailbox</em> with the name <em>boardroom2.</em>

Let's add some extra accessoires to it, for this we will need to do two things:
<ul>
	<li>create the accessoire</li>
	<li>add the accessoire to the resource mailbox</li>
</ul>
Creating new accessoires can only be done via Powershell:

```PowerShell
Set-ResourceConfig -DomainController fqdn.dc  -ResourcePropertySchema Room/Networkprojector
```

In the exampe above we added a beamer to the list of accesoires. You can also add multiple accesoires at one time:

```PowerShell
Set-ResourceConfig -DomainController fqdn.dc -ResourcePropertySchema ('Room/16Seats','Equipment/Projector','Room/8Seats','Equipment/Whiteboard')
```

The next step will be to assign the accesoires to the <em>resource mailbox</em>. This can be done within the  <em>Exchange Management Console</em>. First we will need to get the <em>properties </em>of the <em>resource mailbox </em>and click on the tab <em>Resource Information</em>.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_61.jpg"><img class="alignnone size-thumbnail wp-image-363" title="Resource information" src="https://myuclab.nl/wp-content/uploads/2008/06/step_61-150x150.jpg" alt="" width="150" height="150" /></a>

In the screen that opens you can click <em>Add</em> to add accessoires to the object:

<a href="https://myuclab.nl/wp-content/uploads/2008/06/step_7.jpg"><img class="alignnone size-thumbnail wp-image-364" title="Select Resource" src="https://myuclab.nl/wp-content/uploads/2008/06/step_7-150x150.jpg" alt="" width="150" height="150" /></a>

A new windows will be opened where we can select the beamer we just created and assign it to the <em>resource mailbox</em>.

It would be easier if the <em>boardroom</em>can autoaccept meetingrequests and look for availability of the room. In Exchange 2003 this was already possible via a few clicks, in Exchange 2007 this can easily done via the Powershell:

```PowerShell
Set-MailboxCalenderSettings boardroom -AutomateProcessing:AutoAccept
```

In case you would not like to use the autoaccept functionality you need to assign <em>delegates</em> to the resource mailbox

```PowerShell
Set-MailboxCalenderSettings -Indentity "boardroom" -ResourceDelegates "Pietje Puk"
```

In the example above we will assign <em>Pietje Puk </em>as a delegate of the <em>boardroom.</em>