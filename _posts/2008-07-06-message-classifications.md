---
id: 387
title: Message Classifications
date: 2008-07-06T21:38:49+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=387
permalink: /message-classifications/
categories:
  - Exchange
---
A new feature within Exchange 2007 is message classification. With this you can assign a classification to an e-mail and for example create a transport rule which blocks e-mails of certain classifications.

This functionality can only be used in combination with Outlook 2007 client and Outlook Web Access. Default Exchange 2007 contains 5 message classifications:
<ul>
	<li>A/C Privileged</li>
	<li>Attachment Removed</li>
	<li>Company Confidential</li>
	<li>Company Internal</li>
	<li>Partner Mail</li>
</ul>
You can get the current message classifications by executing the following Powershell command:

```PowerShell
Get-MessageClassifications
```

This will give the following result:

<a href="https://myuclab.nl/wp-content/uploads/2008/07/get-messageclas.jpg"><img class="alignnone size-thumbnail wp-image-388" title="Get message classifications" src="https://myuclab.nl/wp-content/uploads/2008/07/get-messageclas-150x119.jpg" alt="" width="150" height="119" /></a>

You can make new message classifications with the following command <em>new-messageclassification</em> and a few parameters.

```PowerShell
New-MessageClassification -name Marketing  -DisplayName "Marketing Confidential" -SenderDescription "This classification must be used by the marketing department"
```

In the example above we will create a new message classification named <em>Marketing.</em>  After that we assign the name that will be displayed in the client as <em>Marketing Confidential</em>  and with the last parameter <em>senderdescription </em>we can give a short description of the classification which will be displayed to the user when selected.

This classification will be used for all languages including Dutch. You can type the <em>senderdescription </em>in Dutch, but you can also add multiple languages. The client will then decide which language it needs, looks if it is available and if it it will display the correct language.

```PowerShell
New-MessageClassification -Identity Marketing -Locale nl-NL -DisplayName "Marketing NL" -SenderDescription "Deze classificatie mag alleen gebruikt worden door de marketing afdeling"
```

With the parameters above we will create a Dutch message classification for the earlier created message classification <em>Marketing. </em>That this one is only for dutch is because we specified the parameter <em>-Locale</em>  followed by the language. With the parameter <em>identity</em>  we select the original message classification <em>Marketing. </em>De other parameters <em>displayname </em>and <em>senderdescription </em>have both the same function as when creating a new message classification.

Default all users can use a message classification, you can prevent this:

```PowerShell
Get-MessageClassification Marketing -IncludeLocales |Remove-AdPermission -User AU -AccessRights GenericRead -InheritanceType None
```

With the command above we remove the right the <em>authenticated users</em> have on the <em>Marketing </em>message classification.

```PowerShell
Get-MessageClassification Marketing  -IncludeLocales | Add-AdPermission -User "domainname\Marketing" -AccessRights GenericRead -InheritanceType None
```

Next step will be to assign read rights to the members of the group Marketing to the <em>Marketing </em>message classification.

There are a few thinks you should keep in mind when you are gone use message classifications. In OWA it will work but in Outlook 2007 you can't totally prevent users from using a message classification. This is because users can modify the file <em>Classifications.xml </em>which will allow them to add the message classification to their client.

But it is a way to make it more difficult for a user to use it.

In the previous part we spoke about message classification in Outlook 2007. In OWA you don't have to configure anything for message classification but for Outlook 2007 you need.

<a href="https://myuclab.nl/wp-content/uploads/2008/07/owa.jpg"><img class="alignnone size-thumbnail wp-image-389" title="OWA message classification" src="https://myuclab.nl/wp-content/uploads/2008/07/owa-150x150.jpg" alt="" width="150" height="150" /></a>

Configuring Outlook 2007 takes two steps:
<ul>
	<li>create registry keys</li>
	<li>create classifications.xml</li>
</ul>
Before you using the classifications.xml you need to create the registrykeys as displayed below:

```Console[HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Common\Policy]

"AdminClassificactionPath"="c:\\Program Files\\Office\\Classifications.xml"

"EnableClassifications"=dword:00000001

"TrustClassifications"=dword:00000001
```
All the parameters are logical, except the last one. The parameter <em>TrustClassifications</em> only needs the value  00000001 when the mailbox of a user is placed on an Exchange 2007 server.

The last step is creating the <em>classifications.xml </em>file<em>.</em> This step needs to be performed on the Exchange 2007 server. Microsoft has developed a standard script for it and placed it in the script directory of Exchange 2007, it called <em>Export-OutlookClassification.ps1</em>

```PowerShell
./Export-OutlookClassifications.ps1  c:\export\classifications.xml
```

Make sure the folder to which you want to export exists, else you will get an error message The command above will create a xml file called classifications.xml in the export directory.

You can also choose to only export the Dutch language message classifications:

./Export-OutlookClassifications.ps1 -Locale "nl" &gt;Classifications.xml

As you can see only <em>nl </em>is used instead of <em>nl-NL </em>both are the same, for a full overview have a look at this  <a href="http://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx" target="_blank">page</a>.

Message classifications can be used in <em>transport rules. </em>You could do a check if a message is marked with a specific message classification and block the e-mail.

Besides that option you can also let a <em>transport rule </em>assign a classification to a mail according to the conditions you specify.

<a href="https://myuclab.nl/wp-content/uploads/2008/07/tr_rule_mc.jpg"><img class="alignnone size-thumbnail wp-image-390" title="Set message classification via Transport Rule" src="https://myuclab.nl/wp-content/uploads/2008/07/tr_rule_mc-150x92.jpg" alt="" width="150" height="92" /></a>