---
id: 3333
title: Troubleshooting federated sharing – part III
date: 2013-11-29T21:29:54+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3333
permalink: /troubleshooting-federated-sharing-deel-iii/
categories:
  - Exchange
---
In the first two parts of the blog series about troubleshooting federated sharing we had a look at the infrastructure and configuration which is required. Besides this we did some basic troubleshooting on the components involved during federated sharing. In this part we will look at some examples which I gathered during troubleshooting a federated sharing issue.

Below you will see an example of an error which was received when trying to retrieve the free/busy information from a user hosted on another Exchange environment.

_Process 1212: ProxyWebRequest FederatedCrossForest from S-1-5-21-1671710892-3805255249-3875359145-102309 to https://mail.domain.com/ews/exchange.asmx/WSSecurity failed. Caller SIDs: WSSecurity. The exception returned is Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequestProcessingException: System.Net.WebException: **The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel. &#8212;> System.Security.Authentication.AuthenticationException: The remote certificate is invalid according to the validation procedure.**_

_   at System.Net.TlsStream.EndWrite(IAsyncResult asyncResult)_

_   at System.Net.PooledStream.EndWrite(IAsyncResult asyncResult)_

_   at System.Net.ConnectStream.WriteHeadersCallback(IAsyncResult ar)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()_

_   at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)_

_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest(ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling():. The request information is ProxyWebRequest type = FederatedCrossForest, url = https://mail.domain.com/ews/exchange.asmx/WSSecurity_

_Mailbox list = <Johan@domain.com>SMTP:Johan@domain.com, Parameters: windowStart = 10/1/2013 10:00:00 AM, windowEnd = 10/31/2013 10:00:00 AM, MergedFBInterval = 30, RequestedView = Detailed_

_. &#8212;> System.Net.WebException: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel. &#8212;> System.Security.Authentication.AuthenticationException: The remote certificate is invalid according to the validation procedure._

_   at System.Net.TlsStream.EndWrite(IAsyncResult asyncResult)_

_   at System.Net.PooledStream.EndWrite(IAsyncResult asyncResult)_

_   at System.Net.ConnectStream.WriteHeadersCallback(IAsyncResult ar)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()_

_   at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)_

_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest(ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling()_

_   &#8212; End of inner exception stack trace &#8212;_

_. Name of the server where exception originated:CAS01. Make sure that the Active Directory site/forest that contain the user&#8217;s mailbox has at least one local Exchange 2010 server running the Availability service. Turn up logging for the Availability service and test basic network connectivity._

When looking at the marked text you will see the actual cause, a certificate issue. So how to deal in this case? The first step you can take is try to access the Exchange Web Services of the other Exchange environment. In this case we can do it by browsing to _https://mail.domain/com/ews/exchange.asmx/WSSecurity_ what will probably happen is that you receive a certificate warning. And that is exactly why the lookup fails. The certificate from the remote Exchange environment is not valid according to the validation procedure. However when you open it in a browser you will see the reason why the certificate is not trusted. This can be caused by several things among them:

  * Certificates is signed by a root CA which is not trusted
  * Name on the certificate is incorrect

In this case the root CA was not trusted by the Exchange environment. By importing the root CA in the Enterprise Trusted Root folder of the CAS the problem was solved.

The second one was pretty hard to troubleshoot but the solution to solve it was pretty easy. Again the error is marked in the text below. The error tells you that the other side did close the connection. OK nice and now what? In this case you will need to search in the IIS logs on the CAS of the target Exchange environment to see what happens when traffic from your Exchange environment arrives at the CAS.

_Process 1212: ProxyWebRequest FederatedCrossForest from S-1-5-21-1671710892-3805255249-3875359145-102309 to https://mail.domain.com/ews/exchange.asmx/WSSecurity failed. Caller SIDs: WSSecurity. The exception returned is Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequestProcessingException: System.Net.WebException: **The underlying connection was closed: An unexpected error occurred on a receive. &#8212;> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. &#8212;> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host**_

_   at System.Net.Sockets.Socket.EndReceive(IAsyncResult asyncResult)_

_   at System.Net.Sockets.NetworkStream.EndRead(IAsyncResult asyncResult)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Net.Security._SslStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.TlsStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.PooledStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.Connection.ReadCallback(IAsyncResult asyncResult)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()_

_   at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)_

_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest(ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling():. The request information is ProxyWebRequest type = FederatedCrossForest, url = https://mail.domain.com/ews/exchange.asmx/WSSecurity_

_Mailbox list = <Johan@domain.com>SMTP:Johan@domain.com, Parameters: windowStart = 9/29/2013 12:00:00 AM, windowEnd = 11/10/2013 12:00:00 AM, MergedFBInterval = 30, RequestedView = MergedOnly_

_. &#8212;> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive. &#8212;> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. &#8212;> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host_

_   at System.Net.Sockets.Socket.EndReceive(IAsyncResult asyncResult)_

_   at System.Net.Sockets.NetworkStream.EndRead(IAsyncResult asyncResult)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Net.Security._SslStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.TlsStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.PooledStream.EndRead(IAsyncResult asyncResult)_

_   at System.Net.Connection.ReadCallback(IAsyncResult asyncResult)_

_   &#8212; End of inner exception stack trace &#8212;_

_   at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()_

_   at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)_

_   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest(ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)_

_   at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling()_

_   &#8212; End of inner exception stack trace &#8212;_

_. Name of the server where exception originated: CAS01. Make sure that the Active Directory site/forest that contain the user&#8217;s mailbox has at least one local Exchange 2010 server running the Availability service. Turn up logging for the Availability service and test basic network connectivity._

Search for traffic destined to _/ews/exchange.asmx/WSSecurity_ and you will probably find the error that did occur. Normally when everything works a _200_ will be displayed. If you do receive a _4XX_ error then verify that the federation with the Microsoft Federation Gateway works correctly as explained in the first part. Besides this verify that WSSecurity is enabled on the Autodiscover and EWS directory.

However you might get other errors, in this case it was a _500_ error. What this means and that it doesn’t know how to deal with the traffic which arrives and will close the connection. If this happens make sure _WSSecurity_ is enabled on the virtual directories for Autodiscover and EWS. When this is confirmed verify that the _svc-integrated handler_ is assigned to both the Autodiscover and EWS. If this is both configured correctly everything should be OK but why doesn’t it work?

In some occasions it may happen that _EWSSecurity_ is correctly enabled but for some reason IIS doesn’t pick this up. If this happens an _iisreset_ will fix your issue and you will be able to retrieve the free/busy information from the other Exchange organization.

Here ends the series of troubleshooting federated sharing. I am aware there might be other solution for the issues you might find during the implementation but these were just two examples of issues I found.

I hope you liked this series and if you have any questions use the contact form on the site to send me a message or ask your question by posting a comment.