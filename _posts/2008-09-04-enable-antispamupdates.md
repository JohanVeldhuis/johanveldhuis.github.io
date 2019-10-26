---
id: 778
title: Enable-AntispamUpdates
date: 2008-09-04T22:19:53+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=778
permalink: /enable-antispamupdates/
categories:
  - Exchange
---
[<img class="alignnone size-thumbnail wp-image-779" title="get-antispam" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2008/09/get-antispam-150x128.jpg?resize=150%2C128" alt="" width="150" height="128" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2008/09/get-antispam.jpg?resize=150%2C128&ssl=1 150w, https://i1.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2008/09/get-antispam.jpg?zoom=2&resize=150%2C128&ssl=1 300w, https://i1.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2008/09/get-antispam.jpg?zoom=3&resize=150%2C128&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2008/09/get-antispam.jpg)

In Exchange 2007 you can activate the anti-spams on the Edge Transport or Hub Transport server. Via Microsoft update you can update the agents, spammers are developing their techniques daily. With the command _Get-AntispamUpdate_ you can get the current settings.

To update the Anti-spam agents automaticaly we need to execute one of the following Powershell commands:

```PowerShell
Enable-AntispamUpdates -Identity srv-exc -IPReputationUpdatesEnabled $True -UpdateMode Automatic -SpamSignatureUpdatesEnabled $True
```

or

```PowerShell
Enable-AntispamUpdates -Identity srv-exc -IPReputationUpdatesEnabled $True -MicrosoftUpdate RequestedNotifyDownload -UpdateMode Automatic -SpamSignatureUpdatesEnabled $True
```

In both cases we activate automatic updating of the Anti-spam agents for the server with the name _srv-exc._ The difference between the first and second method is that in the second method we also setup Microsoft Update. The second method needs only to be used if Microsoft Update hasn&#8217;t been setuped.