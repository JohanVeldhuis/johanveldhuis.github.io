---
id: 2488
title: 'Lync integration doesn&#8217;t work with OWA'
date: 2012-07-27T18:52:53+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2488
permalink: /lync-integration-with-owa-doesnt-work/
categories:
  - Exchange
---
During an implementation of Lync 2010 I had an issue with the integration of Lync in OWA. This worked on all CAS servers except one. This despite all the needed software prerequisits had been installed:

  * <a href="http://www.microsoft.com/downloads/details.aspx?familyid=CA107AB1-63C8-4C6A-816D-17961393D2B8&#038;displaylang=en" target="_blank">OCS 2007 R2 Web Service Provider</a>
  * <a href="http://www.microsoft.com/download/en/details.aspx?id=7557" target="_blank">Unified Communications Managed API 2.0 Redist (64 Bit) Hotfix KB 2282949</a>
  * <a href="http://www.microsoft.com/download/en/details.aspx?id=797" target="_blank">OCS 2007 R2 Web Service Provider Hotfix KB 981256</a>

And the configuration on both the CAS and Front End Server was completed.

After removing the software and reinstalling it again the issue wasn&#8217;t solved either. In the application log the following warning was displayed:

_An exception was thrown while attempting to load the IM provider .dll file._
  
_File: C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\OWA\bin\Microsoft.Rtc.UCWeb.dll_
  
_Unable to load one or more of the requested types. Retrieve the LoaderExceptions property for more information._

For some reason the dll couldn&#8217;t be loaded correctly. The solution was pretty wasu just reset IIS using  _IISReset /noforce__._

After running the command the IM integration worked without any issues.