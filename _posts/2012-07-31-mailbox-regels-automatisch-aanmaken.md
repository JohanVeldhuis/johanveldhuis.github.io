---
id: 2491
title: Provisioning mailbox rules
date: 2012-07-31T16:56:07+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2491
permalink: /mailbox-regels-automatisch-aanmaken/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2012/07/inbox-rule.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
You may not see it in every organization but in a lot of organizations Outlook rules are used to automate some tasks such as: moving item to another folder, auto reply on messages, etc.

In this blog we will have a look at how to provision Outlook rules for a user so they won’t have to create them. But first have a look at the rules. As you may know you can configure both server and client side rules in Outlook. But what’s the difference between them?

  * Server side rules: are executed at the server side and so they are always running;
  * Client side rules: are execute at the client side and will only work when Outlook or OWA is running;

Most of the rules you can configure are client side rules and only a few of them are server side rules. One example of a server side rule is auto replying with a message on a new arrived e-mail.

To provision Outlook rules you can use the _New-InboxRule_ cmdlet this cmdlet will give you the ability to create inbox rules for every user. So let’s have a look at an example.

_New-InboxRule ‘Spam Summary’ -Mailbox johan -From antispam@domain.com -SubjectContainsWord “Spam Summary“ -MoveToFolder ’ johan:\ Spam Summary’_

The rule above will be applied to all messages which are sent to my mailbox and are sent from [_antispam@domain.com_](mailto:antispam@domain.com) and have as subject _Spam Summary_. The rule will move the specific message to the folder Spam Summary. One remark must be made about the folder. The folder must exist if not you will get a warning.

So wouldn’t it be nice to automate the complete process when a new mailbox is created? If this is what you want cmdlet extensions are the answer. With cmdlet extensions you can extend cmdlets by executing additional cmdlets after the first cmdlet has been executed.

In this example we would only like to create the new folder and the Outlook rule after a new mailbox is created. So the cmdlet which needs to be extended is _New-Mailbox_.

The first step in the process will be to modify the _ScriptingAgentConfig.xml.sample._ This file can be found here: \V14\Bin\CmdletExtensionAgents. First make a backup of the original XML before making any changes. Once the backup is rename the file and remove the _.sample_ extension and open it in an editor, for example Notepad.

_if($succeeded) {_
  
$newmailbox = $provisioningHandler.UserSpecifiedParameters[&#8220;Name&#8221;]
  
$newfolder= $newmailbox + _’__:\Spam Summary__’___
  
New-MailboxFolder -Parent $newmailbox -Name _’__Spam Summary__’_
  
New-InboxRule ’Spam Summary’ -Mailbox $newmailbox -From antispam@domain.com &#8211;_
  
SubjectContainsWord ’Spam Summary’ -MoveToFolder $newfolder }_

We are using two parameters:

  * _$newmailbox_: contains the name of the created mailbox
  * _$newfolder_: the name of the folder we want to create in the mailbox

After the parameters have been defined we will first create the new folder using the _New-MailboxFolder_ cmdlet and then use create the new rule using _New-InboxRule_ cmdlet.

Now save this file and copy it to each Exchange server in your environment. The next step is to enable the scripting agent. If you don’t do it the script simply won’t be executed.

To enable the scripting agent open the Exchange Management Shell (EMS) and run the following cmdlet:

_Enable-CmdletExtensionAgent &#8220;Scripting Agent&#8221;_

Repeat this step on every Exchange server in your environment.

Now we configured everything it’s time to see if it really works. Create a new mailbox via either the Exchange Management Console or Shell. After the mailbox is created verify if a new folder and rule are created successfully by logging into OWA or by using Outlook.

So let’s verify if it really works. In this example we just created a user called _provisioned_user_:

_new-mailbox -name provisioned\_user -alias provisioned\_user -UserPrincipalName provisioned_user@corp.local_

When running the cmdlet with the _–verbose_ parameter you will see that the Cmdlet Extension Agent is executed after the mailbox has been created:

[<img title="New mailbox with cmdletextension agent enabled" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/new-mailbox-300x79.png?resize=300%2C79" alt="" width="300" height="79" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/new-mailbox.png)

Now the mailbox has been created let’s verify if the new folder and inbox rule have been created. We will use OWA to verify if both have been created. When logging in to OWA you will see that the folder has been created:

[<img title="Mailbox folders" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/folders.png?resize=174%2C204" alt="" width="174" height="204" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/folders.png)

When opening the _Exchange Control Panel (ECP)_ and select the _Organize E-mail_ option in the left menu you will see that an inbox rule has been created:

[<img title="New inbox rule" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/inbox-rule-300x106.png?resize=300%2C106" alt="" width="300" height="106" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/07/inbox-rule.png)

So as you can see you can provision the anti-spam folder and rule for new mailboxes using the cmdlet extensions. Besides doing this kind of things several other options can be configured using this option. Some examples are:

  * Disable POP3
  * Disable IMAP
  * Set the Regional Configuration/Language

For more information you can have a look at the following pages:

  * Using Cmdlet Extension Agents to cause automatic events to occur in Exchange 2010 – life just got simpler!: <a href="http://www.ehloworld.com/194" target="_blank">open</a>
  * Cmdlet Extension Agents Part 1: Automatic archive creation: <a href="http://eightwone.com/2011/08/24/automatic-archive-provisioning-with-cmdlet-extension-agents/" target="_blank">open</a>

<div id="UMS_TOOLTIP" style="z-index: 2147483647; position: absolute; display: none; background: none transparent scroll repeat 0% 0%; cursor: pointer;">
  <img id="ums_img_tooltip" class="UMSRatingIcon" alt="" />
</div>