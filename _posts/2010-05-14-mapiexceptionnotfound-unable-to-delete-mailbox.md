---
id: 1908
title: 'MapiExceptionNotFound: Unable to delete mailbox'
date: 2010-05-14T21:27:19+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1908
permalink: /mapiexceptionnotfound-unable-to-delete-mailbox/
categories:
  - Exchange
---
During a cross-forest test migration from Exchange 2003 to Exchange 2010 I got the following error:

_Warning: Unable to update AD information for the source mailbox at the end of the move.  Error details: An error occurred while updating a user object after the move operation. &#8211;> Failed to find the address type object in Active Directory for address type &#8220;SMTP:AMD64&#8221;.
  
Failed to cleanup the source mailbox after the move.
  
Error details: MapiExceptionNotFound: Unable to delete mailbox. (hr=0x8004010f, ec=-2147221233)_

When I looked in the old and new environment I found out that the mailbox both existed in the old and new environment. In this  case you might have a big issue even when the mail is delivered in the Exchange 2003 environment  and the homeMDB attribute is not updated. Updating the attribute may take a while due to AD replication, in this case mail is not delivered in the new mailbox and so mails will not be placed in the new mailbox.

To prevent this issue Microsoft has released a hotfix for Exchange 2003 which can be found on the website below.

<a href="http://support.microsoft.com/kb/940012" target="_blank">open</a>