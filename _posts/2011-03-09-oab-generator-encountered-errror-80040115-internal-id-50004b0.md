---
id: 2141
title: OAB Generator encountered error 80040115 (internal ID 50004b0)
date: 2011-03-09T21:10:45+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2141
permalink: /oab-generator-encountered-errror-80040115-internal-id-50004b0/
categories:
  - Exchange
---
The OAB Generator of Exchange is responsible for generating the Offline Address Book (OAB). To generate this the service will use information which is found in the Active Directory. When you have a single forest and domain this will not give a lot of issues. But what happens when Exchange is installed in the forest root domain and the users are placed in a child domain? In this case Exchange will contact the domain controllers in the child domain to gather the information.

[<img title="OABgen error" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/03/oabgen-300x208.jpg?resize=300%2C208" alt="" width="300" height="208" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2011/03/oabgen.jpg)

Exchange will connect to the domain controller by using the netbios name. When the TCP/IP settings are configured using the default value _append primary and connection specific DNS suffixes_ Exchange will not be able to find the domain controller. Which will cause the error above and has as result that the offline address book won&#8217;t be generated.

The problem can be solved very easy: ensure that all DNS suffixes are added to the TCP/IP configuration and in the correct order: first the top domain and after that the child domains. By configuring this the domain controller in the child domain can be found and the offline address book can be generated. To force the generation you can use the following cmdlet  _update-offlineaddressbook._