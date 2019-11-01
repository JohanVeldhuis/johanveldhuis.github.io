---
title: Skype for Business Location Information Services (LIS) - part 1
date: 2019-11-01T20:49:00+00:00
author: Johan Veldhuis
layout: post
permalink: /sfb-lis-part-1/
categories:
  - Blog
---
This is a multi-part article. In the first part we will have a look what Location Information Services \(LIS\) is and how to configure. In the second part we will look at how it works and how you can troubleshoot Location Information Services.

Location Information Services is a functionality build-in Skype for Business Server. The initial version of LIS was introduced in Lync Server 2010 and changes were made in the newer versions of the product.

In most cases you will see that LIS is implemented due to the requirement to have E9-1-1 functionality.

>Enhanced 9-1-1 (E9-1-1) is an emergency notification feature that associates the calling party's telephone number with a civic or a street address. Using this information, the Public Safety Answering Point (PSAP) can immediately dispatch emergency services to the caller in distress.

_source: [Deploy emergency services](https://docs.microsoft.com/en-us/skypeforbusiness/deploy/deploy-enterprise-voice/deploy-emergency-services?toc=/SkypeForBusiness/toc.json&bc=/SkypeForBusiness/breadcrumb/toc.json)_ 

Deploying LIS requires you to perform the following steps:

1. Configure the telephony part
2. Create location policies
3. Configure the LIS database
4. (Optional) configure advanced features

The configuration can be partially done via the Skype for Business Control Panel but most work needs to be done via PowerShell.

As mentioned in the numbered list the first thing you have to do is setup the telephony part
```powershell
#Configure PSTN usage
Set-CsPstnUsage -Usage @{add='EmergencyUsage'}

#Create a new voice route for E-9-1-1 and add the earlier previously created PSTN usage
New-CsVoiceRoute -Name "EmergencyRoute" -NumberPattern "^\+911$" -PstnUsages @{add="EmergencyUsage"} -PstnGatewayList @{add="e911-trunk"}
```
Once those steps have been performed you need to decide if you want to configure the E9-1-1 settings for all users in the organization or only for a subset of the users. If you need to configure it for all users you can modify the **Global** location policy else you will need to create a policy which can be assigned on a per user level.

```powershell
#Modify global location policy
Set-CsLocationPolicy -Identity Global -EnhancedEmergencyServicesEnabled $true -LocationRequired "disclaimer" -EnhancedEmergencyServiceDisclaimer "Your company policy requires you to set a location. If you do not set a location emergency services will not be able to locate you in an emergency. Please set a location." -PstnUsage "emergencyUsage" -EmergencyDialString "911" -ConferenceMode "twoway" -ConferenceUri "sip:+31201234567@myuclab.nl" -EmergencyDialMask "112" NotificationUri "sip:security@myuclab.nl" -UseLocationForE911Only $true -LocationRefreshInterval 2

#Per user policy
New-CsLocationPolicy -Identity Tag:Amsterdam - EnhancedEmergencyServicesEnabled $true -LocationRequired "disclaimer" -EnhancedEmergencyServiceDisclaimer "Your company policy requires you to set a location. If you do not set a location emergency services will not be able to locate you in an emergency. Please set a location." -UseLocationForE911Only $false -PstnUsage "EmergencyUsage" -EmergencyDialString "911" -EmergencyDialMask "112" -NotificationUri "sip:security@myuclab.nl" -ConferenceUri "sip:+31201234567@myuclab.nl" -ConferenceMode "twoway" -LocationRefreshInterval 2

#Assign the policy to a user
(Get-CsUser | where { $_.Name -match "Johan" }) | Grant-CsLocationPolicy -PolicyName Amsterdam
```

Once the location policy has been configured and assigned (in case you did not use the global one). It is time to populate the LIS database.

The LIS database is part of the backend databases of Skype for Business and is named **LIS**. The database contains the following tables which contain the location, physical location and network related data:

| Tablename               | Data  |
| ----------------------- | ------|
| dbo.CivicAddress         | Contains the civic address details and mapping to the location id|
| dbo.Location            | Contains the location info |
| dbo.Port                | Contains the switchport info and mapping to the location |
| dbo.Subnet              | Contains the subnet info and mapping to the location|
| dbo.Switch              | Contains the switch info and mapping to the location|
| dbo.WirelessAccessPoint | Contains the access point info and mapping to the location|

Data can be added to the database by using the following PowerShell cmdlets:

```powershell
#Add a subnet
Set-CsLisSubnet

#Add a wireless access point
Set-CsLisWirelessAccessPoint

#Add a switch
Set-CsLisSwitch

#Add a switch port
Set-CsLisPort

#Example of adding a subnet to a civic location
Set-CsLisSubnet -Subnet 157.56.66.0 -Description "Subnet 1" -Location Location1 -CompanyName "MyUCLab" -HouseNumber 1234 -HouseNumberSuffix "" -PreDirectional "" -StreetName 163rd -StreetSuffix Ave -PostDirectional NE -City Redmond -State WA -PostalCode 99123 -Country US

```

Once all network related data has been added it is time to configure the external LIS provider. This requires both a password and a valid certificate:

```powershell
$pwd = Read-Host -AsSecureString <password>
Set-CsLisServiceProvider -ServiceProviderName <Identity of provider> -ValidationServiceUrl <URL provided by provider> -CertFileName <location of certificate provided by provider> -Password $pwd
```

Now the LIS provider has been configured we can validate the civic addresses which are configured as part of the network configuration.

```powershell
#Validate all civic addresses configured
Get-CsLisCivicAddress | Test-CsLisCivicAddress -UpdateValidationStatus
```

Now everything has been configured the last step is to publish the configuration to the LIS database.

```powershell
Publish-CsLisConfiguration
```

Now the LIS data has been published it is time for some testing. But for that you will have to wait for part 2 of this article.