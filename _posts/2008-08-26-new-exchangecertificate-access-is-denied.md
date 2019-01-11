---
id: 753
title: 'New-ExchangeCertificate : Access is denied'
date: 2008-08-26T23:00:05+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=753
permalink: /new-exchangecertificate-access-is-denied/
categories:
  - Exchange
---
As you may already now you can use the _New-ExchangeCertificate_ Powershell to add a new certificate to a few services of Exchange or create a certificate request. During a visit on the MsExchange forum I found a post of somebody who had issues with this. Despite the credentials he used to login he got the message Access is denied.

After some research on the internet I found the solution. The problem was the c:\documents and settings\all users\application data\microsoft\crypto\rsa\machinekeys directory, this is used for saving certificates, even if the creation fails. In this case the network service only had the good rights to access the folder. When you have a look at the folder you will see that the administrator has full control on the folder itself but not on the sub-folders and files in it. Changing it to this option fixed the issue and the command could be executed succesfull

Besided this fix you will find several other pages who say that giving the network service full control to the folder also fixes this issues.