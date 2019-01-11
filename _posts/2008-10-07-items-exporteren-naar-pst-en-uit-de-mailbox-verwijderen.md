---
id: 895
title: Export items to a PST and delete them from the mailbox
date: 2008-10-07T21:56:07+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=895
permalink: /items-exporteren-naar-pst-en-uit-de-mailbox-verwijderen/
categories:
  - Exchange
---
Deleting items from a specific mailbox can be done really easy via the Powershell using the command _export-mailbox._ Before deleting the items it may be usefull to make a backup of this items. You can create a backup to a PST of to a special mailbox.

Before executing the command we need to arrange somethings first:

  * the account which we use to execute the command needs to have full access to the mailbox where we want to export items from and where we want to export items to
  * when choosing the option to export to a PST we need the have Outlook installed on our system
  * when choosing the PST option we need to ensure that the directory exists before executing the command

The first step is not very hard to do, by executing the following command

_Add-MailboxPermission -Identity johan -User administrator -AccessRights FullAccess</p> 

</em>We will give the _administrator_ full access to the mailbox of _johan._

The next step is to create the directory, this can be done via Explorer, via the dos-prompt or via Powershell.

When everything is prepared we can start with exporting the items and then deleting them 

_Export-Mailbox -Id _[_johan@test.local_](mailto:johan@test.local) _-StartDate &#8220;10/05/08&#8221; -EndDate &#8220;10/05/08&#8221; -PSTFolderPath C:\Backup\johan.pst -deletecontent_

The command above will export all items from all folders which are dated the 5th of October and will export them to a PST and delete them from the mailbox. Keep in mind that this also will be the calender items and sent items

Besides this option there are a few other options:

  * export items with specific keywords in the subject _-SubjectKeywords_ 
  * export items with specific keywords in the content &#8211;_ContentKeywords_
  * export items only from a specific folder _-IncludeFolders &#8216;\Sent Items&#8217;_
  * export items only with a specific attachment name or extension_-AttachmentFilenames_

For a full overview of all options have a look at the following site

<a href="http://technet.microsoft.com/en-us/library/aa998579.aspx" target="_blank">open</a>