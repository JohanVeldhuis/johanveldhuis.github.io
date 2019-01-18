---
id: 2182
title: 'ActiveSync doesn&#8217;t work for specific devices'
date: 2011-05-17T21:16:29+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2182
permalink: /activesync-doesnt-work-with-specific-devices/
categories:
  - Exchange
---
A while ago Microsoft announced the <a href="http://blogs.technet.com/b/exchange/archive/2011/04/13/announcing-the-exchange-activesync-logo-program.aspx" target="_blank">Exchange ActiveSync Logo</a> program. Using this program Microsoft will test the compatability of devices with ActiveSync.

One of the reasons for this is the problems which you may experience with some devices and ActiveSync. As administrator/consultant it is sometimes hard to explain why synchronization doesn&#8217;t work to an end user or customer.

At this moment the following devices are certified:

  * Windows Phone 7
  * Windows Phone 6.5
  * Nokia&#8217;s using Mail for Exchange 3.0.50
  * Nokia E7
  * Apple devices using iOS 4

When a device doesn&#8217;t meet the requirements it may cause issues. One of the issues you may experience is that a device doesn&#8217;t synchronize at all. This maybe the case after a mailbox is migrated from Exchange 2003 to Exchange 2010. This last one is an example of one of the issues I experienced myself.

To investigate this issue you will have to use the IIS logs. In the case of the Nokia devices the following could be found in the IIS logs:

_2011-05-06 11:29:50 192.168.1.41 OPTIONS /Microsoft-Server-ActiveSync/default.eas User=XXXXXX&DeviceId=IMEIXXXXXXXXXXX&DeviceType=NokiaEmail&Log=V0\_LdapC9\_LdapL16_Mbx:_
  
_MB.DOMAIN.LOCAL\_Dc:DC.DOMAIN.LOCAL\_Throttle0\_Budget:(A)Conn%3a0%2cHangingConn%3a0%2cAD%3a%24null%2f%24null%2f0%25%2cCAS%3a%24null%2f%24null%2f0%25%2cAB%3a%24null%2f%24null%2f0%25%2cRPC%3a%24null%2f%24null%2f0%25%2cFC%3a1000%2f0%2cPolicy%3aDefaultThrottlingPolicy%5F3006a3a1-0211-447a-99f5-6c0ab8e33c84%2cNorm\_ 443 DOMAIN\Username 192.168.100.201 NokiaE721/2.02(0)MailforExchange+3gpp-gba 200 0 0 140_

_2011-05-06 11:30:11 192.168.1.41 POST /Microsoft-Server-ActiveSync/default.eas User=Username&DeviceId=IMEIXXXXXXXX&DeviceType=NokiaEmail&Cmd=Settings&Log=_
  
_V121\_Ssnf:T\_LdapC4\_LdapL16\_RpcC45\_RpcL125\_Ers1\_Cpo19781\_Fet19999\_Pk0\_Error:_
  
_DeviceNotProvisioned\_As:BlockedP\_Mbx:MB.DOMAIN.LOCAL\_Dc:DC.DOMAIN.LOCAL\_Throttle0\_Budget:(D)Conn%3a1%2cHangingConn%3a0%2cAD%3a%24null%2f%24null%2f1%25%2cCAS%3a%24null%2f%24null%2f1%25%2cAB%3a%24null%2f%24null%2f0%25%2cRPC%3a%24null%2f%24null%2f1%25%2cFC%3a1000%2f0%2cPolicy%3aDefaultThrottlingPolicy%5F3006a3a1-0211-447a-99f5-6c0ab8e33c84%2cNorm%5bResources%3a(Mdb)MBDB01(Health%3a-1%25%2cHistLoad%3a0)%2c(DC.LOCAL(Health%3a-1%25%2cHistLoad%3a0)%2c(DC)DOMAIN.LOCAL(Health%3a-1%25%2cHistLoad%3a0)%2c%5d\_ 443 DOMAIN\Username192.168.100.201 NokiaE721/2.02(0)MailforExchange+3gpp-gba 449 0 0 19999_

The rules above are just two rules of the logging. In the first rule you can see that the user will authenticate and the webserver reponds with a 200. In the next step you see that something goes wrong during the provisioning process. When searching on the internet you will find out that Nokia devices are not the only devices who cause problems. Also some Andriod based devices may cause issues with ActiveSync. The problem is caused by the fact that these devices won&#8217;t work with the ActiveSync policy. Using this policy administrators can specify for example the security settings for a device.

When a user logs in via the Exchange Control Panel (ECP) en visits the _Phone_ page he will see the device is visible their. But when getting the properties of the device the following will be displayed:

_Access state:_ 
  
_Access Denied_
  
_Access set by: Security Policy Application_

In some cases this may lead to unwanted scenarios. Most end-users will not be very happy when synchronization stops working, although the reasons for this may be a device issue.

Because it is difficult to make an inventory of which devices are active in your organization it might be wise to implement a workaround. This workaround is only needed temporarily till all devices have been upgraded to the recommended version.

The workaround for this issue is to disable the _default_ ActiveSync policy during a migration. By default this policy will be applied to every user. To do this you will need to use the Exchange Management Shell (EMC):

```PowerShell
Set-ActiveSyncMailboxPolicy -Identity:Default -IsDefaultPolicy:$false
```

When you will reconfigure the device, although this might not be necessary, you will see it works. Because this creates an unwanted situation it is recommended to solve the real issue.

Beside updating the client it might be necessary to update the firmware of the device. In case of the Nokia devices ActiveSync didn&#8217;t work after the upgrade to Mail-for-Exchange 3.0.50.

When all devices are upgraded it is recommended to enable the ActiveSync policy again:

```PowerShell
Set-ActiveSyncMailboxPolicy -Identity:Default -IsDefaultPolicy:$true
```

For more information about ActiveSync policies you can visit the page below:

Technet: Understanding Exchange ActiveSync Mailbox Policies <a href="http://technet.microsoft.com/en-us/library/bb123484.aspx" target="_blank">open</a>