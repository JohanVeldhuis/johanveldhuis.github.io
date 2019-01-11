---
id: 951
title: 'Can&#8217;t delete custom GAL'
date: 2008-11-24T22:41:11+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=951
permalink: /custom-gal-kan-niet-verwijderd-worden/
categories:
  - Exchange
---
In Exchange 2007 you can create a custom GAL. Creating the custom GAL can be done via the EMC of Powershell.

<div>
  <em>New-GlobalAddressList -Name &#8220;Custom GAL&#8221; -IncludedRecipients MailboxUsers -ConditionalCompany Test</em>
</div>

_ </p> 

</em>The Powershell command above will create a GAL containing all the users from the company _Test_But what should you do if you can&#8217;t delete your custom GAL and it stays visible in OWA ? Then we need to use Powershell again. First we execute the following command

<div>
  <em><span style="font-family: 'Verdana';">Get-OfflineAddressBook | Update-OfflineAddressBook</span></em><em><span style="font-family: 'Verdana';"> </span></em></p> 
  
  <div>
    <span style="font-family: 'Verdana';">This command will get all the available offline addressbooks and will ensure they get updated. When you have done this you need to restart the File Distribution Service using the following command</span>
  </div>
  
  <p>
    <span style="font-family: 'Verdana';"></p> 
    
    <div>
      <em>issreset /noforce</em>
    </div>
    
    <p>
      <em> </p> 
      
      <p>
        <span style="font-family: 'Verdana';">When you open OWA after executing the command you will see that the addressbook has been removed.</span></em></span></div>