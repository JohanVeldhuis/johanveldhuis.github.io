---
id: 1910
title: 'MapiExceptionInvalidParameter: Unable to set properties on object. (hr=0x80070057, ec=-2147024809)'
date: 2010-06-19T21:25:42+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1910
permalink: /mapiexceptioninvalidparameter-unable-to-set-properties-on-object-hr0x80070057-ec-2147024809/
categories:
  - Exchange
---
During a cross-forest migration from Exchange 2003 to Exchange 2010 I found a nasty issue while migration a mailbox. The first 10% of the move request went OK but after that it failed. In the first 10% the mailbox is created, the folder structure is created and permissions are set on the folders.

I started looking in the event log as, by default, enough information is logged here to see why a move request failed and found the following event:

_Mailbox move for &#8216;xxxxxxxxxxxxxxxxxxxxxx&#8217; (d126705e-af4d-4aca-83c6-0ea443a2ad60) has failed.</p> 

Error code: -2147024809

MapiExceptionInvalidParameter: Unable to set properties on object. (hr=0x80070057, ec=-2147024809)

Diagnostic context:

    Lid: 18969   EcDoRpcExt2 called [length=363]

    Lid: 27161   EcDoRpcExt2 returned \[ec=0x0\]\[length=108\][latency=0]

    Lid: 23226   &#8212; ROP Parse Start &#8212;

    Lid: 27962   ROP: ropSetProps [10]

    Lid: 17082   ROP Error: 0x80070057

    Lid: 30561 

    Lid: 21921   StoreEc: 0x80070057

    Lid: 27962   ROP: ropExtendedError [250]

    Lid: 1494    &#8212;- Remote Context Beg &#8212;-

    Lid: 26426   ROP: ropSetProps [10]

    Lid: 47113 

    Lid: 7915    StoreEc: 0x80070057

    Lid: 5263    StoreEc: 0x80070057

    Lid: 19768 

    Lid: 4559    StoreEc: 0x80070057

    Lid: 1750    &#8212;- Remote Context End &#8212;-

    Lid: 26849 

    Lid: 21817   ROP Failure: 0x80070057

    Lid: 25761 

    Lid: 1940    StoreEc: 0x80070057

    Lid: 25297 

    Lid: 21201   StoreEc: 0x80070057

Context:

Mailbox: Primary (d126705e-af4d-4aca-83c6-0ea443a2ad60)

Folder: &#8216;/Top of Information Store/Taken/xxxxxx&#8217;, entryId [len=46, data=00000000109014FD0A523641A2C3C55606B5EA8201006E5BA8745959BC4C9F7B175EAE3144A80000378F00370000], parentId [len=46, data=00000000109014FD0A523641A2C3C55606B5EA820100C0260BEE56B49E4981448625D74A5AAB0000000400470000]

Operation: LocalDestinationFolder.SetSecurityDescriptor

SD: O:S-1-5-21-3869603026-3631219241-1903344517-3835G:S-1-5-21-3869603026-3631219241-1903344517-513D:AI(A;OIIO;0x1f0fbf;;;S-1-5-21-3869603026-3631219241-1903344517-3835)(A;CI;0x1fc9ff;;;S-1-5-21-3869603026-3631219241-1903344517-3835)(A;OIIO;0x1208a9;;;S-1-5-21-4230955503-526549450-3057572010-5377)(D;OIIOID;0x1f0716;;;S-1-5-21-3869603026-3631219241-1903344517-2781)(A;CI;0x1208a9;;;S-1-5-21-4230955503-526549450-3057572010-5377)(D;CIID;0xdc916;;;S-1-5-21-3869603026-3631219241-1903344517-2781)</em>

As you can see above it has some problems with the _Taken_ folder. When we had a look at this folder together with the end-user we found out that specific permissions where set in the folders. So we asked if he could remove them on one of the folders to check if that fixed the issue. After the user had done this we were a step further but, as expected, had the same issue with another folder. As it isn&#8217;t an option to remove all permissions before migrating the mailbox I decided to contact Microsoft.

After we contacted Microsoft a lot became more clear. During the migration of a mailbox from Exchange 2003 to Exchange 2010 the process will try to regenerate the ACL&#8217;s on the Exchange 2010 side. This because Exchange 2010 does use the ACL&#8217;s in another way then Exchange 2003. It can happen that the an ACL get&#8217;s corrupt which will cause the migration of the mailbox to fail.

The solution: redefine the permissions via Outlook either by removing and adding them again or by changing them to something else and then change them back to the original permissions. Not a really nice solution but you can continue migrating.

Collegue <a href="http://eightwone.wordpress.com/" target="_blank">Michel de Rooij</a>ave me another tip, try to use <a href="http://technet.microsoft.com/en-us/library/bb508858(EXCHG.65).aspx" target="_blank">PFdavAdmin</a> with this tool it&#8217;s possible to fix AC&#8217;L&#8217;s of mailboxes.