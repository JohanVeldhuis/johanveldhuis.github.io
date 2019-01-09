---
id: 763
title: Mailbox-database cleanup
date: 2008-08-31T22:04:51+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=763
permalink: /mailbox-database-opschonen/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2007
---
In Exchange 2003 you could use the Cleanup database to check the mailboxdatabase for mailboxes who were not assigned to users anymore. In Exchange 2007 you can do this via the _Exchange Management_ Shell. The command that you need to use for this is _clean-mailboxdatabase._ This command will scan the Active Directory for mailboxes who are not assigned to users anymore but are not marked as this in the AD. When the status is not correct it will update the status directly.

Clean-MailboxDatabase Mailbox_db

The command above will scan de mailboxdatabase Mailbox_db, the only required parameter is the databasename. There are 2 other parameters who could be usefull:

  * Confirm, this parameter will ask the user for confirmation before really executing the command.
  * DomainController, with this parameter you can specify the domaincontroller which will be used as the source for the Active Directory database.