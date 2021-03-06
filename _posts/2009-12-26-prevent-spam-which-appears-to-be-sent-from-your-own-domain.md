---
id: 1785
title: Prevent spam which appears to be sent from your own domain
date: 2009-12-26T22:24:40+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1785
permalink: /prevent-spam-which-appears-to-be-sent-from-your-own-domain/
categories:
  - Exchange
---
Last months you may receive spam which looks like to be sent from an account from your own domain. When you investigate the issue you will discover that this it not the case. But why does Exchange doesn&#8217;t do something with this kind of spam. I found the answer on <a href="http://exchangepedia.com" target="_blank">Exchangepedia</a> blog. Each mail which is received from the internet will be accepted with the anonymous user, when removing this user from the connector you won&#8217;t be able to receive mail from the internet. This account has some rights which are needed, one of these rights is the Ms-Exch-Accept-Authoritative-Domain-Sender which ensure that every session which contains a message from an authoritative domain will not be checked.

To prevent this you will need to remove some rights from the connector by using the following command:

<div id="_mcePaste" style="position: absolute; width: 1px; height: 1px; overflow: hidden; top: 0px; left: -10000px;">
  <em> </em>
</div>

```PowerShell
Get-ReceiveConnector 'Internet' | Get-ADPermission -user 'NT AUTHORITY\Anonymous Logon' | where {$_.ExtendedRights -like 'ms-exch-smtp-accept-authoritative-domain-sender'} | Remove-ADPermission
```

Please keep in mind that this also will have some consequences for other applications/devices which will use this connector using the anonymous user. For this application/devices you will need to create a separate connector.