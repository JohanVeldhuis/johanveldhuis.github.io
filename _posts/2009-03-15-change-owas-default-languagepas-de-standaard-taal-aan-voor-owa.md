---
id: 1133
title: 'Change OWA&#8217;s default language'
date: 2009-03-15T21:15:50+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1133
permalink: /change-owas-default-languagepas-de-standaard-taal-aan-voor-owa/
categories:
  - Exchange
---
Many people will use the Outlook Web Access (OWA) functionality. The default language is set to _0_ this will ensure that users will be prompted the first time they login to define the default language. Users can change this later by going to the _regional settings_ in OWA.

Administrators can prevent this by defining a default language on the CAS server. This can be done by executing the following command:

_Set-OWAVirtualDirectory -Identity &#8220;Company\owa (default web site)&#8221; -DefaultClientLanguage 1043_

The command above will set the language to Dutch, this is done by the code 1043. A full overview of all codes can be found on the page at the end of this post.

Besides this setting the language of the loginpage and error messages can be changed. Default the value is _0,_ in this case the language configured in Internet Explorer will be used. When the language isn&#8217;t supported on the CAS server the default language from the CAS server will be used.

If you would like to change the default language to for example Dutch you will need to execute the following command on the CAS server:

_ Set-OwaVirtualDirectory -identity &#8220;Owa (Default Web Site)&#8221; -LogonAndErrorLanguage 1043_

<a href="http://technet.microsoft.com/en-us/library/aa997435.aspx" target="_blank">open</a>