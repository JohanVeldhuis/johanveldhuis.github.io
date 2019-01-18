---
id: 316
title: Install anti-spam agents on the Hub Transport server
date: 2008-04-15T21:02:06+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=316
permalink: /install-anti-spam-agents-on-the-hub-transport/
categories:
  - Exchange
---
Propably every one has to do with spam today, sometimes you receive more spam then normal mail. There are a few anti-spam solutions which try to prevent spam mails in the users inbox, for example the <a href="http://www.fortinet.com/products/fortimail.html" target="_blank">Fortimail</a> from <a href="http://www.fortinet.com" target="_blank">Fortinet</a> or the <a href="http://emea.trendmicro.com/emea/products/enterprise/interscan-messaging-security-suite/index.html" target="_blank">IMSS</a> from <a href="http://www.trendmicro.com" target="_blank">Trend Micro</a>.

Exchange 2007 includes a few anti-spam agent to prevent spam. This filters are active by default on the Edge Transport server but also can be activated on the Hub Transport server by executing the following command in Powershell:

```PowerShell
./install-AntispamAgents.ps1
```

This command needs to be executed from the scripts directory, you will find it in the Exchange install directory.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-1.jpg"><img class="alignnone size-thumbnail wp-image-289" title="Install Antispam agents" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-1-150x150.jpg" alt="" width="150" height="150" /></a>

When the command is executed you need to restart the <em>Transport Services</em>, this can be done by executing the following command:

```PowerShell
Restart-Service MSExchangeTransport</em>
```

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-2.jpg"><img class="alignnone size-thumbnail wp-image-290" title="Restart Transport services" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-2-150x150.jpg" alt="" width="150" height="150" /></a>

After restarting the <em>Transport Services</em> you can open the <em>Exchange Management Console</em>, when it is opened click on the <em>Organizational Configuration </em>and then choose <em>HUB Transport</em>. You will see there's an extra tab added named <em>Anti-Spam</em>, click on it

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-3.jpg"><img class="alignnone size-thumbnail wp-image-291" title="Exchange Management Console" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-3-150x150.jpg" alt="" width="150" height="150" /></a>

You will see the <em>anti-spam agents</em> that are installed:
<ul>
	<li>content filtering</li>
	<li>IP Allow list</li>
	<li>IP Allow list providers</li>
	<li>IP Block list</li>
	<li>IP Block list providers</li>
	<li>Recipient filtering</li>
	<li>Sender filtering</li>
	<li>Sender ID</li>
	<li>Sender reputation</li>
</ul>
Below the agents are described per agent:

<strong>Content Filtering</strong>

With this agent you can filter on keywords. For example you can filter on the words Make Money Fast, this can be seen below. But when you have a company that does sell <em>Hovercrafts</em> you don't want mail with that word ends up in the junk mail. This word can be added to the top of the screen in the section named <em>Messages with these words or phrases will not be blocked</em>.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-4.jpg"><img class="alignnone size-thumbnail wp-image-292" title="Content Filtering Properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-4-150x150.jpg" alt="" width="150" height="150" /></a>

Besides the last called option there is a possibility to exclude mail-adresses from filtering. This can be done on the tab <em>Exceptions</em>.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-5.jpg"><img class="alignnone size-thumbnail wp-image-293" title="Customer Filtering Properties Exceptions" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-5-150x150.jpg" alt="" width="150" height="150" /></a>

The final step is deciding which action needs to be executed, this can be: delete, reject or quarantaine. Per action you can define when it needs to be executed. Which action is executed depends on the SCL (Spam Confidence Level), this is determined by the IMF (Intelligent Message Filter) i.c.w. de words we setup earlier. When you are gone experimentate with the filter, for example put the SCL values lower. Then I would suggest to first choose the action to quarantaine it before choosing delete/reject as the action. This will safe you a lot of angry end-users that don't receive their normal mail anymore.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-6.jpg"><img class="alignnone size-thumbnail wp-image-294" title="Content Filtering Properties Actions" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-6-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commands:</em>

```PowerShell
Set-ContentFilterConfig -SclQuarantineEnabled:$true -SclRejectEnabled:$true -SclDeleteEnabled:$true -SclQuarantineThreshold 5 -SclRejectThreshold 6 -SclDeleteThreshold 8 -QuarantineMailbox spamQ@contoso.com -RejectionResponse ”Message rejected due to content restrictions” -AuthenticatedMessageBypassEnabled:$true -PuzzleValidationEnabled:$true -BypassedRecipients user1@contoso.com, user2@contoso.com
```

The content filter will be activated with the following options:
<ul>
	<li>Quarantaine will be activated for all mails with a SCL of 5 words will be placed in it, the quarantaine box has the following address spamQ@contoso.com</li>
	<li>Reject will be activated for all mails met a SCL if 6  this mails will be bounced, senders of the mail will get a mail back that their mail is bounced with the following text in it ”Message rejected due to content restrictions”.</li>
	<li>Delete will be activated for all mails with a SCL of 8 will be deleted</li>
	<li>When mail is sent to <a href="mailto:user1/user2@contoso.com">user1/user2@contoso.com</a> the filter will not be applied.</li>
	<li>It turns on Autenticated Message Bypass</li>
	<li>It turns on Puzzle Validation</li>
</ul>
<a href="http://technet.microsoft.com/en-us/library/aa996791(EXCHG.80).aspx" target="_blank">Get-ContentFilterConfig</a> returns the current settings for the Content filter agent

<a href="http://technet.microsoft.com/en-us/library/bb124135(EXCHG.80).aspx" target="_blank">Add-ContentFilterPhrase</a>-Phrase:"This is an e-mail that you don't want to receive" -Influence:BadWord

This command will add "This is an e-mail that you don't want to receive" to the list of forbidden words or sentences. 

<a href="http://technet.microsoft.com/en-us/library/aa996785(EXCHG.80).aspx" target="_blank">Get-ContentFilterPhrase</a> returns the current settings for the Content filter phrase agent

<a href="http://technet.microsoft.com/en-us/library/bb124989(EXCHG.80).aspx" target="_blank">Remove-ContentFilterPhrase</a> -Identity "This is an e-mail that you don't want to receive"

This command will delete "This is an e-mail that you don't want to receive" from the list of of forbidden words or sentences. 

<strong>IP Allow List</strong>

As the name already tells you this agent lets you create IP-address white-lists. This can be used for business-relations that are on a black-list but you still want to receive mail from them. When clicking on <em>Add</em>you can add an ip-address of ip-range.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-7.jpg"><img class="alignnone size-thumbnail wp-image-295" title="IP Allow list" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-7-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Set-IPAllowListConfig -InternalMailEnabled:$true -DomainController ad-server.test.nl
```

With this command you will setup the DC on which the IP allow list needs to be saved/

<a href="http://technet.microsoft.com/en-us/library/aa998609(EXCHG.80).aspx" target="_blank">Get-IPAllowListConfig</a> returns the current settings for the  IP Allow list agent

```PowerShell
Add-IPAllowListEntry -IPRange:192.168.0.1/24
```

Adds the IP-range 192.168.0.1/24 to the IP Allow list

<a href="http://technet.microsoft.com/en-us/library/bb123576(EXCHG.80).aspx" target="_blank">Get-IPAllowListEntry</a> returns the current settings for the specific IP Allow list entry

<a href="http://technet.microsoft.com/en-us/library/bb124341(EXCHG.80).aspx" target="_blank">Remove-IPAllowListEntry</a> -Identity &lt;Integer&gt; removes IP-address/the IP-range from the IP Allow list where the integer is the <em>id</em>  from the specific rule.

<strong>IP Allow List Providers</strong>

Besides RBL providers there are white-list providers. This are providers who provide lists with <em>safe </em>IP-addresses. On the following site you will find an overview of Whitelist providers: <a href="http://www.spamlinks.net/filter-dnsbl-lists.htm#whitelists" target="_blank">SpamLinks</a> .

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-8.jpg"><img class="alignnone size-thumbnail wp-image-296" title="IP Allow List Providers Properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-8-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Add-IPAllowListProvider -Name:Example -LookupDomain:Example.com
```

The command above will add an Allow List Provider to the list with the name <em>Example </em>and domain/address <em>example.com</em>

<a href="http://technet.microsoft.com/en-us/library/bb123876(EXCHG.80).aspx" target="_blank">Get-IPAllowListProvider</a> returns the current settings of the IP allow list provider

```PowerShell
Set-IPAllowListProvider -Identity Example.com -AnyMatch:$true
```

This command will tell Exchange that is has to check every e-mail with the Allow List provider example.com and will be threated the same despite the code that will be replied by the Allow List Provider.

```PowerShell
Remove-IPAllowListProvider -Identity Example.com
```

Removes the provider example.com from the allow list provider.

```PowerShell
Test-IPAllowListProvider</a>-IPAddress 192.168.0.1 -Provider ExampleProviderName
```

With this command you can do a lookup of the IP-address <em>192.168.0.1 </em>with the White-list provider <em>ExampleProviderName</em>

<strong>IP Block List</strong>

This agent contains IP-addresses who will be blocked by Exchange. It can happen that you don't want to accept mails from specific IP-addresses or IP-ranges because you receive a lot of viruses or spam from them. In most cases it is easier to use a RBL provider then using an list with manual entries.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-9.jpg"><img class="alignnone size-thumbnail wp-image-297" title="IP Block List properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-9-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Set-IPBlockListConfig -InternalMailEnabled:$true -DomainController ad-server.test.nl
```

This command will tell to which DC the configuration needs to be saved.

<a href="http://technet.microsoft.com/en-us/library/bb123482(EXCHG.80).aspx" target="_blank">Get-IPBlockListConfig</a> returns the current settings of the <em>IP Blocklist agent.</em>

```PowerShell
Add-IPBlockListEntry -IPRange:192.168.0.1/24
```

Adds the IP-range 192.168.0.1/24 to the <em>IP Block list</em>

<a href="http://technet.microsoft.com/en-us/library/bb125166(EXCHG.80).aspx" target="_blank">Get-IPBlockListEntry</a> returns the current settings of the IP Block list entry

<a href="http://technet.microsoft.com/en-us/library/bb124341(EXCHG.80).aspx" target="_blank">Remove-IPAllowListEntry</a> -Identity &lt;Integer&gt; deletes the entry of the IP-address/IP-range of the IP Block list with the <em>id</em> <em>of the rule </em>as the integer.

<strong>IP Block List providers</strong>

In this agent we can add RBL providers. This are organizations who provide lists with IP-addresses that are sending a lot of spam or servers which are configured as open-relay. On this <a href="http://www.spamlinks.net/filter-dnsbl-lists.htm#spamsource" target="_blank">page</a> you can find an overview of them.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-10.jpg"><img class="alignnone size-thumbnail wp-image-298" title="IP Block List Providers Properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-10-150x150.jpg" alt="" width="150" height="150" /></a>

Within this agent there is an extra tab added <em>exceptions, </em>here  you can exclude IP-addresses from this agent.

<em>Powershell commando's:</em>

```PowerShell
Add-IPBlockListProvider -Name:Example -LookupDomain:Example.com -RejectionResponse "Originating IP addressed matched to Example.com's IP Block List provider service"
```

This command will add a Block List Provider with the name <em>Example</em> and domain/address <em>example.com. </em>When an IP is found on list the sender will receive the following message: "Originating IP addressed matched to Example.com's IP Block List provider service"

<a href="http://technet.microsoft.com/en-us/library/aa996590(EXCHG.80).aspx" target="_blank">Get-IPBlockListProvider</a> returns the current settings of the IP Block List Provider agent

<a href="http://technet.microsoft.com/en-us/library/bb124979(EXCHG.80).aspx" target="_blank">Set-IPBlockListProvider</a>-Identity Example.com -AnyMatch:$true

This command will tell Exchange to check every mail with the Block List Provider example.com. Despite the code that is being returned from the provider each mail will be threated the same.

<a href="http://technet.microsoft.com/en-us/library/bb123768(EXCHG.80).aspx" target="_blank">Remove-IPBlockListProvider</a> -Identity Example.com

Deletes the block list provider example.com from the IP Allow Block Provider agent.

<a href="http://technet.microsoft.com/en-us/library/bb124998(EXCHG.80).aspx" target="_blank">Test-IPBlockListProvider</a>-IPAddress 192.168.0.1 -Provider ExampleProviderName

This command will do a lookup of the IP-address <em>192.168.0.1 </em>with the provider <em>ExampleProviderName</em>

<strong>Recipient Filtering</strong>

With recipient filtering you can filter messages on existing/non-existing recipients on the HUB transport without reaching a mailbox. This will prevent space being used by mails to non existing recipient such as administratornn@domain.com.

This agent can use the GAL as source, the GAL will be automatically updated when a user is added to Exchange. Besides that there is a possibility to manually add addresses that you want to block, when you use the previous mentioned option this is not necessary.

<a href="http://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-12.jpg"><img class="alignnone size-thumbnail wp-image-299" title="Recipient Filtering Properties" src="http://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-12-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

<a href="http://technet.microsoft.com/en-us/library/aa998613(EXCHG.80).aspx" target="_blank">Set-RecipientFilterConfig</a>-RecipientValidationEnabled:$true

Enables using the GAL as the source for recipient filtering.

<a href="http://technet.microsoft.com/en-us/library/aa998613(EXCHG.80).aspx" target="_blank">Set-RecipientFilterConfig</a>-BlockListEnabled:$true -BlockedRecipients <em>klaas@domein.com,pietje@domein.com</em>

Checks if the mail is send to klaas@domein.com or pietje@domein.com if this is the cases then the mail will be blocked.

<a href="http://technet.microsoft.com/en-us/library/aa997924(EXCHG.80).aspx" target="_blank">Get-RecipientFilterConfig</a> returns the current settings of the Recipient Filtering agent

<strong>Sender Filtering</strong>

You may wish to block e-mails from specific senders because you receive a lot of spam from this address. Then you can use the sender filtering agent. Here you can specify addresses from which you don't want to receive mail. Besides that possibility you can enable the option to block e-mails which contain no sender address. Depending on which action is activate on the tab <em>action</em> mail will be bounced or marked as spam.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-13.jpg"><img class="alignnone size-thumbnail wp-image-300" title="Sender Filtering properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-13-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Set-SenderFilterConfig-BlankSenderBlockingEnabled:$true -BlockedDomainsAndSubdomains *example.com -BlockedSenders klaas@domein.com,pietje@domein.com
```

When a mail is send from the domain or subdomain example.com mail will be blocked. When mail is send from klaas@domein.com of pietje@domein.com mail also will be blocked.

<a href="http://technet.microsoft.com/en-us/library/bb123894(EXCHG.80).aspx" target="_blank">Get-SenderFilterConfig</a> returns the current settings of the Sender Filtering agent

<strong>Sender ID</strong>

With sender ID you can prevent <em>spoofing </em>mails being delivered. When a mail arrives at the Hub Transport Server the SMTP header will be checked and according to the results a query will be done via DNS. The agent will search for a <em>SPF record; </em>in this record all IP-addresses are listed which are used by the domain to send mail.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/cc160870fig01_l.gif"><img class="alignnone size-thumbnail wp-image-302" title="Sender ID" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/cc160870fig01_l-150x150.gif" alt="" width="150" height="150" /></a>

When the IP-address is not found in the SMTP-header, then the mail will be rejected, deleted or marked as spam.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-15.jpg"><img class="alignnone size-thumbnail wp-image-301" title="Sender ID properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-15-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Set-SenderIdConfig -SpoofedDomainAction Delete -BypassedRecipients klaas@domein.com,pietje@domein.com
```

When mail is send from a spoofed address is will be deleted except when it is send to klaas@domein.com or pietje@domein.com

<a href="http://technet.microsoft.com/en-us/library/aa998859(EXCHG.80).aspx" target="_blank">Get-SenderIdConfig</a> returns the current settings of the Sender ID agent

```PowerShell
Test-SenderID -IPAddress 213.144.234.221 -PurportedResponsibleDomain example.com
```

This command let's you manually check if the IP-addresses may be used to send mail from for a specific domain.

<strong>Sender Reputation</strong>

This agent will check the sender reputation. The sender reputation is determined by the following parameters:
<ul>
	<li>helo/ehlo analyse</li>
	<li>reverse dns lookup</li>
	<li>analysis by the content filter to determine the SCL level</li>
	<li>open proxy test</li>
</ul>
<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-16.jpg"><img class="alignnone size-thumbnail wp-image-303" title="Sender Reputation properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-16-150x150.jpg" alt="" width="150" height="150" /></a>

On the tab <em>action </em>you can specify how the filter will work, besides that you can specify how long the sender will be blocked. All e-mails that will be blocked by this agent will be blocked for 24 hours by default. Besides that you can define the following actions:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-17.jpg"><img class="alignnone size-thumbnail wp-image-304" title="Sender Reputation Properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/naamloos-17-150x150.jpg" alt="" width="150" height="150" /></a>

<em>Powershell commando's:</em>

```PowerShell
Set-SenderReputationConfig -SrlBlockThreshold 8 -SenderBlockingEnabled:$true -SenderBlockingPeriod 24
```

This command will block all e-mails that don't pass the open proxy test and the SRL (Spam Reputation Level) is 8 or higher. The sender address will be blocked for 24 hours.

<a href="http://technet.microsoft.com/en-us/library/aa997271(EXCHG.80).aspx" target="_blank">Get-SenderReputationConfig</a> returns the correct settings of the Sender Reputation agent

This is a very long tutorial but I think we talked about all the points. When you like to have more commands, all Powershell commando's are linked to pages on Technet which contain more info.