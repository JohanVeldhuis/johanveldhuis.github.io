---
id: 1873
title: Move-mailbox fails with strange error
date: 2010-03-15T19:47:35+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1873
permalink: /move-mailbox-mislukt-vanwege-vreemde-foutmelding/
categories:
  - Exchange
---
During the conversion of a pilot to production environment I found a nice issue. The mailboxes needed to be moved from the old mailbox server to the new mailbox server. Normally not a very exciting proces which can be done both by using the Exchange Management Console as Exchange Management Shell. But the move from the old Exchange 2010 mailbox server to the new Exchange 2010 mailbox server failed with a strange error. So first I had a look in the event log of the server and found the following error:

_(PID 5988, Thread 954) Task New-MoveRequest writing error when processing record of index 0. Error: Microsoft.Exchange.MailboxReplicationService.MailboxReplicationTransientException: The call to &#8216;net.tcp://cas.domain.local/Microsoft.Exchange.MailboxReplicationService&#8217; failed. Error details: The type initializer for &#8216;Microsoft.Exchange.MailboxReplicationService.LocalMailbox&#8217; threw an exception.. &#8212;> System.ServiceModel.FaultException\`1[System.ServiceModel.ExceptionDetail]: The type initializer for &#8216;Microsoft.Exchange.MailboxReplicationService.LocalMailbox&#8217; threw an exception. (Fault Detail is equal to An ExceptionDetail, likely created by IncludeExceptionDetailInFaults=true, whose value is:_

_System.TypeInitializationException: The type initializer for &#8216;Microsoft.Exchange.MailboxReplicationService.LocalMailbox&#8217; threw an exception. &#8212;-> System.IO.FileLoadException: The located assembly&#8217;s manifest definition does not match the assembly reference. (Exception from HRESULT: 0x80131040)_

_   at Microsoft.Exchange.MailboxReplicationService.LocalMailbox..cctor()_

_   &#8212; End of inner ExceptionDetail stack trace &#8212;_

_   at Microsoft.Exchange.MailboxReplicationService.LocalMailbox..ctor(LocalMailboxFlags flags)_

   at Microsoft.Exchange.MailboxReplicationService.LocalSourceMailbox..ctor(LocalMailboxFlags flags)

   at Microsoft.Exchange.MailboxReplicationService.MailboxReplicationService.<>c\_\_DisplayClass25.<GetMailboxInformation2>b\_\_24()

   at Microsoft.Exchange.MailboxReplicationService.CommonUtils.CatchKnownExceptions(GenericCallDelegate del, FailureDelegate failureDelegate, MrsTracer tracer)

   at Microsoft.Excha&#8230;).

_   &#8212; End of inner exception stack trace &#8212;_

_   at Microsoft.Exchange.MailboxReplicationService.CommonUtils.CallService(GenericCallDelegate del, String epAddress)_

   at Microsoft.Exchange.MailboxReplicationService.MailboxReplicationServiceClient.GetMailboxInformation(Guid primaryMailboxGuid, Guid physicalMailboxGuid, Guid targetMdbGuid, String targetMdbName, String remoteHostName, String remoteOrgName, String remoteDCName, NetworkCredential cred)

   at Microsoft.Exchange.Management.RecipientTasks.NewMoveRequest.InternalValidate()

   at Microsoft.Exchange.Configuration.Tasks.Task.ProcessRecord()

As you can see in the error message there went something wrong with the Exchange Mailbox Replication Service (MRS). These services are located on a server which has the Client Access Role installed on it and is responsible for moving the mailbox from the source to the target server. When you have multiple CAS servers in one site the MRS services will share information about the mailbox move process to prevent multiple servers are busy with the same request.

As their was only one CAS, cas.domain.local, I decided to have a closer look at that server. The MRS service was running according to the services.msc so I decided to restart the Mailbox Replication Service. After this was done I tried the move of the mailbox again and this time it went without issues.

I haven&#8217;t found the cause why this issue happened. One of the issues could be a mailbox database which is not 100% healthy. By using eseutil and isinteg you can fix the database and then try the process again.

Below you will find some links to sites containing further information about this topic:

Technet: Understanding Move Requests <a href="http://technet.microsoft.com/en-us/library/dd298174.aspx" target="_blank">open</a>

Technet: Troubleshooting Mailbox Moves <a href="http://technet.microsoft.com/en-us/library/dd638094.aspx" target="_blank">open</a>