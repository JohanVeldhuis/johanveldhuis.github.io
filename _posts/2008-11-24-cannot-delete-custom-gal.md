---
id: 951
title: 'Can&#8217;t delete custom GAL'
date: 2008-11-24T22:41:11+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=951
permalink: /cannot-delete-custom-gal/
categories:
  - Exchange
---
In Exchange 2007 you can create a custom GAL. Creating the custom GAL can be done via the EMC of Powershell.

```PowerShell
New-GlobalAddressList -Name &#8220;Custom GAL&#8221; -IncludedRecipients MailboxUsers -ConditionalCompany Test
```

</em>The Powershell command above will create a GAL containing all the users from the company _Test_But what should you do if you can&#8217;t delete your custom GAL and it stays visible in OWA ? Then we need to use Powershell again. First we execute the following command

```PowerShell
Get-OfflineAddressBook | Update-OfflineAddressBook
```
<span>This command will get all the available offline addressbooks and will ensure they get updated. When you have done this you need to restart the File Distribution Service using the following command</span>


    
```Console
issreset /noforce
```
When you open OWA after executing the command you will see that the addressbook has been removed.