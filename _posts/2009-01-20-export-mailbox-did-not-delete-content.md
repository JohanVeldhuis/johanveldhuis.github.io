---
id: 1033
title: Export-Mailbox did not delete content
date: 2009-01-20T20:44:38+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1033
permalink: /export-mailbox-did-not-delete-content/
categories:
  - Exchange
---
With _export-mailbox_ it&#8217;s possible to export a mailbox to, for example, a pst file. When using the parameter _-DeleteContent_ normally the contact will be deleted after exporting the mail. In some cases this does not happen. It looks like to happen if a mailbox contains more then 4000 items

Microsoft knows about this issues and is busy creating a hotfix for this issue. This hotfix is not published at the moment but via the Technet forum you can find a KB articlenumber under which it will be published: kb960367. When you need the hotfix rightnow please contact CSS to get it.