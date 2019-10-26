---
id: 2469
title: Disable Exchange Store Time-Out Detection
date: 2012-06-24T21:33:04+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2469
permalink: /disable-exchange-store-time-out-detection/
categories:
  - Exchange
---
In my last blog we discussed the functionality of quarantining a mailbox if:

  * Thread doing work for a mailbox fails
  * More than five threads in a mailbox that haven’t made progress for a long time (more than 60 seconds)

In some cases this might cause a situation which is not acceptable if this issue occurs multiple times within one week or maybe multiple times a day. In my last blog we talked about how to see that a mailbox is quarantined. But wouldn’t it be nice to monitor it to prevent mailboxes from being quarantined?

When one of the earlier issues occurs the following events will be logged in the application log:

  * Event 10025: Reports a time-out on the Exchange server
  * Event 10026: Reports a time-out on the database
  * Event 10027: Reports a time-out on an individual mailbox

All the events will have the same source _MsExchangeIS_. Besides the event logs you might decide to use the performance counters to monitor the environment for this specific kind of issue. In this case add the following counters to the Performance Monitor:

  * RPC Request Timeout Detected on Mailbox
  * RPC Request Timeout Detected on Database
  * RPC Request Timeout Detected on Server

The performance counters can be found under the context _MsExchangeIS_.

But what if you see that this issue happens many times and you want to disable the quarantine functionality? First of all I would not recommend doing this and try to find the source of the issue. This because a large amount of threads will have an impact on your complete environment. But as discussed earlier the quarantining may have a negative impact on the business and so you may lose money. So after reading this think twice discuss this with some colleagues and your manager. If everybody agrees with taking the risks perform the following steps to turn off the quarantine feature:

  * Open Regedit
  * Browse to the following location: HKLM\System\CurrentControlSet\Services\MsExchangeIS\__
  * Create a new DWORD (32-bit)called DisableTimeoutDetection
  * Set the value to 1

Although not mentioned in the help files of Microsoft it might be wise to restart the Information Store service after making the change. In this case make sure you dismount all databases or *over them to another DAG node if applicable.

If you want to have more information about this topic visit the page below:

Technet: Turn Off Exchange Store Time-Out Detection <a href="http://technet.microsoft.com/en-us/library/ff477616.aspx" target="_blank">open</a>

<div id="UMS_TOOLTIP" style="position: absolute; cursor: pointer; z-index: 2147483647; background: none repeat scroll 0% 0% transparent; display: none;">
  <img id="ums_img_tooltip" class="UMSRatingIcon" alt="" />
</div>