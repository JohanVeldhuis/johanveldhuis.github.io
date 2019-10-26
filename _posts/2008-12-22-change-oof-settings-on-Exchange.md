---
id: 1004
title: Modify Out Of Office settings on the Exchange Server
date: 2008-12-22T23:58:53+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1004
permalink: /change-oof-settings-on-Exchange/
categories:
  - Exchange
---
As you may know some things have changed in Exchange 2007 for Out Of Office settings, it's now possible to define seperate Out Of Office messages for internet senders and internal senders.</p>
<p>Besides these changes there are no Out Of Office messages send to senders who are listed on the blocked sender list or if the mail is placed in the junk mail folder.</p>
<p>When you are a member of several mailing lists it can be quite irritating if an Out Of Office message is send to it. In Exchange 2007 there are no Out Of Office messages send to it anymore.</p>
<p>With the Exchange Management Shell it's possible to modify several settings:</p>
<ul>
<li>may external users receive an Out Of Office message</li>
<li>may internal users receive an  Out Of Office message</li>
</ul>
<p>The settings above can be configured per user. This is done by using the parameter <em>-ExternalOOFOptions </em>in combination with <em>set-mailbox</em>.</p>

```PowerShell
Set-Mailbox -id &lt;mailbox identity&gt; -ExternalOOFOptions [InternalOnly,External]
```

<p>When you would like to define this for the whole domain you can define the following:</p>
<ul>
<li>only external users may receive an Out Of Office message</li>
<li>only internal users may receive an Out Of Office message</li>
<li>Out Of Office messages may not be send</li>
</ul>
<p>The settings above can be defined per remote domain or for all remote domains using the parameter <em>-AllowedOOFType</em> in combination with <em>set-remotedomain</em>.  When you would like to define this for all remote domains you need to use the<em> * </em>as wildcard.</p>

```PowerShell
Set-remoteDomain -Identity &lt;domain identity&gt; -AllowedOOFType [None,InternalLegacy,ExternalLegacy,External(Default)]
```
<ul>
<li><em>none, </em>sends no Out Of Office messages</li>
<li><em>InternalLegacy, </em>sends Out Of Office messages only to internal users</li>
<li><em>ExternalLegacy, </em>sends Out Of Office messages only to external users</li>
<li><em>External, </em>sends Out Of Office messages only to external users, this is the default setting</li>
</ul>
<p>The Out Of Office settings can also be configured per remote domain via the Exchange Management Console.</p>
<p>For this we need to open the EMC en go to <em>hub transport </em>via <em>organization configuration</em> when selected select the tab <em>remote domains. </em>Here you can see al the <em>remote domains </em>configured, get the properties of it and you will see the following:</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/12/oof_emc.jpg"><img class="alignnone size-thumbnail wp-image-1010" title="oof_emc" src="https://myuclab.nl/wp-content/uploads/2008/12/oof_emc-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>As you can see you can define the settings for Out Of Office you want.</p>
<p><a href="http://www.google.nl/url?sa=t&amp;source=web&amp;ct=res&amp;cd=1&amp;url=http%3A%2F%2Ftechnet.microsoft.com%2Fen-us%2Flibrary%2Faa997857.aspx&amp;ei=bgJQSbHvDpWN-gah7MjMDw&amp;usg=AFQjCNE_GbQE38v6mVkjLOrdMUTEoj0bbw&amp;sig2=TRoE6G1Ye_X9URKiYa2Tag" target="_blank">set-remotedomain</a></p>
<p><a href="http://www.google.nl/url?sa=t&amp;source=web&amp;ct=res&amp;cd=1&amp;url=http%3A%2F%2Ftechnet.microsoft.com%2Fen-us%2Flibrary%2Fbb123981.aspx&amp;ei=rAJQSbbuKcyL-gbJhozKDw&amp;usg=AFQjCNFiCxoRWSAZoTbDJnm1Z8WXxozOGQ&amp;sig2=yHr37wncgzcZdp45OSqqZg" target="_blank">set-mailbox</a>