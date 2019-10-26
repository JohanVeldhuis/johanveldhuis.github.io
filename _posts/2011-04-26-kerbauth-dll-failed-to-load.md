---
id: 2168
title: kerbauth.dll failed to load
date: 2011-04-26T20:44:51+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2168
permalink: /kerbauth-dll-failed-to-load/
categories:
  - Exchange
---
Both the Exchange Management Console (EMC) and Exchange Management Shell (EMS) are making a connection to Powershell using a remote session. During the session a connection will me made to the virtual directory Powershell which can be found in the IIS Management Console. This virtual directory can only be accessed by using port 80 by default.

To authenticate users Kerberos is used. During the Exchange setup a seperate dll has been installed.

In case of a remove and re-install of Exchange on another volume this may lead to problems. Of course this is a scenarion which you won&#8217;t see a lot.

[<img title="Kerbauth.dll error in event log" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/04/eventlog-300x47.jpg?resize=300%2C47" alt="" width="300" height="47" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/04/eventlog.jpg)

After Exchange is completely re-installed on the new location you won&#8217;t be able to start the EMC anymore. In the event log you will see a lot of errors just like the one above.

Because IIS is used some configuration settings are stored in. These files can be found on the following location _c:\windows\system32\inetsrv\config\_ for example the _applicationhost.config_.

In the section _globalmodules_ several modules such as the authentication methods, redirection and the other modules are listed here. This is done by refering to the dll which is required.

Because the kerbauth.dll is a native module this dll is also listed and the location specified is the Exchange installation directory. In some cases this rule is not deleted or updated and keeps pointing to the old location. The result: the DLL can&#8217;t be found.

The problem can be solved very easily by correcting the path and ensure that it points to the correct location. This can be done by using the variable _ExchangeInstallPath (Exchange 2007 only)_.

For more troubleshooting tips you can visit the page below. Here you will find several issues and the solution for these issues.

Technet: Powershell Virtual Directory issue causes problems with EMS [open](http://technet.microsoft.com/en-us/library/ff607221(EXCHG.80).aspx)