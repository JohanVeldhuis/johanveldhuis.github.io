---
id: 2544
title: Federation issue after Live.edu is migrated to Office 365
date: 2012-10-25T18:52:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2544
permalink: /federation-issue-na-migratie-van-live-edu-naar-office-365/
categories:
  - Office 365
---
During the implementation of a rich-coexistence environment between an Exchange 2010 On-Premise environment and Office 365 I had an issue with the Free/Busy which didn&#8217;t work correctly. Using the On-Premise environment I could retrieve the Free/Busy information from an Office 365 user but it didn&#8217;t worked from Office 365 to On-Premise. The error I got was that it couldn&#8217;t connect to the On-Premise environment

Because the Cloud couldn&#8217;t connect I decided to have a look at the TMG. In the logging no requests could be seen in the logging. So the requests where blocked somewhere else. To troubleshoot this issue I decided to connect to Office 365 via Powershell.

To check if the organization relationshop works correctly you can use _Test-OrganizationRelationship_, for example:

Test-OrganizationRelationship -identity &#8220;To_OnPremise&#8221; -UserIdentity <johan@domain.com>

When I ran this cmdlet it gave the following error:

[<img title="Test-OrganizationRelationship" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture3.jpg?resize=627%2C92" alt="" width="627" height="92" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture3.jpg)

 So there was an issue with the delegation token. The delegation token is provided by the Microsoft Federation Gateway. There are two gateways:

  * Consumer, used by Windows Live and Live.edu
  * Commerciële, used by Office 365 and Exchange On-Premise environments

To check which federation gateway is used by the solution you can use the _Get-FederatedOrganizationIdentifier_ cmdlet. This cmdlet returned the following output:

[<img title="Get-FederatedOrganizationIdentifier" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture-300x90.jpg?resize=300%2C90" alt="" width="300" height="90" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture.jpg)

As you can see the _DelegationTrustLink _has the value _WindowsLiveID_ this means that the consumer version of the federation gateway is used. Because this gateway can&#8217;t be used by Office 365 you won&#8217;t get a token from the federation gateway.

A correct federation from Office 365 side will look like this:

[<img title="Get-FederatedOrganizationIdentifier" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture2-300x93.jpg?resize=300%2C93" alt="" width="300" height="93" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/Capture2.jpg)

As you can see the DelegationTrustLink has the value MicrosoftOnline, the commercial version of the Microsoft Federation Gateway.

To fix the issue you will need to contact Office 365 support. Support can recreate the federation trust which ensures that a token can be retrieved from the Federation Gateway