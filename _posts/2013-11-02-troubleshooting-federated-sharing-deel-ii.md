---
id: 3300
title: 'Troubleshooting federated sharing &#8211; part II'
date: 2013-11-02T20:55:06+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3300
permalink: /troubleshooting-federated-sharing-deel-ii/
categories:
  - Exchange
---
In the first part of the blog series about troubleshooting federated sharing we had a look at the server side. We discussed which parameters you should verify during troubleshooting and if they are configured incorrectly how to fix them.

Now we will continue our journey in this second part. In this part we will have a look at the reverse proxy side followed by the client side.

Let’s start with having a look at the reverse proxy.

Because you don’t want your Exchange environment is directly accessible via the internet most companies will us a reverse proxy to “publish” their Exchange environment. This can either be done via a Microsoft product such as TMG or ARR. The first one will be end-of-support shortly so if not having one in place don’t start implementing it but use ARR or a 3rd party solution. When looking at the third party solutions there are a lot of solutions you can use. For example BlueCoat, Kemp Technologies or F5 have products which offer this functionality.

So what can be the problem with the reverse proxy which is used for publishing the Exchange environment? Well there can be many problems among them:

  * Authentication issues
  * Name resolving issues
  * Routing issues

This are just three of the sort of issues you can experience when using a reverse proxy. I am sure there are a lot more sorts. In this blog we will focus on the authentication issues. The reason for this is that these are the issues you will probably encounter during your journey in configuring federated sharing.

The authentication issue is one of those things you will see a lot. Especially when you are using pre-authentication. Using pre-authentication your session will be authenticated before it is send to the CAS/CAS Array which is located behind the firewall.

For federated sharing it is required that all the federated sharing sessions will be passed-through to the CAS without having to authenticate. Authentication in this case will take place on the CAS/CAS Array. So one thing to make sure is that you will create the rules required for federated sharing above the existing rules. As mentioned in the first part the URL’s which are required are as follows:

  * /EWS/Exchange.asmx/WSSecurity
  * /Autodiscover/Autodiscover.svc
  * /Autodiscover/Autodiscover.svc/WSSecurity

If you are using the TMG to publish these URL’s ensure the following options are select:

  * Authentication Delegation: No delegation, but client may authenticate directly
  * Users: all users

Most companies will use Form Based Authentication (FBA) to publish their Exchange Services to the internet. If this is the case you will need to change the listener. This because by default the listener will required all users to authenticate before they can connect which makes sense.

However for the URL’s used for federated sharing the authentication takes on the CAS so we also want to disable this specific option.

To do this get the properties of the listener and select the authentication tab. Open the advanced authentication options by pressing the advanced button and uncheck the option Require all users to authenticate.

Once configured you will need to find out if the rule really works the way you want. For example if configured in the wrong order the traffic will not even hit configured rule. To monitor this piece some logging will need to be enabled on the TMG side. I personally recommend you to create a filter using the following parameters:

  * Filter by: rule
  * Condition: equals
  * Value: name of the publishing rule used to publish these services

Now logging is configured try to do a free/busy from another Exchange environment or from Office 365. If the rule is on the correct place you should see that the traffic hits the rule.

If you do not see any logging the traffic will not hit the rule. In that case verify the already discussed parameters and try again. In some cases it might take a few minutes before the TMG has picked up the new config so if it does not work directly wait a few minutes and try again.

Another issue you might see are authentication issues in the TMG log. This will be either 401.x or 403.x errors in most cases. In this case verify that when you browse to the following pages no form will be displayed:

  * <https://mail.domain.com/EWS/Exchange.asmx/WSSecurity>
  * <https://autodiscover.domain.com/Autodiscover/Autodiscover.svc>
  * <https://autodiscover.domain.com/Autodiscover/Autodiscover.svc/WSSecurity>

If a form is displayed please verify the delegation settings on the rule and the authentication settings on the listener.

OK enough about TMG let’s continue with the client side. By default Outlook has disabled logging for troubleshooting purposes so before starting the troubleshooting you will need to enable it. Microsoft has published a knowledge base article on how to enable the troubleshooting logging which can be found [here](http://support.microsoft.com/kb/831053).

When you have reproduced the issue it is time to look at the logs. Depending on the version of Outlook you the log are named different and are located in different locations. Below an overview of Outlook version, the log location and log file name:

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
      Version
    </td>
    
    <td valign="top">
      Location
    </td>
    
    <td valign="top">
      Filename
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      Outlook 2007
    </td>
    
    <td valign="top">
      %temp%\OLKas
    </td>
    
    <td valign="top" width="201">
      date-time -fb.log
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="201">
      Outlook 2010
    </td>
    
    <td valign="top" width="201">
      %temp%\OLKas
    </td>
    
    <td valign="top" width="201">
      date-time -AS.log
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="201">
      Outlook 2013
    </td>
    
    <td valign="top" width="201">
      %temp%\Outlook logging
    </td>
    
    <td valign="top" width="201">
      Outlook-########.etl
    </td>
  </tr>
</table>

So if you are on Outlook 2007/2010 your good investigate the logs yourself. If you are using Outlook 2013 you will have to send the etl file to Microsoft support for research.

Below you will find an example of a log file create with Outlook 2010. Let’s analyse it:

First Outlook will determine the URL for the availability service. Outlook will use autodiscover to do determine the availability URL.

_2013/09/25 11:38:40.041: Getting ASURL_

As you can see Outlook already will use the URL from a previous autodiscover request:

_2013/09/25 11:38:40.041: URL returned from cached autodiscover: <https://mail.domain.com/ews/exchange.asmx>_

The URL in cache is the one that is used for requesting the availability service:

_2013/09/25 11:38:40.041: Request to URL: <https://mail.domain.com/ews/exchange.asmx>_

Next step is to send the actual request which is send as an XML to the target CAS. As you can see this XML request will be used to request the free/busy information from a specific user:

_2013/09/25 11:38:40.041: Request action: <http://schemas.microsoft.com/exchange/services/2006/messages/GetUserAvailability>_

Once the type of request has been determined the parameters will be provided in the body. You will see the following parameters to be used in every free/busy request:

  * _ex12t:Timezone:_ the timezone which is being used: in this case 60
  * _ex12t:StandardTime:_ the default value of the time for the request being send, I guess if no specific time is specified it will use this one
  * _ex12t:Time:_ the standard time for which we want to know the availability: in this case 03:00:00
  * _ex12t:DayOrder:_ the standard day (date) you want to know the availability for: in this case 5
  * _ex12t:Month:_ the standard month: in this case 3
  * _ex12t:DayOfWeek:_ the day for which you want to know the availability: in this case Sunday
  * _ex12t:DaylightTime:_ I haven’t figured out this one but it looks like it has something to do with the winter/summer time
  * _ex12t:Address:_ the smtp address of the user for which you want to know the availability: in this case <johan.@myuclab.nl>
  * _ex12Routingtype:_ the transport method which is used for sending the actual request once you hit the send button and your CAS will deliver it to the mailbox of the user determined in the ex12t:Address: in this case smtp
  * _ex12t:AttendeeType:_ the type of attendee this can be either required or optional: in this case required
  * _ex12t:FreeBusyViewOptions:_ contains the meeting specific details
  * _ex12t:Starttime: _the start time of the meeting: in this case 2013-09-09T18:00:00
  * _ex12t:Endtime:_ the end time of the meeting: in this case 2013-10-09T18:00:00
  * _ex12t:MergedFreeBusyIntervalInMinutes:_ the intervals for which you would like to display the availability by default per 30 minutes
  * _ex12t:RequestedView:_ which info we want to see for the user: in this case detailed

[<img class="alignnone size-medium wp-image-3313" alt="request" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/11/request-300x139.jpg?resize=300%2C139" width="300" height="139" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/request.jpg?resize=300%2C139&ssl=1 300w, https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/request.jpg?w=785&ssl=1 785w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/request.jpg)

Now the XML has been generated the actual request can be send:

_2013/09/25 11:38:40.041: Sending request_

Next we will receive the response which will tell us the request has been successfully send or that it failed. In this case the HTTP status code will tell us the request has been send successfully:

_2013/09/25 11:38:44.135: Request sent_
  
_2013/09/25 11:38:44.135: Response error code: 00000000_
  
_2013/09/25 11:38:44.135: HTTP status code: 200_

Once the request has been send we will receive an answer from the source CAS which tries to route the request to the remote CAS. It starts with some generic XML which contains the server version information. This is the version number our own CAS. In this case we can see it runs Exchange 2010 SP3.

Next information contains the actual response the source CAS received from the remote CAS. This part will start with FreeBusyResponseArray this part contains the ResponseMessage as you can see there is a security related issue. This issue will prevent Outlook from receiving the free/busy for the other user.

After the message we will see some more detailed information which will show you which request the source CAS tries to send to the remote CAS.

[<img class="alignnone size-medium wp-image-3314" alt="response" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/response-300x290.jpg?resize=300%2C290" width="300" height="290" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/response.jpg?resize=300%2C290&ssl=1 300w, https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/response.jpg?w=793&ssl=1 793w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/11/response.jpg)

In the final part you will see the actual error message and from which CAS it did receive this error. In this case error 5016 id received from CAS02. Outlook will display the 5016 error when hovering over the free/busy info from the specific user.

Here ends the second part of the blog series about troubleshooting federated sharing. In this part we had a look at the requirements for the reverse proxy and some basic troubleshooting and continued with troubleshooting from the client side.

In the third and last part of the article we will discuss some issues I have seen happening when setting up federated sharing.

If you have any comments/questions please let me know.