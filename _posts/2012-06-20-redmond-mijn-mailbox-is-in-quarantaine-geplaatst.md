---
id: 2464
title: Redmond my mailbox is quarantined
date: 2012-06-20T21:53:35+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2464
permalink: /redmond-mijn-mailbox-is-in-quarantaine-geplaatst/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
As you may know Exchange 2010 contains several built-in security features to prevent issues with your server. Think of the back pressure mechanism which protects your Hub Transport from being brought down due to lack of resources.

Another security feature can be found on the Mailbox Server and then specifically in the Information Store process. For those who don’t know what the responsibilities are of the Information Store: almost everything which is database related. For example if the Information Store is down you won’t be able to mount both mailbox and public folder databases.

The feature I am talking about is quarantining a mailbox. But why does Exchange performs this action on mailboxes? Well there are a few reasons why Exchange can decide to place a mailbox in quarantine:

  * Thread doing work for a mailbox fails
  * More than five threads in a mailbox that haven’t made progress for a long time (more than 60 seconds)

As you have seen it all has to do with threads on a mailbox which fail. Every time one of the issues occurs a counter is raised. This counter is stored in the registry. Besides the counter the Information Store keeps the timestamp information about when the issue occurred with the specific mailbox also called the poison mailbox.

You may think why is this setting stored in the registry? Well the reason for this is that the information stored here will be replicated by the cluster database if you are running a high availability environment.  The following registry path is created used to store the keys:

_HKLM\SYSTEM\CurrentControlSet\Services\MSExchangeIS\\Private-{db guid}\QuarantinedMailboxes\{mailbox guid}_**__**

In this path the following keys will be created:

  * CrashCount: the amount of crashes detected
  * LastCrashTime: the timestamp of the last occurance of a crash
  * QuarantineState: is a mailbox quarantined or not
  * QuarantineTime: the time the mailbox is placed in quarantine

If the issue doesn’t occur again in two hours the registry key used to store the counter is deleted. The 2 hours is a value which can’t be changed. But there are two other interesting keys:

  * MailboxQuarantineCrashThreshold: how many issue may occur before a mailbox is put in quarantine
  * MailboxQuarantineDurationInSeconds: how long is the mailbox placed in quarantine****

By default when three issues occur a mailbox is placed in quarantine. The mailbox will be kept in quarantine for 6 hours (21600 seconds). After the 6 hours are expired the mailbox is removed from quarantine.

Both keys can be found here:

_HKLM\SYSTEM\CurrentControlSet\Services\MSExchangeIS\\Private-{db guid}\QuarantinedMailboxes_

But what happens to a mailbox put in quarantine? Well the answer is quit short: it isn’t accessible for any end-user. Even background processes such as content indexing and the mailbox assistant can’t access the mailbox. This is because these processes, just like end-users, don’t pass the _OPEN\_AS\_ADMIN_  flag. This special flag checks if a user who tries to connects passes the OPEN\_AS\_ADMIN flag, if true the user will be able to access the mailbox. If a mailbox is placed in quarantine an event is stored with event id 10018.

Besides the automatic release of the mailbox from quarantine it is possible to manually release it from quarantine. But before doing this it is highly recommended to find the cause of the issue. This since a mailbox is not placed in quarantine because it works but it can cause serious issues for the other mailboxes in your environment.

Another reason why to investigate the issue is if you decide to release it manually but the issue still occurs the mailbox will be put in quarantine again.

To manually release the mailbox you will first need to know the GUID of the mailbox. You can lookup the GUID by using the get-mailboxstatistics cmdlet just like this:

_Get-Mailbox support |select name, GUID_

Once you have found the GUID you will need to find the corresponding registry path. As discussed earlier each poisoned mailbox has the key _MailboxQuarantineDurationInSeconds_ modify the value to for example 0 or 1. After you’ve made the registry key change perform one of the following tasks:

  * Dismount/mount the database
  * Restart the Information Store
  * Reboot your server

Although this last one is a little bit overkill.

Here ends the blog about quarantining mailboxes. Hope it doesn’t happen to much in your environment else you got some serious trouble.

More information about this topic can be found on the site below.

Technet &#8211; Understanding the Exchange 2010 Store <a href="http://technet.microsoft.com/en-us/library/bb331958.aspx" target="_blank">open</a>

<div id="UMS_TOOLTIP" style="position: absolute; cursor: pointer; z-index: 2147483647; background: none repeat scroll 0% 0% transparent; display: none;">
  <img id="ums_img_tooltip" class="UMSRatingIcon" alt="" />
</div>