---
id: 987
title: Dynamic Distribution Groups
date: 2008-12-05T17:07:13+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=987
permalink: /dynamic-distribution-groups/
categories:
  - Exchange
---
It has been a while ago so it's time for a new tutorial.</p>
<p>This tutorial will be about dynamic distribution groups, a new feature in Exchange 2007. With a dynamic distribution group you can create a group which members will be selected according to a filter you specify. Each time a mail is send to this group a query will be done to select the users who are a member of the group.</p>
<p>There are two methods to create a dynamic distribution group:</p>
<ul>
<li>via the Exchange Management Console</li>
<li>via the Exchange Management Shell</li>
</ul>
<p><strong>Dynamic Distribution Group via the Exchange Management Console</strong></p>
<p>We start with the first method, for this you will need to startup the Exchange Management Console and go to <em>groups</em> via <em>recipient configuration </em>.</p>
<p>When you have selected the <em>groups </em>icon you can select the option <em>new dynamic distribution group </em>in the right menu to start the wizard.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/step1.jpg"><img class="alignnone size-thumbnail wp-image-965" title="Dynamic Distribution group wizard" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/step1-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>You will be presented the screen above, here we can define a name for the new dynamic distribution group. When the name has been defined you can click on <em>next</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/step2.jpg"><img class="alignnone size-thumbnail wp-image-966" title="Dynamic Distribution Group - filter settings" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/step2-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The next step is to define the filter, here we need to define from which OU the members will be selected. The other thing we can define here is which objects will be selected from the OU. Standard all objects will be selected but if you have an OU which different types of objects you can specify for example only Exchange Mailbox users.</p>
<p>When your statisfied with the filter click on <em>next</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/step3.jpg"><img class="alignnone size-thumbnail wp-image-967" title="Dynamic Distribution Group - conditions" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/step3-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The next step is to define the conditions which a user must met to be a member of the group. As you can see in the screenshot there are a few fields displayed at step 1. When you wish to use another field will need to create the group via the Exchange Management Shell.  This is described later in this tutorial.</p>
<p>In this case we would like to select all people who work in the IT department, therefor we select the option  <em>Recipient is in a Department, </em>in the lower part of the screen we must define the condition. By clicking on <em>specified </em>we can specify a value. When clicking on it you will see the following screenshot.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/step3a.jpg"><img class="alignnone size-thumbnail wp-image-968" title="Dynamic Distribution Group - Specify department" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/step3a-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Here we specify the value which we want to use in our filter, in this case <em>IT. </em>When you have specified all values you can click on <em>OK.</em></p>
<p>Now we have provided all necessary values we will get a short overview of what we are going to configure.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/step4.jpg"><img class="alignnone size-thumbnail wp-image-969" title="Dynamic Distribution Group - New" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/step4-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When we are satisfied with this we click on <em>new, </em>after this the new dynamic distribution group will be created.</p>
<p>Now we created the new group we would like to know which users are a member of it. To find this out we need to get the properties of the group.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/members.jpg"><img class="alignnone size-thumbnail wp-image-970" title="Dynamic Distribution Group - Conditions tab" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/members-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Next thing is to select the tab <em>conditions </em>and push the button <em>preview</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/members_2.jpg"><img class="alignnone size-thumbnail wp-image-971" title="Dynamic Distribution Group - Preview" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/members_2-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>An overview of the users who are a member of the group will be displayed.</p>
<p>Standard only mail from authenticated users will be accepted. This is to prevend people from the internet sending mail to this group. When you would like to enable this group for receiving mail from the internet we need to configure this. This can be done on the tab <em>Mail Flow Settings</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/messagedelivery.jpg"><img class="alignnone size-thumbnail wp-image-972" title="Dynamic Distribution Group - Mail Flow Settings tab" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/messagedelivery-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When you opened the tab select the item <em>Message Delivery Restrictions </em>and click the button <em>properties.</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/messagedelivery_2.jpg"><img class="alignnone size-thumbnail wp-image-973" title="Dynamic Distribution Group - Message Delivery Restrictions" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/messagedelivery_2-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In the upper part of the screen you will see <em>accept messages from </em>below that title you will find the option <em>require that all senders are authenticated, </em>remove the checkmark before the option to accept mail from the internet. </p>
<p><strong>Dynamic Distribution Group via the Exchange Management Shell</strong></p>
<p>As mentioned earlier we can create a dynamic distribution group via two methods. The second method is via Powershell. You can do this by using the command <em>new-DynamicDistributionGroup</em>. It can be done via an easy or by are more complex way. Can we specify only a few fields in the EMC, in Powershell we can filter on much more fields.</p>
<p>But that's for later, let's start with the easy version:</p>

```PowerShell
New-DynamicDistributionGroup -IncludedRecipients MailboxUsers -Name "Rotterdam DDG" -OrganizationalUnit Rotterdam
```

<p>The command above will select all users with an Exchange Mailbox from the OU <em>Rotterdam </em>and will add them to a dynamic distribution group <em>Rotterdam DDG.</em></p>
<p><em><a href="https://johanveldhuis.nl/wp-content/uploads/2008/12/new-ddg.jpg"><img class="alignnone size-thumbnail wp-image-977" title="New-DynamicDistributionGroup" src="https://johanveldhuis.nl/wp-content/uploads/2008/12/new-ddg-150x89.jpg" alt="" width="150" height="89" /></a></em></p>
<p>When we want to view the users who are a member of this group we need to use the following 2 commands:</p>

```PowerShell
$RotterdamOffice = Get-DynamicDistributionGroup -Identity "Rotterdam DDG"
Get-Recipient -RecipientPreviewFilter $RotterdamOffice.RecipientFilter (SP1)
Get-Recipient -Filter $RotterdamOffice.RecipientFilter (RTM)
```

<p>The first rule will save the group in a parameter. The second rule will get all users from this distribution group. There are two versions of it, one for the RTM version and the other vor the SP1 version.</p>
<p>Now we showed the easy way let's make one via the complex way.</p>

```PowerShell
New-DynamicDistributionGroup -name Test  -RecipientFilter {(UserPrincipalName -like </em><em>'*@test.local'</em><em>)}</em></p>
<p>The command above will create a new distribution group with the name <em>Test. </em>Here we select only users with a UPN that ends with <em>test.local
```

<p>You can make it more complex if you want, for example you can filter on more conditions</p>

```PowerShell
New-DynamicDistributionGroup -Name AllTestIT -OrganizationalUnit test.local/Utrecht/Users -RecipientFilter { ((RecipientType -eq 'UserMailbox') -and (Company -eq 'Test')) }
```

<p>This command will create a new distribution group with the name <em>AllTestIT </em>and select the users only from the OU <em>Utrecht/Users </em>with an Exchange Mailbox and which are working at the company <em>Test</em>.</p>
<p>You can make it as complex as you want by adding more parameters. For a full overview of the fields you can use have a look at this <a href="http://technet.microsoft.com/en-us/library/bb738155.aspx" target="_blank">site</a></p>
<p><strong>Technet articles</strong></p>
<p><a href="http://technet.microsoft.com/en-us/library/aa996561.aspx" target="_blank">How to Create a New Dynamic Distribution Group</a></p>
<p><a href="http://technet.microsoft.com/en-us/library/bb124268.aspx" target="_blank">Creating Filters in Recipient Commands</a></p>
<p><a href="http://technet.microsoft.com/en-us/library/bb430744.aspx" target="_blank">Filterable Properties for the -Filter Parameter in Exchange 2007 RTM</a></p>
<p><a href="http://technet.microsoft.com/en-us/library/bb738155.aspx" target="_blank">Filterable Properties for the -Filter Parameter in Exchange 2007 SP1</a></p>
<p><a href="http://technet.microsoft.com/en-us/library/bb232019.aspx" target="_blank">How to View Members of a Dynamic Distribution Group</a>