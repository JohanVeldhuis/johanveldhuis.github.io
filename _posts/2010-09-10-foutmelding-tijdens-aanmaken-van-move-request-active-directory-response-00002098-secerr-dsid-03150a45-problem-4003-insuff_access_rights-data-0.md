---
id: 2012
title: 'Error when submitting move request: Active directory response: 00002098: SecErr: DSID-03150A45, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0'
date: 2010-09-10T20:35:58+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2012
permalink: /foutmelding-tijdens-aanmaken-van-move-request-active-directory-response-00002098-secerr-dsid-03150a45-problem-4003-insuff_access_rights-data-0/
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
During a migration at a customer I had the following issue, one I haven&#8217;t seen before. Selecting the target database went fine but when submitting the move request this resulted in the following error:

_Active Directory operation failed on dc01.lab.local. This error is not retriable. Additional information: Insufficient access rights to perform the operation.
  
_ _Active directory response: 00002098: SecErr: DSID-03150A45, problem 4003 (INSUFF\_ACCESS\_RIGHTS), data 0
  
The user has insufficient access rights.
  
Exchange Management Shell command attempted:
  
&#8216;lab.local/Users/Johan Veldhuis&#8217; | New-MoveRequest -TargetDatabase &#8216;Mailbox Database&#8217;_

As the error already tells us it has to do something with permissions. Very strange because the account which was used was a member of both the domain admins and organization management group. So I checked the permissions on the mailbox using the  _get-mailboxpermission_ cmdlet, nothing strange there also.

I decided to search the internet and found the following <a href="http://www.outlookforums.com/showthread.php?33292-Move-Mailbox-Error-2010" target="_blank">solution</a>:

  * open Active Directory Users & Computers
  * select the option _advanced features_ in the menu _view_
  * select the tab _security_
  * press the _advanced_ button
  * select the option _include inheritable permissions from this object&#8217;s parent_
  * try to migrate the mailbox again

Pretty easy solution compared to the error you will get.