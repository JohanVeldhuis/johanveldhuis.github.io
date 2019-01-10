---
id: 2633
title: 'The Exchange 2013 alphabet: ActiveSync'
date: 2013-01-15T13:41:48+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2633
permalink: /het-exchange-2013-alfabet-activesync/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2013/01/LogParser.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
We will start this Exchange alphabet blog series with ActiveSync.

Using ActiveSync you will be able to synchronize your mailbox content with mobile devices which support ActiveSync. The ActiveSync feature was originally introduced in Exchange 2000 besides the Outlook Mobile Access (OMA). The last one has been a way for a while but was introduced again with Exchange 2010 SP2 but is not included with Exchange 2013 anymore.

But what is the advantage of ActiveSync compared to other protocols which can be used to sync the content of your mailbox? ActiveSync has the ability to apply policies to mobile devices which include but are not limited to: require a PIN to unlock the phone, disable features of the phone, require encryption of the storage cards, etc. We will have a look at these option and how to configure them later in this article.

**How it works**

Let’s start with having a look how ActiveSync works.

ActiveSync uses a Direct Push to keep the mobile device up-to-date via the wireless or cellular connection. The Direct Push feature is enabled by default in Exchange 2013. When a mobile device is configured to use ActiveSync and supports the Direct Push technology it issues a long-lived HTTPS request to the Exchange server. In the Technet documentation for Exchange this is sometimes called a PING. With this request the server is informed to send notifications when items change in any folder which the mobile device is configured to sync. This is done the first 15-minutes and is also called the heartbeat interval.

After this 15 minutes the server sends a HTTP 200 OK to device if no items has been changed. When the device receives this response it wakes up and issues another request which restarts the process from sending a long-lived HTTPS request.

[<img title="ActiveSync" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ActiveSync-300x52.jpg?resize=300%2C52" alt="" width="300" height="52" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ActiveSync.jpg)

But what happens if a change is detected in the mailbox within the 15-minute timespan? For example a new mail is received in the mailbox? In this case the server will send a response to the mobile device that there is a new item and provides the name of the folder where the item resides. Once the mobile device has received this response it will issue a synchronization request for the specific folder. When the synchronization has completed the mobile device issues a new PING request and the process of the long-lived HTTPS request restarts.

The same is valid for items which have changed in the mailbox. OK now we know how ActiveSync works let’s have a look what the requirements are for the network infrastructure.

To make the ActiveSync feature available for end users you will need to open port 443 on your firewall. In most cases you won’t publish Exchange directly to the internet so traffic will first arrive at a reverse proxy and then is forwarded to the Exchange server.

But what about the long-lived HTTPS session does that require any changes to the network-infrastructure? Ideally you would like to change the time-out of your firewall from 15 minutes to 30 minutes. But what if you firewall or maybe the mobile service provider doesn’t support this maximum time-outs? Or maybe organizational policies won’t allow the time-out for HTTPS to be changed to such a long time. Will this cause that ActiveSync won’t work? Well not exactly if the network doesn’t support these high time-out values ActiveSync will act as follows.

Let’s assume that your mobile provider only supports 10 minutes.

The device will send the long-lived HTTPS request to the server. After 15 minutes the device hasn’t received a reply from the Exchange server the device will assume that the connection was timed-out by the network.

In this case the device will send another HTTPS request but changes the heartbeat internal to 8 minutes. After 8 minutes the device receives a response HTTP 200 OK message from the server. The device will try if a higher heartbeat interval is possible. It will send another HTTPS request and changes the heartbeat internal to 12 minutes.

Since the mobile provider only supports 10 the mobile device will not receive a HTTP 200 OK from the server. So after 12 minutes the mobile will assume a network error and will send a long-live HTTPS request only then with a heartbeat interval of 8 minutes.

[<img title="Activesync" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Activesync-2-300x77.jpg?resize=300%2C77" alt="" width="300" height="77" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Activesync-2.jpg)

**Environment requirements**

So what are the requirements before you can use ActiveSync? I will keep this part short as we already discussed most things in the previous paragraph. The requirements for using ActiveSync are:

  * Exchange is published to the internet (recommended via a reverse proxy)
  * User is enabled for ActiveSync (which is by default)
  * User does have an ActiveSync compatible device
  * A valid certificate has been installed on your Exchange server (and on your reverse proxy if applicable)

The first one is the one which might caught your attention. As you may know Microsoft has announced that they won’t continue their ForeFront Threat Management Gateway (TMG for short). So if you haven’t got one in place you will need to select another product which can be used as a reverse proxy. Once of the solutions which has been announced is from KEMP Technologies. They will come with an update for their Load Balancers which makes it possible to publish Exchange via a secure way. So if you are planning to buy load balancers please take a look at the website of KEMP Technologies for more information. The update is planned to be available the Q1 of 2013.

**Configuring**

Configuring ActiveSync consists of a few steps:

  * Configure the ActiveSync url
  * Configure the Mobile Device Mailbox Policy

Both steps can either be performed by using the Exchange Admin Center (EAC) or the Exchange Management Shell (EMS).

Configuring via the EAC can be done by performing the following steps:

  * Open the _EAC_
  * Select _servers_
  * Select _virtual directories_
  * Select the  _Microsoft-Server-ActiveSync _entry
  * Click on the Edit button

[<img title="ECP" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ECP-300x145.png?resize=300%2C145" alt="" width="300" height="145" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ECP.png)

Modify both the internal and external URL so they contain the correct FQDN you are using to publish your Exchange server.

The same step can be performed by using the _Set-ActiveSyncVirtualDirectory _cmdlet using the EMS:

_Set-ActiveSyncVirtualDirectory  -Identity &#8220;ex01\Microsoft-Server-ActiveSync&#8221;  -Internalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync  -Externalurl https://mail.johanveldhuis.nl/Microsoft-Server-ActiveSync_

Next step is to modify the Mobile Device Mailbox Policy, in Exchange 2007/2010 this was called the ActiveSync Mailbox Policy. Compared to these policies the policy options might look limited Exchange 2013 when looking at the GUI:

[<img title="ECP" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ECP-2-196x300.png?resize=196%2C300" alt="" width="196" height="300" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/ECP-2.png)

So the disabling features on devices is not possible anymore via the GUI. But in the EMS you can enable/disable a lot of more options which we will not discuss in this article because it’s a pretty long list. A few examples are:

  * DisableRemovableStorage
  * DisableIrDA
  * DisableDesktopSync
  * BlockRemoteDesktop
  * BlockInternetSharing

For a complete overview have a look at [this](http://technet.microsoft.com/en-us/library/bb123783.aspx) TechNet article.

If you are using Windows Phone 7 devices you must pay attention to the following.

If you want to let these devices sync their mailbox content either allow non provisionable devices or do not enable the previous mentioned options plus following options:

  * PasswordRequired
  * MinPasswordLength
  * IdleTimeoutFrequencyValue
  * DeviceWipeThreshold
  * AllowSimplePassword
  * PasswordExpiration
  * PasswordHistory
  * DisableRemovableStorage
  * DisableIrDA
  * DisableDesktopSync
  * BlockRemoteDesktop
  * BlockInternetSharing

So let’s assume we want to create a policy which:

  * Allows Bluetooth
  * Allow Browser usage
  * Allows Camera usage
  * Requires a password
  * Enables password recovery options
  * Allows Wifi

We will call this policy IT because it will be a policy applied to all users in the IT department. To create the new policy we will use the _New-MobileDeviceMailboxPolicy _cmdlet:

New-MobileDeviceMailboxPolicy -Name:&#8221;IT&#8221; -AllowBluetooth:$true -AllowBrowser:$true -AllowCamera:$true -PasswordEnabled:$true -AlphanumericPasswordRequired:$true -PasswordRecoveryEnabled:$true -AllowWiFi:$true

Once the policy is configured either via EAC or EMS we need to assign it to a user, there is one exclusion for this. The Mobile Device Mailbox Policy called _Default _which will be assigned to all users which will not match another policy.

Via the EAC you will need to complete this steps:

  * Select Recipients
  * Select Mailboxes
  * Select the mailbox which you would like to modify
  * In the _details_ pane scroll to the _Phone and Voice Features _select _View details _to display the Mobile Device Details screen
  * Press _browse _and select the correct policy
  * Click _OK _to close the window

Via the EMS you can do it like this:

_Get-Mailbox | where { $_.Department -eq &#8220;IT&#8221; } |_

Set-CASMailbox -activesyncmailboxpolicy(Get-ActiveSyncMailboxPolicy &#8220;IT&#8221;).Identity

After these things has been configured it’s time to connect your device to you Exchange environment. On most devices you can use the Autodiscover functionality from Exchange to configure your device the easy way. But what if it doesn&#8217;t work? Then it is tome for some troubleshooting.

**Troubleshooting**

For troubleshooting there are a few things which can help you. If you just have built your environment you might want to have a look at the [Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/) from Microsoft. This tool gives you a detailed result which helps you to identity the issue easily.

Besides this tool you could have a look at the IIS logging. But keep in mind that these logs are not only used for Activesync but for all Web Services of Exchange. Starting from Exchange 2013 Exchange contains several built-in test functionalities. These test functionalities also cause a lot of IIS logging. So to filter out only ActiveSync related logging it might be handy to filter the logs. This can be done by using the _Export-ActiveSyncLog _cmdlet, for example:

_Export-ActiveSyncLog -Filename:&#8221;c:\Inetpub\logs\LogFiles\W3SVC2\u_ex130111.log&#8221; -StartDate:&#8221;2013-1-11&#8243; -EndDate:&#8221;2013-1-12&#8243; -UseGMT:$true -OutputPath:&#8221;c:\exreports\eas\&#8221;_

The cmdlet above will export all ActiveSync related logging from the 11<sup> th</sup> and 12<sup>th</sup> of January. All results will be exported to a directory called eas.

When looking in the directory after running the cmdlet you will see a couple of files have been created:

[<img title="Export-ActiveSynclog" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Export-ActiveSynclog-300x39.png?resize=300%2C39" alt="" width="300" height="39" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/Export-ActiveSynclog.png)

So which information is included in each file:

  * **Servers.csv: **does include the average unique devices and hits per server****
  * **Hourly.csv:** ActiveSync activity hour-by-hour****
  * **StatusCodex.csv:** overview of status codes issued in response to ActiveSync requests summarized per status code****
  * **PolicyCompliance.csv: **overview on device compliance with ActiveSync policy****
  * **UserAgents.csv: **gives an overview of hits and unique devices per user agent****

The last tool is not really a troubleshooting tool but more a tool to generate nice reports. To generate these reports you could use the [Log Parser](http://www.microsoft.com/downloads/details.aspx?FamilyID=890cd06b-abf8-4c25-91b2-f8d975cf8c07&displaylang=en) from Microsoft.

As my test environment doesn’t contain a lot of interesting information I generated it on another Exchange server.

I used the following cmdlet:

_logparser &#8220;SELECT cs(user-agent), count(\*) as Devices into chart.gif from c:\inetpub\logs\logfiles\w3svc1\u_ex\*.log WHERE cs-uri-stem LIKE &#8216;%microsoft-server-activesync%&#8217; and cs-username is NOT NULL GROUP BY cs(User-Agent) ORDER BY Devices desc&#8221; -charttype:pieexploded3d -ChartTitle:&#8221;Device Activity by Type&#8221; -categories:OFF_

Using this cmdlet we can generate the following report:

[<img title="LogParser" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/LogParser-300x225.png?resize=300%2C225" alt="" width="300" height="225" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/01/LogParser.png)

Here ends the first blog in the Exchange ABC series. In this blog we did have a look at ActiveSync: how it works, how you can configure it and troubleshoot it.

Below you will find some useful links to sites containing ActiveSync related information.

**Useful links:**

Publishing Exchange Server 2013 using TMG:

<http://blogs.technet.com/b/exchange/archive/2012/11/21/publishing-exchange-server-2013-using-tmg.aspx>

Enabling Exchange ActiveSync’s Quarantine Features in an existing organization

<http://www.stevieg.org/2013/01/implementing-exchange-activesyncs-quarantine-features/>

Understanding Export-ActiveSyncLog:

<http://www.windowsitadmin.com/2012/02/02/understanding-export-activesynclog-part-1-2/>

Reporting on Mobile Device Activity Using Exchange 2007 ActiveSync Logs:

<http://www.simple-talk.com/sysadmin/exchange/reporting-on-mobile-device-activity-using-exchange-2007-activesync-logs/>

More fun with Logparser and Exchange logs:

<http://blogs.technet.com/b/exchange/archive/2007/09/12/3403903.aspx>