---
id: 3345
title: An error occurred when processing the security tokens in the message
date: 2014-01-09T22:43:21+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3345
permalink: /error-occurred-processing-security-tokens-message/
categories:
  - Exchange
---
&nbsp;

Federation always fun as you may have read in one of my previous blogs. Starting this week we had some issues at a customer where the Free/busy lookups across environments stopped working. Not only to other Exchange environments but also Office 365.

Both the Outlook logging and event logs on the CAS provided the same error. The complete error message is displayed below:

_Process Microsoft.Exchange.InfoWorker.Common.Delayed\`1[System.String]: <[johan.veldhuis@domain.com>SMTP:johan.veldhuis@domain.com](mailto:johan.veldhuis@domain.com%3ESMTP:johan.veldhuis@domain.com) failed. Exception returned is Microsoft.Exchange.InfoWorker.Common.Availability.AutoDiscoverFailedException: Autodiscover failed for e-mail address <[johan.veldhuis@domain.com>SMTP:johan.veldhuis@domain.com](mailto:johan.veldhuis@domain.com%3ESMTP:johan.veldhuis@domain.com) with exception System.Web.Services.Protocols.SoapHeaderException: **An error occurred when processing the security tokens in the message**._
  
_   at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)_
  
_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_
  
_   at Microsoft.Exchange.SoapWebClient.AutoDiscover.DefaultBinding_Autodiscover.EndGetUserSettings(IAsyncResult asyncResult)_
  
_   at Microsoft.Exchange.InfoWorker.Common.Availability.UserSoapAutoDiscoverRequest.EndGetSettings(IAsyncResult asyncResult)_
  
_   at Microsoft.Exchange.InfoWorker.Common.Availability.SoapAutoDiscoverRequest.<>c\_\_DisplayClass4.<EndInvoke>b\_\_3()_
  
_   at Microsoft.Exchange.InfoWorker.Common.Availability.SoapAutoDiscoverRequest.ExecuteAndHandleException(ExecuteAndHandleExceptionDelegate operation). &#8212;> System.Web.Services.Protocols.SoapHeaderException: An error occurred when processing the security tokens in the message._
  
_   at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)_
  
_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_
  
   at Microsoft.Exchange.SoapWebClient.AutoDiscover.DefaultBinding_Autodiscover.EndGetUserSettings(IAsyncResult asyncResult)
  
   at Microsoft.Exchange.InfoWorker.Common.Availability.UserSoapAutoDiscoverRequest.EndGetSettings(IAsyncResult asyncResult)
  
   at Microsoft.Exchange.InfoWorker.Common.Availability.SoapAutoDiscoverRequest.<>c\_\_DisplayClass4.<EndInvoke>b\_\_3()
  
   at Microsoft.Exchange.InfoWorker.Common.Availability.SoapAutoDiscoverRequest.ExecuteAndHandleException(ExecuteAndHandleExceptionDelegate operation)
  
   &#8212; End of inner exception stack trace &#8212;
  
. _Name of the server where exception originated: EXC01. This event may occur when Availability Service cannot discover an Availability Service in the remote forest._

The bold part marks the error in this case _An error occurred when processing the security tokens in the message._ This error tells you there is an issue with the security token which your server has received from the Microsoft Federation Gateway. So probably this customer is not the only customer facing this issue.

Microsoft has acknowledged there were some issues earlier this week which not only affected this functionality but also some Office 365 services.

<img alt="Office 365 status" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2014/01/O365_status-300x45.png?resize=300%2C45" width="300" height="45" data-recalc-dims="1" />

Currently a work around is available to fix this issue. To fix the issue you will need to refresh the federation trust metadata. This can be done by using the following Powershell cmdlets:

_Get-Federationtrust|Set-Federationtrust -Refreshmetadata_

It is important to know that this cmdlet will need to be run on both sides else it may not fix the issues. Once the cmdlet have been executed it may take some time before the free/busy lookups start to work again.