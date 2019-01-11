---
id: 2364
title: Kerberos authentication fails sporadically
date: 2011-12-16T21:06:40+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2364
permalink: /kerberos-authenticatie-mislukt-af-en-toe/
categories:
  - Exchange
---
Earlier this year a [blog](http://blogs.technet.com/b/exchange/archive/2011/04/15/recommendation-enabling-kerberos-authentication-for-mapi-clients.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890) on the Exchange Team site was poste by Ross Smith IV. In this blog he encouraged to use Kerberos as authentication method for Outlook clients.

In a lot of Exchange environments you will see that it is implemented. When you are using a CAS Array you will need to create an alternate service account (ASA) for this. This can be done by using the  [RollAlternateserviceAccountPassword.ps1](http://technet.microsoft.com/en-us/library/ff808311.aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890) script. Keep in mind that when using the _CreateScheduledTask_ parameter the scheduled task will run as the account who created the scheduled task.

After registering the correct SPN&#8217;s on the ASA account Kerberos will work in most cases. In some scenario&#8217;s a typo is made which results in incorrect SPN&#8217;s being registered. When this is the case you can solve it by using [setspn](http://technet.microsoft.com/nl-nl/library/cc755413(WS.10).aspx?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890) or AdsiEdit.

But what if Kerberos sometimes works and sometimes not, or does only work for specific users?  If it doesn&#8217;t work a user will not be able to access his/her mailbox.

The easiest way to figure out if Kerberos is to change the Outlook profile.

[<img title="Outlook security tab" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/Outlook-security-tab-243x300.jpg?resize=243%2C300" alt="" width="243" height="300" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/Outlook-security-tab.jpg)

On the _security_ tab of the account you will need to change the value of _Logon network security _to _NTLM._ If the user can access his/her mailbox after this you know that Kerberos is causing the issue.

Besides this an event will be logged in the _system event log_. Because a small set of logging is enabled on the Windows Servers you won&#8217;t see the Kerberos issue on that side. To enabled the logging you will need to make a change in the registry:

  * start _regedit_
  * browse to _HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters_
  * create a Dword called _LogLevel_
  * change the value of the Dword to _0x1_

Logging is directly enabled after creating the registry key and after a refresh you will see several Kerberos errors in the log.

Another option is to create a network trace using [Wireshark](http://www.wireshark.org/download.html) or [Netmon](http://www.microsoft.com/download/en/details.aspx?id=4865). In both cases you will see the following message in the trace:

_0xD &#8211; KDC\_ERR\_BADOPTION: KDC cannot accommodate requested option_

When you will search the internet for this error you will see you are not the only one. But let&#8217;s start from the begin instead of going to directly to the solution.

One of the first things you will need to do is run _SetSPN -L &#8220;ASA account&#8221;_  to verify that all correct SPN&#8217;s are registered. The SPN&#8217;s should be unique. Despite I have seen environments where the domain controllers also contain two SPN&#8217;s named _ExchangeAB _followed by the netbios and fqdn. To verify if the SPN&#8217;s are unique you can use _SetSPN -Q &#8220;SPN VALUE&#8221;_ , for example _SetSPN -Q ExchangeAB/*_.

[<img title="setspn -q" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/setspn-q-300x241.jpg?resize=300%2C241" alt="" width="300" height="241" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/setspn-q.jpg)

As displayed in the screenshot above you will see ExchangeAB will be found four times. Two times on the Exchange Server and two times on the DC.

As fas as we can see at this moment everything looks OK. Time to continue troubleshooting. But with which step can you continue when you have the error above? Klist.exe or Kerbtray.exe will not help a lot because in most cases renewing the tickets won&#8217;t solve the issue.

After some research together with a customer we found the root cause of the issue.

Microsoft did change the UDP packet size starting from Windows 2003. In Windows XP the UDP packet size was set to 2000, starting from 2003 it has been set to 1465. I think you know what will happen when Kerberos will send a package. Kerberos will use UDP by default . This will result in incompleted packages which will arrive at servers containing Windows 2003 or above as OS.

But why does the issue only happens for some users? This depends on the Kerberos ticket size. The size of a Kerberos ticket is determind by:

  * length of the password
  * membership of groups
  * do the groups contain other nested groups

To solve this issue you will need to make a registry change:

  * start _regedit_
  * browse to HKEY\_LOCAL\_MACHINE\System\CurrentControlSet\Control\Lsa\ Kerberos\Parameters
  * create a Dword called _MaxPacketSize_
  * change the value of the Dword to _1_

By making this change all Kerberos packages which are bigger then 1K will be send by using Kerberos over TCP.

Restart the computer and change the Outlook profile to _Negotiate Authentication_. Verify if you can access the mailbox. Using klist.exe or kerbtray.exe verify of the tickets will be created correctly. Both tools are part of the [resource kit ](http://www.microsoft.com/download/en/details.aspx?id=17657?ocid=aff-n-we-loc--ITPRO40890&WT.mc_id=aff-n-we-loc--ITPRO40890)for Windows 2003. In Windows 7 and 2008 klist is a part of the OS.

[<img title="Kerberos tickets" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/Kerberos-tickes-300x121.jpg?resize=300%2C121" alt="" width="300" height="121" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/12/Kerberos-tickes.jpg)

In this screenshot two Kerberos tickets are listed which are being used by Exchange. If all authentication is performed by using Kerberos you will see the following Kerberos tickets:

  * exchangeMDB
  * exchangeRFR
  * exchangeAB
  * http

When you will look in the event log of the client you won&#8217;t find any Kerberos messages.

Microsoft has published a complete document about troubleshooting Kerberos authentication issues. You can find the document [here](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=21820).