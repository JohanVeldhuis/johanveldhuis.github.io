---
id: 1783
title: Chinese signs in non-delivery reports
date: 2009-12-21T20:30:16+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1783
permalink: /chinese-signs-in-non-delivery-reports/
categories:
  - Exchange
---
I know it may sound strange, Chinese signs in non-delivery reports. After some investigation I discovered something which made the problem stranger then I first thought. When the message was printed the text was displayed in Dutch.

When the same mail was sent from an Outlook 2003/2007 client the problem was not there. So I decided to start searching on the internet and after a while I found something on the Technet forum which looked pretty much on the problem I had.

The problem is caused by a bug in Outlook XP which will not be fixed anymore. To make the problem clear I summarized some details below:

  * mail-client is Outlook XP
  * happens only when a NDR is delivered in HTML format
  * when the mail is printed everything look OK

To fix this issue you will need to tell your Hub server that every NDR needs to be sent as a plain-text NDR, this can be done by executing the following Powershell command:

```PowerShell
Get-TransportServer | Set-TransportServer –InternalDsnSendHtml $False
```

Another solution is upgrading your Outlook client to 2003 or higher.