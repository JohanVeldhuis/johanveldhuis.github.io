---
id: 1238
title: User alias is incorrectly displayed in the to field in Outlook
date: 2009-06-18T21:14:08+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1238
permalink: /user-alias-is-incorrectly-displayed-in-the-to-field-in-outlook/
categories:
  - Exchange
---
This week I had a strange issue but I was able to solve it. There were some serious issues with a user and the only solution was to recreate the user-account. On first sight no problem you will need to trick somethings but it will work. After recreating the user I reconnect the old mailbox and it looked OK.

A few minutes later another user told me that if mail was send to the user a strange alias was displayed in the to field it looked like: username123456. We deleted the entry from the NK2 file and tried again but the issue came back.

I started to search in the ADUC but everything looked OK there. Then I started searching with adisiedit and had a look at the properties of the user. After some searching I discovered that the strange value was the value of the LegaceExchange DN. The user started already with working again so changing it would be to risky.

After performing some searches on google I found that more people had this issue. After searching for a while I found a site which described the issues and had also a solution for the issue.

First you will need to copy the value of the LegacyExchange DN and then correct it so it will display the correct alias.  Next step it to create a X500 address which contains the strange address, this to prevend NDR&#8217;s when users repy to the strange alias.

The X500 address must be in the following format:

_/ou=<your organization name> /ou=<your organizational unit> /cn=recipients /cn=<alias>_

When you made the modifications you will need to delete the incorrect NK2 entry and you solved the issue.

On the site below you will find more information and also a few other solutions for this issue.

<a href="http://winzenz.blogspot.com/2005/10/outlook-autocomplete-and.html" target="_blank">open</a>