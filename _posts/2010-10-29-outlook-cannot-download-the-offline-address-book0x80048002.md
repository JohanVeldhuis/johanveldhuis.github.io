---
id: 2038
title: 'Outlook can&#8217;t download offline address book: error 0x80048002'
date: 2010-10-29T14:35:30+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2038
permalink: /outlook-cannot-download-the-offline-address-book0x80048002/
categories:
  - Exchange
---
Since Exchange 2010 both Outlook 2007 and 2010 will download the offline address book (OAB) by using the  Exchange Web Services and not via Public Folders just like Outlook 2003 anymore.

When having issues with Web Services this may result in issues you won&#8217;t like to have, for example downloading the addressbook in Outlook 2007/2010 does not work anymore, Outlook will continiously tries to synchronize and users may receive warnings/errors.

But where do you have to start with troubleshooting in these kind of situations? My advise start at the client side to see which warning a user receives. To do this we will need to manually download the addressbook. This option can be found here:

  * tab Sender/Receive
  * Send/Receive Groups
  * Download Address Book

The following screen will be displayed:

[<img title="Download Address Book" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2010/10/oab-300x229.jpg?resize=300%2C229" alt="" width="300" height="229" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/oab.jpg)

Just leave all options default and click OK to download the address book. When this will not work you may receive an errorcode, for example 0x80048002

This error will tell you it has some problems downloading the address book from the CAS server using Exchange Web Services. But how can you test if the OAB is working correctly on a CAS server. Well it&#8217;s not really easy, there are a few options:

  * try to open the OAB using Internet Explorer
  * search the IIS log files

The first option is not really difficult but doesn&#8217;t guerantee that OAB is working correctly. By default the OAB can be accessed using _http://naam of the server/oab_, for example _http://exchange.domain.local/oab_ __or _https://exchange.domain.com/oab._

When trying to access the site it will ask for authentication, once correctly authenticated the following message is displayed:

[<img title="Access OAB via Internet Explorer" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/Capture2-300x15.jpg?resize=300%2C15" alt="" width="300" height="15" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2010/10/Capture2.jpg)

When OAB isn&#8217;t correctly configured or it has been manually changed then you might receive the following error:

[<img title="Exchange OAB error 500.19" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2010/10/Capture3-300x88.jpg?resize=300%2C88" alt="" width="300" height="88" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/10/Capture3.jpg)

As you can see in the screenshot above IIS has some issues while reading the config file. In this case this was caused by an webconfig.xml file which was placed in the OAB virtual directory. This resulted in problems while downloading the OAB when using Outlook 2007/2010.

When the problem can&#8217;t be solved via the easy way you may need to enable some additional logging. In case of OAB issues you might raise the logging level for the following items:

  * MSExchangeFDS
  * MsExchangeSA: OAL Generator

The logging level can be changed in two different ways: Exchange Management Console and the Exchange Management Shell.

**Exchange Management Console**

  * open the Exchange Management Console
  * select the option _Server Configuration_
  * select the option _Manage Diagnostic Logging_
  * select the item for which you want to raise the logging level, for example to _expert_

**Exchange Management Shell (EMS)**

In the EMS you will need to use the _set-eventloglevel_ cmdlet to raise the logging level, for example

```PowerShell
Set-EventLogLevel –Identity “SRV-MBX-01\MSExchangeSA\OAL Generator” –Level Expert
```

The command above will raise the logging level for the AOL Generator to Expert on the server called _SRV-MBX-01._

Note: don&#8217;t forget to reset the logging level to the original value when troubleshooting is completed.