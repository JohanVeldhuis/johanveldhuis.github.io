---
id: 2729
title: 'Let&#8217;s cleanup the mess caused by iOS'
date: 2013-02-20T20:58:08+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2729
permalink: /laten-we-de-rotzooi-veroorzaakt-door-ios-opruimen/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Scripts
---
<span style="color: #ff0000;"><em>21-2-2013: script has been updated due to a missing } which will cause the script to fail</em></span>

You probably know about the iOS issue which had a great impact on Exchange environment. One environment might have had more issues then the other one and administrators may have taken actions via several actions.

Apple has released an update for iOS which should fix the issue, if it really is fixed is just a matter of waiting. Till now no negative messages have been posted on several sites so it looks like it is solved.

**Cleanup proces**

And now what to do? A lot of Exchange environment are polluted by the bug in iOS. Now the issue has been solved it&#8217;s time to cleanup all the mess.

To cleanup we first need to find out which mailboxes are really hit by the bug. To do this you can use the Powershell cmdlet _Get-MailboxStatistics_ and use the select option with the parameters  _Username, TotalItemSize,_ _TotalDeletedItemSize, Items_ and _DeletedItems_.

Once you have found the mailboxes which are having the issue we will need to identify which item is causing the issue. To find the item you will need to use the _Get-MailboxFolderStatistics_ cmdlet. Because the items are placed in the recoverableitems folder we will need to specify this as the folderscope. As last parameter we will need to use the _analysis_ option which gives detailed information about the item. Using this cmdlet and parameters we will find the item which is most problematic item.

To cleanup the item you will need to use the _search-mailbox_ cmdlet.

**IOS6 cleanup script**

As you have just discovered it can be a lot of work to cleanup the items. Because this maybe very hard in large environments I decided to create a script which finds the mailboxes, finds the item causing issues and optionally cleans up the item. The script will search per mailbox database. This because I have seen that it can cause a large amount of logging. The last one can have serious consequences for your storage, if the volume is almost full the databases will be dismounted automatically. Since this is not what we want it is very import to monitor the free space on the disk volumes when performing this process.

You can download the script via the Technet ScriptCenter of by using the link at the end of this blog.

In the current version the following functions are available:

  * search the specified database
  * create a report of the users which have a larger deleter item size then specified
  * create a report per user with the output of the analyses
  * automatically export the item to the specified mailbox and remove the item from the mailbox

But how to execute the script? Before doing this it is important to know which parameters you can use:

  * database, name of the database on which you want to perform the process (required)
  * minsize, minimum size of the deleted items (required)
  * topsubjectcounter, minimum value of how many times must the same item exist (only required if autoclean is used)
  * autoclean, performs a search, exports the item and removes the item (default false)
  * userreport, creates a list of users who are passing the configured threshold (default false)
  * targetmailbox, which mailbox may be used as target for the exported items (only required if autoclean is used)

For example: we want to search the database MBDB01 and want to know which mailboxes are having deleted items which are in total bigger then 1 GB.  Once we found those mailboxes we want to cleanup the item found during the analysis process only if it exists 1000 times or more. Besides this we want to get a report of which the mailboxes which will be cleaned up.

To do this execute the script like this:

_.\IOS6.ps1 -database MBDB01 -minsize 1024 -topsubjectcount 1000 -autoclean $true -userreport $true_

**Disclaimer:** This script should be used at your own risk. Using the autocleanup functionality
  
can cause data loss. Recommendation is to first test it in a test environment before using
  
it in your production environment.

During the cleanup process a large amount of logging can be created it is recommended to monitor your environment during this process.

If you&#8217;re missing things or you have a question about the script then please let me know.

[download script](http://gallery.technet.microsoft.com/IOS6-calender-issue-cleanup-3199bb03)