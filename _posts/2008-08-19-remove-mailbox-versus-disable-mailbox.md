---
id: 717
title: Remove-Mailbox versus Disable-Mailbox
date: 2008-08-19T21:17:09+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=717
permalink: /remove-mailbox-versus-disable-mailbox/
categories:
  - Exchange
---
As you may now already you can do quiet a lot of things with Powershell in Exchange 2007. There are some risks, one of this commands is _remove-mailbox._ The name will let you think that you only remove the mailbox from a user but with this command the user is also removed.

If you only need to delete the mailbox then use the command _disable-mailbox_ this removes the Exchange-attributes, after this the mailbox can be purged.