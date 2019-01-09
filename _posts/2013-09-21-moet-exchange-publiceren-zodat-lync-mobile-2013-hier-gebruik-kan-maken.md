---
id: 3276
title: How to publish your Exchange environment correctly for Lync Mobile 2013
date: 2013-09-21T09:23:34+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3276
permalink: /moet-exchange-publiceren-zodat-lync-mobile-2013-hier-gebruik-kan-maken/
categories:
  - Exchange 2010
---
Several companies have published their Exchange environment by using TMG. As you may know Microsoft has announced to discontinue the product but when working in the field you will still see that customers are using TMG.

One of the features of the Lync 2013 mobile client is to retrieve your contacts and free/busy information using Exchange Web Services (EWS). It depends on your TMG config if this will work. You may wonder why? For this we will need to have a closer look at the listener. For those who do not work much with TMG using the listener we can configure:

  * Which certificate is used to provide HTTPS
  * What kind of authentication types do we accept

So the item we need to have  closer look at is the authentication types. Using the authentication types we can configure how clients can authenticate against our Exchange environment. There are various options which you can configure for authentication amongst them:

  * HTTP form
  * Basic

Let’s assume you created one rule to publish OWA, ECP, ActiveSync, EWS and Autodiscover. In this case the listener is probably configured to offer form based authentication. Which will perfectly work for Outlook, OWA, ECP and ActiveSync. But it doesn’t work for Lync 2013 mobile clients. Normally when clients try to authenticate they will hit the form. Some clients however can’t authenticate using the form and will fall back to basic authentication. ActiveSync devices are an example of clients which work like this.

But the Lync 2013 mobile client doesn’t contain the option to fall back to basic authentication which results in authentication to fail. When you have enabled the logging on your device and examine it after trying to authenticate you will see this:

First the form will be displayed (below a small part of the code):

<pre class="brush: html; gutter: false">&lt;em&gt;&lt;!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"&gt;&lt;/em&gt;
&lt;em&gt;&lt;!-- {57A118C6-2DA9-419d-BE9A-F92B0F9A418B} --&gt;&lt;/em&gt;
&lt;em&gt;&lt;html&gt;&lt;/em&gt;
&lt;em&gt;&lt;head&gt;&lt;/em&gt;
&lt;em&gt;    &lt;title&gt;Microsoft Forefront TMG&lt;/title&gt;&lt;/em&gt;
&lt;em&gt;    &lt;meta http-equiv="Content-Type" content="text/html; CHARSET=utf-8"&gt;&lt;/em&gt;
&lt;em&gt;    &lt;meta content="NOINDEX, NOFOLLOW" name="Robots"&gt;&lt;/em&gt;
&lt;em&gt;    &lt;link href="/CookieAuth.dll?GetPic?formdir=3&image=logon_style.css" type="text/css" rel="stylesheet"&gt;&lt;/em&gt;
&lt;em&gt;    &lt;script src="/CookieAuth.dll?GetPic?formdir=3&image=flogon.js" type="text/javascript"&gt;&lt;/script&gt;&lt;/em&gt;
&lt;em&gt;&lt;script type="text/javascript"&gt;&lt;/em&gt;</pre>

Followed by the following error:

_2013-09-12 11:45:31.020 Lync[4120:5520] ERROR APPLICATION CEwsAutoDiscoverOperation.cpp/652:All possible ews autodiscover urls exhausted.Failing autodiscover operation_

So how to solve the issue? Well the resolution is pretty simple allow basic authentication for autodiscover and EWS. This can be realized via two methods:

  * Create a new publishing rule for EWS and Autodiscover and select the option _No delegation, but client may authenticate directly_. Ensure the rule may be used for the _All users_ group instead of the _Authenticated users._ This rule must be placed above the existing publishing rules which are used for publishing Exchange
  * Create a new web listener and new publishing rule for EWS and Autodiscover. The remark which must be made to this method is that it requires new IP-address

If you want to have more information about publishing your Exchange environment either using TMG or UAG then  good starting point is the document of Greg Taylor which contains some guidelines on how to publish your Exchange environment using TMG/UAG. This document can be found on the site below:

TechNet: Publishing Exchange Server 2010 with Forefront UAG and TMG: [open](http://blogs.technet.com/b/exchange/archive/2010/07/16/publishing-exchange-server-2010-with-forefront-uag-and-tmg.aspx)