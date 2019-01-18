---
id: 2177
title: How to reprocess messages from a queue
date: 2011-05-05T22:11:49+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2177
permalink: /how-to-reprocess-messages-from-a-queue/
categories:
  - Exchange
---
This week I received a question via e-mail about an Exchange 2010 environment. In this environment some big problems did occur which caused a large amount of messages to be placed in the _Unreachable_ queue. Messages will be placed in the queue when Exchange can&#8217;t deliver the messages. This can be both messages which need to be sent to external mailservers or internal Exchange servers.

The queues can be viewed via two methods:

  * via the queue viewer
  * via the Powershell cmdlet _get-queue_

Using the first method you can also view specific messages which are located in a queue. By default some attributes will be registered from each message among them:

  * sender
  * receiver
  * subject
  * date and time

You might chose to export the messages and import them again to a queue. But in most cases this will not be a suitable solution when hunderds or maybe thousands of messages are located in a queue.

In this kind of scenarios you can better use the _Retry-Queue_ cmdlet. Using this cmdlet messages are resubmitted to the categorizer. Two things this component is responsible for is searching the address of the recipient and route messages. To route a message correctly a message is placed in a queue which is used to deliver the message to the recipient. When you are having a look in the queue viewer you will see several queues among them a queue for each mailbox database. Besides this, queues can be found which are used to deliver messages to the internet. When using a smarthost only one queue will be seen here which is used to deliver messages to the internet.

When messages can&#8217;t be delivered in a specific time range messages will be placed in the _Unreachable_ queue. This can for example happen when the mailbox server is not reachable.

To resubmit this messages you will need to use the following cmdlet:

```PowerShell
Retry-Queue -Identity <servername>\Unreachable -Confirm -Resubmit $true
```

For example:

```PowerShell
Retry-Queue -Identity HUB01\Unreachable -Confirm -Resubmit $true
```

In the example above all messages from the _Unreachable_ queue on the server _HUB01_ will be resubmitted.

After running the cmdlet the messages will be delivered. Depending on the amount of messages this may take some time.

For more information have a look at the page below.:

Technet: Resubmit Messages in Queues <a href="http://technet.microsoft.com/en-us/library/aa995987.aspx" target="_blank">open</a>