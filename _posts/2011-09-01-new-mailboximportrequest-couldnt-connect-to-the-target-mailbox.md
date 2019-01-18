---
id: 2309
title: 'New-MailboxImportRequest: Couldn&#8217;t connect to the target mailbox'
date: 2011-09-01T20:56:06+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2309
permalink: /new-mailboximportrequest-couldnt-connect-to-the-target-mailbox/
categories:
  - Exchange
---
Starting from Exchange 2010 it is possible to import pst files using the New-MailboxImportRequest cmdlet. By default this cmdlet can&#8217;t be executed. This is caused by the fact that the _New-MailboxImportRequest_ cmdlet is not a part of the default RBAC groups.

**RBAC
  
** To create a new group you can use the Exchange Management Shell. This to prevent that specific permissions are assigned per user:

```PowerShell
New-RoleGroup 'Mailbox import and export Rights'
```

[<img class="alignnone size-medium wp-image-2324" title="New-RoleGroup" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/new-rbacgroup-300x21.jpg?resize=300%2C21" alt="" width="300" height="21" srcset="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/new-rbacgroup.jpg?resize=300%2C21&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/new-rbacgroup.jpg?w=961&ssl=1 961w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/new-rbacgroup.jpg)

Using the cmdlet above we will create a new RBAC group called _Mailbox import and export rights_. The next step is to add the cmdlet to the RBAC group:

```PowerShell
New-ManagementRoleAssignment -Role 'Mailbox Import Export' -SecurityGroup 'Mailbox import and export Rights'
```

Using the above cmdlet we will add the role _Mailbox Import Export _to the earlier created RBAC group.

```PowerShell
Add-RoleGroupMember 'Mailbox import and export Rights' -Member Administrator
```

[<img class="alignnone size-medium wp-image-2325" title="new-managementrolegroupassignment" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/new-managementrolegroupassignment-300x29.jpg?resize=300%2C29" alt="" width="300" height="29" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/new-managementrolegroupassignment.jpg?resize=300%2C29&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/new-managementrolegroupassignment.jpg?w=963&ssl=1 963w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/new-managementrolegroupassignment.jpg)

As last cmdlet we will add the user _administrator_ to the RBAC group _Mailbox import and export Rights_. When the cmdlet has been executed you will need to restart the Exchange Management Shell.

**NewMailboxImportRequest
  
** Before you can import a PST there is one other important prerequisit. The group _Exchange Trusted subsystem_ needs to have permissions to access the share which contains the PST files. When this is not possible you will get the following error _Couldn&#8217;t connect to target mailbox_.

When the last step has been performed we can submit a new import request:

```PowerShell
New-MailboxImportRequest -Mailbox Johan -FilePath \\File01\PST\johan.pst
```

In the example above we will import the PST file called _johan.pst_ from the PST share on the server called _File01_. The content of the PST will be imported in the mailbox called _Johan_.

To monitor the process we can use the following cmdlets:

  * Get-MailboxImportRequest
  * Get-MailboxImportRequestStatistics

**Get-MailboxImportRequest
  
** This cmdlet will give a default overview of the Mailbox Import Requests which are submitted to Exchange.

For example:

```PowerShell
Get-MailboxImportRequest -Identity 'Johan\MailboxImport'
```

[<img class="alignnone size-medium wp-image-2327" title="Get-MailboxImportRequest" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequest-300x19.jpg?resize=300%2C19" alt="" width="300" height="19" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequest.jpg?resize=300%2C19&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequest.jpg?w=814&ssl=1 814w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequest.jpg)

In this case the identity exists of two parts: the name of the mailbox combined with the name of the import request. Using the cmdlet above we will retrieve the status of the import request which has as jobname _MailboxImport_. The data will be imported in the mailbox called _johan_.

**Get-MailboxImportRequestStatistics
  
** Gives a detailed overview of the Mailbox Import Request. This cmdlet can be used in combination with the Get-MailboxImportRequest cmdlet:

```PowerShell
Get-MailboxImportRequest | Get-MailboxImportRequestStatistics
```

[<img class="alignnone size-medium wp-image-2328" title="Get-MailboxImportRequestStatistics" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics-300x15.jpg?resize=300%2C15" alt="" width="300" height="15" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics.jpg?resize=300%2C15&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics.jpg?w=953&ssl=1 953w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics.jpg)

When executing the above example you will get a overview of the currently submitted Mailbox Import Requests with additional information. But when needing very detailed information,  for example the item count, percentage etc. then you will need to add_|FL_ to the example above:

```PowerShell
Get-MailboxImportRequest | Get-MailboxImportRequestStatistics | FL
```

[<img class="alignnone size-medium wp-image-2329" title="Get-MailboxImportRequest | Get-MailboxImportRequestStatistics | fl" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics_fl-300x142.jpg?resize=300%2C142" alt="" width="300" height="142" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics_fl.jpg?resize=300%2C142&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics_fl.jpg?w=566&ssl=1 566w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/get-mailboximportrequeststatistics_fl.jpg)

**Couldn&#8217;t connect to target mailbox
  
** As mentioned earlier the error message _Couldn&#8217;t connect to target mailbox_ can occur. To troubleshoot this problem you will need to add the _-v_ parameter to the _New-MailboxImportRequest_ cmdlet. In the screenshot below an example can be seen:

[<img title="Couldn't connect to target mailbox" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/error-300x129.jpg?resize=300%2C129" alt="" width="300" height="129" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/08/error.jpg)

In this example both the share permissions and firewall settings where not causing the issue. When searching on the internet you will find several people who are having this issue.

The cause of this issue is: the CAS Array. To solve this problem temporarily you could choose to change the _RpcClientAccessServer_ value temporarily. An other option which might be a easier to use is to create a temporary database and move the mailbox to it. Don&#8217;t forget to modify the _RpcClientAccessServer_ value in this case also.

To change the _RpcClientAccessServer_ value we will need to use the following cmdlet:

_set-MailboxDatabase MBDBTEMP -RpcClientAccessServer cas01.corp.local_

In the example above we will change the _RpcClientAccessServer_ temporarily to one of the CAS Servers.

Don&#8217;t forget to restore the old configuration once completed:

_set-MailboxDatabase MBDBTEMP -RpcClientAccessServer casarray.corp.local_

**Remove-MailboxImportRequest
  
** Just like a move request an import request won&#8217;t be removed automatically.  An import request needs to be cleaned up manually. This can be done by using the cmdlet _Remove-MailboxImportRequest:_

_remove-MailboxImportRequest -identity johan\MailboxImport_

Using the exampel above we will remove the earlier create import request. When you would like to cleanup multiple import requests use the following cmdlet:

_get-MailboxImportRequest | where {$_.status -eq &#8220;completed&#8221;} | remove-MailboxImportRequest_

[<img class="alignnone size-medium wp-image-2330" title="Remove-MailboxImportRequest" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/remove-mailboximportrequest-300x27.jpg?resize=300%2C27" alt="" width="300" height="27" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/remove-mailboximportrequest.jpg?resize=300%2C27&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/remove-mailboximportrequest.jpg?w=822&ssl=1 822w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/09/remove-mailboximportrequest.jpg)

Using the example above we will first retrieve all mailbox import requests that are having the status _completed._ Once found we will remove all those requests.