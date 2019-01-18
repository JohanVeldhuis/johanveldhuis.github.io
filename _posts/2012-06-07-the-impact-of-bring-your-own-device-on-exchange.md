---
id: 2453
title: The impact of Bring Your Own Device on Exchange – mobile devices
date: 2012-06-07T20:57:01+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2453
permalink: /the-impact-of-bring-your-own-device-on-exchange/
categories:
  - Exchange
---
Using ActiveSync or BlackBerry you can give users the ability to sync the content of their mailbox to their mobile device. When BYOD will be introduced in a company you might see an explosion of the number of ActiveSync/BlackBerry devices that connect to your Exchange environment.

So before allowing BYOD mobile devices you should do some investigation. There are two parameters which will be affected:

  * IOPS
  * Megacycles

**IOPS**

Let’s start with looking at the impact a mobile device has on the IOPS Exchange needs to deliver.

Both Activesync and BlackBerry devices will generate additional IOPS per device. RIM did publish a nice [document](http://docs.blackberry.com/nl-nl/admin/deliverables/8864/BlackBerry_Enterprise_Server_for_Microsoft_Exchange-5.0-US.pdf) which describes the impact on the IOPS, which depends on the mailbox profile.

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="338">
      <strong>Email messages sent or received per mailbox per day</strong>
    </td>
    
    <td valign="top" width="255">
      <strong>Estimated IOPS per BlackBerry device</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        50
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.06
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        100
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.12
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        150
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.18
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        200
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.24
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        250
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.30
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        300
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        0.35
      </p>
    </td>
  </tr>
</table>

The numbers above are applicable on an active mailbox copy (DAG) or standalone mailbox copy. The strange thing although is that when you use the HP Sizer for Microsoft Exchange Server 2010 it will multiply the needed IOPS with 2. So it looks like HP did build in some reserves or is using previous values from an earlier Performance Bench Guide from RIM. This because RIM did made some improvements which dramatically decrease the needed IOPS.

I’ve searched for a table which describes the needed IOPS for ActiveSync devices but as far as I know Microsoft did not publish one. When looking at the available sizing tools, for example the HP Sizer for Microsoft Exchange Server 2010, you will see that it multiplies the amount of IOPS with 2. The Exchange 2010 Mailbox Role Requirements calculator will not provide an easy option such as the HP Sizer. The tool from Microsoft does have an option to use a multiplication factor to influence the needed IOPS.

**Megacycles**

As discussed before the second parameter will be the amount of megacycles needed. In the document mentioned earlier RIM did also publish the megacycles per BlackBerry device which are needed.

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td style="text-align: center;" valign="top" width="338">
      <strong>Email messages sent or received per mailbox per day</strong>
    </td>
    
    <td valign="top" width="255">
      <strong>Estimated megacycles per BlackBerry device</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        50
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        1.5
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        100
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        3.0
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        150
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        4.5
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        200
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        6.0
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        250
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        7.5
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="338">
      <p align="center">
        300
      </p>
    </td>
    
    <td valign="top" width="255">
      <p align="center">
        9.0
      </p>
    </td>
  </tr>
</table>

As you can see the needed megacycles will depend on the amount of messages send/received per day. Compared to the IOPS it has a greater impact. RIM does mention in their document that if you use the sizing recommendations of Microsoft it shouldn’t have a big impact on the CAS Servers. The recommendations RIM points to can be found on this [page](http://technet.microsoft.com/en-us/library/ee832795.aspx).

Microsoft also did perform some [tests](http://technet.microsoft.com/en-us/library/ff803560.aspx) to see the impact on the megacycles when ActiveSync is used. In this case they only did some testing with a specific user mailbox profile.

<table width="621" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="111">
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        <strong>Client Access</strong>
      </p>
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        <strong>Hub Transport</strong>
      </p>
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        <strong>Mailbox</strong>
      </p>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="111">
      <p align="center">
        CPU(MHz/user)
      </p>
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        1,60
      </p>
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        0,22
      </p>
    </td>
    
    <td valign="top" width="170">
      <p align="center">
        1,25
      </p>
    </td>
  </tr>
</table>

As you can see Microsoft did divide it per Exchange Role. If you use the Exchange 2010 Mailbox Role Requirements calculator you will need the value as listed in the _Mailbox column_ and use the _megacycles_ _multiplication factor_ to increase the megacycles to an additional 1,25 megacycles per mailbox _._ 

**What if users will use multiple mobile devices?**

Well the answer is quite easy although it is hard to estimate in advance how many users will use multiple devices. When allowing BYOD mobile devices people may use both their mobile phone and their tablet to sync their mailbox content. But it is not limited to two devices.

**Throttling policy**

Exchange 2010 will allow a maximum of 10 devices which sync via ActiveSync per user. So in worst case users can setup 10 partnerships with devices to your Exchange environment.

The 10 devices limit may be a little bit high. 3 or 4 devices is a reasonable amount. But what if you want to limit the maximum allowed ActiveSync devices per user?

If you want to limit the amount of ActiveSync devices per user you will need to modify the throttling policy settings. Depending on your environment you might decide to create additional throttling policies which will allow more ActiveSync devices for example for the management.

To modify the throttling policy you will need to use the _Exchange Management Shell (EMS)_. The output below is the result of the _Get-ThrottlingPolicy:_

[<img class="aligncenter size-medium wp-image-2454" title="get-throttlingpolicy" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/get-throttlingpolicy-300x120.jpg?resize=300%2C120" alt="" width="300" height="120" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/get-throttlingpolicy.jpg?resize=300%2C120&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/get-throttlingpolicy.jpg?w=402&ssl=1 402w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/get-throttlingpolicy.jpg)

As you can see the _EASMaxDevices_ is the parameter which will need to be modified to limit the amount of ActiveSync devices which can be used.

To do this you will need to run the _Set-ThrottlingPolicy_ cmdlet:

_Set-ThrottlingPolicy Default* -EASMaxDevices 1_

The example above will limit the maximum amount of ActiveSync devices to one per user.

**Quarantine new devices**

By default new users will be allowed to connect to Exchange using ActiveSync. Excluded are users which are a member of a protected group such as administrators. To prevent this you can set the action to quarantine new devices.

Using this option all new devices will be placed in quarantine till an administrator approves the device.

There are two ways to place a device in quarantine:

  * Create a rule for each family
  * Modify the default

**Create a rule for each family:**

The option can be found in the Exchange Control Panel (ECP) in the _Phone & Voice_ section:

On the _ActiveSync Access_ page scroll down till you see the _Device Access Rules_ and klik on _New_ to create a new rule:

[<img class="aligncenter size-medium wp-image-2455" title="New Device Access Rule" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/new-deviceaccessrule-300x276.jpg?resize=300%2C276" alt="" width="300" height="276" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/new-deviceaccessrule.jpg?resize=300%2C276&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/new-deviceaccessrule.jpg?w=506&ssl=1 506w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/new-deviceaccessrule.jpg)

Using the _Browse_ __buttons select a family and/or model and select the _Quarantine – Let me decide to block or allow later_ option

**Unknown devices**

The disadvantage of the rule per family is that not all devices may hit this rule. In this case the default settings are used. These can be changed by pressing the _Edit_ button on top of the page:

[<img class="aligncenter size-medium wp-image-2456" title="Exchange ActiveSync Access Settings" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync-300x79.jpg?resize=300%2C79" alt="" width="300" height="79" srcset="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync.jpg?resize=300%2C79&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync.jpg?w=609&ssl=1 609w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync.jpg)

This will bring up a new window which gives you the following options:

  * What is the default action taken when an unknown device tries to connect
  * Which user or distribution group must be notified when an unknown device is quarantined
  * Which text needs to be send to the user which tries to connect with an unknown device

[<img class="aligncenter size-medium wp-image-2457" title="Exchange ActiveSync Settings" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync2-300x275.jpg?resize=300%2C275" alt="" width="300" height="275" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync2.jpg?resize=300%2C275&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync2.jpg?w=578&ssl=1 578w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/activesync2.jpg)

**How about BlackBerry can this be limited also?**

Well in most organizations a BlackBerry Express/Enterprise server is installed which is connected to Exchange. Since the BlackBerry server doesn’t use ActiveSync to sync the EASMaxDevices changed earlier doesn’t have any effect.

A user will need an activation password to connect their device to the BES environment. Administrators will have the option to configure the time a password is valid using the password expiration. Since the password is only valid to activate one device it will prevent the user from connecting multiple devices.  If they want to connect another device they will need to ask their administrator for another activation code.

**Monitoring the ActiveSync usage**

When allowing BYOD mobile devices to sync with your Exchange environment it might be usefull to perform some kind of monitoring. Using the monitoring features you can see how many ActiveSync devices are syncing with your Exchange environment.

Since the mobile devices will connect to an HTTPS service offered by the CAS most things are logged in the IIS logs.

By default all Exchange related HTTP/HTTPS traffic is logged in the same IIS log. This will cause ActiveSync, EWS, OWA and Powershell traffic to be logged in the same IIS log.

The cause of this is that the default setting is to only have one log file per site:

[<img class="aligncenter size-medium wp-image-2458" title="IIS logging" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/iis-300x90.jpg?resize=300%2C90" alt="" width="300" height="90" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/iis.jpg?resize=300%2C90&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/iis.jpg?w=409&ssl=1 409w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/06/iis.jpg)

Since all virtual directories of Exchange are created in the default web site by default all this setting will be applied to these virtual directories to. So reading the log is a little bit difficult although it is possible.

To filter out only the ActiveSync related things you will have to use _Export-ActiveSyncLog_ cmdlet, for example:

_Export-ActiveSyncLog –FileName &#8220;C:\Windows\System32\LogFiles\W2SVC1\ex12607.log&#8221; –UseGMT:$true –OutputPath &#8220;__C:\ActiveSync Report__&#8220;_

__This will create a separate file containing only the ActiveSync related stuff.  The example above will only work for one log. If you want to search all the logs for ActiveSync use this:

_Get-ChildItem &#8220;C:\Windows\System32\LogFiles\W3SVC1&#8221; | Export-ActiveSyncLog –UseGMT:$true –OutputPath &#8220;__C:\Temp\EASReports__&#8220;_

__There are some useful scripts that can be found on the internet to perform some additional actions on the logs:

  * [Create Reports for ActiveSync and log it to a database](http://www.simple-talk.com/content/print.aspx?article=581), Ben Lye
  * <a href="http://www.stevieg.org/2011/12/exporting-exchange-2010-activesync-statistics-ios-devices/" target="_blank">Exporting Exchange 2010 ActiveSync statistics for iOS devices</a>, Steve Goodman

Here ends my blog about the impact BYOD mobile device can have on your Exchange environment. More information about the specific cmdlets can be found on the following sites:

Technet: Export-ActiveSyncLog <a href="http://technet.microsoft.com/en-us/library/bb123821.aspx" target="_blank">open</a>
  
Technet: Set-ThrottlingPolicy <a href="http://technet.microsoft.com/en-us/library/bb123821.aspx" target="_blank">open</a>

<div id="UMS_TOOLTIP" style="position: absolute; cursor: pointer; z-index: 2147483647; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; display: none; background-position: initial initial; background-repeat: initial initial;">
  <img id="ums_img_tooltip" class="UMSRatingIcon" alt="" />
</div>