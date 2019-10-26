---
id: 760
title: Mail queue
date: 2008-08-30T19:30:24+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=760
permalink: /mail-queue/
categories:
  - Exchange
---
Exchange 2007 contains a few nice tools. One of them is the _queue_ viewer_,_ with this tool you can get an overview of all mails who are still in the queue of Exchange 2007. You can do this also via the Powershell command _get-queue,_ with this command all mail queues are displayed with the ammount of messages in it.

```PowerShell
Get-Queue -Filter {MessageCount -gt 100} #gives an overview of mailqueues with more then 100 messages  in it.

Get-Queue -Identity Server1\test.local #gives an overview of all mailqueues on server1.
```

You may want to stop a queue temporarily, this can be done with the command _suspend-queue._ With this command we can prevent delivery of mails to the mailbox server or the internet.

```PowerShell
Suspend-Queue -Filter {NextHopDomain -eq 'xs4all.nl' -and Status -eq 'retry'}
```

The command above will pauze all messages to the domain xs4all.nl with the status retry in the queue.

Of course we are also able to enable the mailqueue again, this is done with the command _resume-queue._ 

```PowerShell
Resume-Queue -Server ex01.test.local -Filter {NextHopDomain -eq 'xs4all.nl'}
```

With the command above we will unpause all mails in the queue who need to be delivered to the domain xs4all.nl