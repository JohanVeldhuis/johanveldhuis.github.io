---
id: 2026
title: 'File Server Resource Manager: client does not have permission to send as this sender'
date: 2010-10-21T20:49:30+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2026
permalink: /file-server-resource-manager-client-does-not-have-permission-to-send-as-this-sender/
categories:
  - Exchange
---
Windows 2008 R2 contains a new version of the file server resource manager (FSRM) which has been improved a lot. One of the options this tool has is to send notifications for example when an alert is activated. Normally this is really easy to configure, the only thing you need is a mailserver which will accept the traffic and will deliver the e-mail. 

But let&#8217;s assume you have an Exchange 2010 Server in your environment and you use the default receive connectors. In most situations the default receive connector is configured to accept mail which is send from the internet, this can be done by adding the anonymous permission group to the receive connector. 

However this connector can&#8217;t be used by FSRM. When pressing the test button the following event is logged in the application event log: 

[<img title="File Server Resource Manager: event error" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2010/10/event_error-300x47.jpg?resize=300%2C47" alt="" width="300" height="47" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/event_error.jpg) 

As you can see the event will tell you that the account you are using is not allowed to send e-mail as the alert account.

When enabling SMTP logging you will see the following entries in your log:

[<img title="SMTP logging" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2010/10/smtplog-300x138.jpg?resize=300%2C138" alt="" width="300" height="138" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/smtplog.jpg) 

The FSRM will authenticate using the computer account from the system on which FSRM is running, in this case _LAB-DC-01._ But how do you need to configure Exchange so it will accept the message and send the alert e-mail? To accomplish this, a seperate receive connector needs to be created. This because we don&#8217;t want everybody can use this receive connector_._  

But what are the correct settings for the receive connector? The receive connector will need to accept _basic authentication_ and the _anonymous_ permission group needs to be added to the connector. By performing the following Powershell cmdlet the connector is created: 

'''PowerShell
New-ReceiveConnector -Name FSRM -Usage Custom -Bindings 192.168.1.30:25 -RemoteIPRanges 192.168.1.24 -AuthMechanism BasicAuth -PermissionGroups Anonymous 
'''

Now when performing the test again it will succeed: 

[<img title="FSRM: notification message successfully" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2010/10/succes-300x138.jpg?resize=300%2C138" alt="" width="300" height="138" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/succes.jpg)