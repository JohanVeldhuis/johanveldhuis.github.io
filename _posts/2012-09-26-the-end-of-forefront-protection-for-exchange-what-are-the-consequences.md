---
id: 2528
title: The end of ForeFront Protection for Exchange (FPE) what are the consequences?
date: 2012-09-26T07:24:01+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2528
permalink: /the-end-of-forefront-protection-for-exchange-what-are-the-consequences/
categories:
  - Exchange
---
Last Saturday we recorded the 8th episode of <a href="http://www.theucarchitects.com/" target="_blank">TheUCArchitects</a> and one of the subjects was the announcement made by Microsoft about TMG and ForeFront Protection for Exchange.

Since it was a really nice discussion about the consequences for both the reverse proxy part as the A/V part I decided to write a blog about it. In this blog we will only concentrate on the A/V part because that’s the subject where not a lot of people have discussed about.

So let’s start with a short description of ForeFront Protection for Exchange. It can be used to scan both the message traffic as in store scanning. It can be configured to use several A/V engines to scan a message. This has the advantage that if one of the A/V engines doesn’t contain the pattern it will be picked out by an engine which does contain the pattern. The downside of this is that is can cost a lot of resources so during the sizing process don’t forgot to take them into account.

Besides the on-premises product Microsoft does also have a Cloud solution called ForeFront Online Protection for Exchange (FOPE). This product will only scan messages which are sent to or from your mailserver.

Last week Microsoft did announce to stop several ForeFront products among them ForeFront Protection for Exchange.

Probably Microsoft wants to push customers to FOPE but does FOPE really covers all features ForeFront Protection for Exchange contained? Well the answer is quite easy. No it will not cover everything.

Let’s start with the scanning of the scanning of the mailboxes also known as instore scanning. This feature has the advantage that you can perform real-time, scheduled or a manual A/V scan on the store scanning. This may be necessary if an outbreak has occurred or just as additional maintenance once a month.

The second feature is scanning the message content between internal clients. Since this won’t be send via the cloud threats can only be detected by an A/V solution on your Hub server which will add a transport agent to perform message scanning. Of course all your company clients will contain a local A/V client so it might be found by this one.

If you had time to look at the Tech Preview of Exchange 2013 you might have seen that it contains an antispam and antimalware feature by default. Especially the antimalware feature might be interesting for some organizations. This feature will add some basic antimalware protection to protect your environment from receiving malware. Because the product is not RTM this may change when it hits the RTM status.

The antimalware feature is enabled by default and can be combined with using message filtering in the cloud. By default messages scanned by the hosted email filtering service will not be scanned again when they arrive on your on-premises servers. However this configuration can be changed so it both scans messages using the hosted email filtering service and the antimalware feature from Exchange 2013. As far as I have discovered it only contains one AV-engine so the other engines which were available in ForeFront Protection for Exchange are not available anymore.

Also instore scanning will not be provided by the feature only messages which will be send/received by your transport servers. The actions that can be configured for the feature are:

  * Block entire message
  * Delete attachments and use either the default or customer alert

As you can see no quarantining option is available it’s either delete the complete message or only delete the attachments.

For those companies who will require stuff like quarantining, multi av-engines, instore scanning, etc. the only option left is to select a 3<sup>rd</sup> party product. At this moment I haven’t seen any vendors that already published a beta of their product with Exchange 2013 Tech Preview. But I think this will be a matter of time before vendors will announce their products to support the new Exchange.

What the future will bring? That’s just a matter of time, let’s wait till Exchange 2013 hits RTM and see if anything has changed in the antimalware feature.

<div>
  <hr align="left" size="1" width="33%" />
  
  <div>
    <div>
      <p>
         <a href="file:///C:/Users/j.veldhuis/Documents/FOPE.docx#_msoanchor_1">[JV1]</a>Officiele statement nog opzoeken
      </p>
    </div>
  </div>
</div>