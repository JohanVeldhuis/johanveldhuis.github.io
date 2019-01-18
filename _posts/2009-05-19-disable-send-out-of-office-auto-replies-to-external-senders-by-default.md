---
id: 1225
title: Disable Send Out of Office auto-replies to External Senders in OWAby default
date: 2009-05-19T19:18:40+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1225
permalink: /disable-send-out-of-office-auto-replies-to-external-senders-by-default/
categories:
  - Exchange
---
A question on the MsExchange.org forum made me thinking. Somebody wandered if it was possible to change the default of the Send Out of Office auto-replies to External Senders option which is on to off.

To change this you must change the file on the CAS server, in this case it&#8217;s the file oofoptions.aspx which can be found in the folder ClientAccess\Owa\forms.

Search for the following line:

<input type=&#8221;checkbox&#8221; id=&#8221;chkExtEnbl&#8221; class=&#8221;chk&#8221;<%=(ExternalEnabled && !ExternalBlocked) ? &#8221; checked&#8221; : &#8220;&#8221; %>>

and change it to:

<input type=&#8221;checkbox&#8221; id=&#8221;chkExtEnbl&#8221; class=&#8221;chk&#8221;<%=(ExternalEnabled && !ExternalBlocked) ? &#8221; unchecked&#8221; : &#8220;&#8221; %>>

Keep in mind that after each Rollup installation you must apply the change again because the rollup may overright the file.