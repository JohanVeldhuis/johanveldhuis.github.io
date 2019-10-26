---
id: 1122
title: Setup.com /M:RecoverServer
date: 2009-03-01T21:59:26+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1122
permalink: /setupcom-mrecoverserver/
categories:
  - Exchange
---
Last week I have been working on an Exchange 2007 migration. After preparing the server for installation I installed the CAS/hub role. Everything went fine till we wanted to modify the settings of the virusscanner. For some strange reason it was not possible to add some exclusions and it was not possible to remove the virusscanner.

The decission was quickly made, so we started from scratch and so we started with installing Windows 2008. After this we installed the software that is needed as a requirement for Exchange 2007.

We didn&#8217;t change much on the configuration and we could use:

```Console
setup.com /m:recoverserver
```

It&#8217;s a nice option I have to admit, de setup will search the AD for the configuration of Exchange 2007 for the specific server. This command will ensure that the roles that were installed previously will be installed again, and ready you are.

But what are the contitions you must meet and what are the things you should keep in mind when using this option:

  * the name of the server must be exactly the same
  * the server must be a member of the domain
  * the computeraccount in the Active Directory may not be removed. By removing it all configuration settings for Exchange  2007 will be deleted for this server. You need to reset the computeraccount so you can add the computer to the domain again
  * the configuration of the volume&#8217;s must be exactly the same as the old server
  * the same OS needs to be installed on the new server
  * when using a 3rd Party certificate ensure that you have a copy of the certificate
  * every customization which is made, for example changing the OWA login page, need to be documented/backuped. This is not restored by using the option _recoverserver_
  * extra added _virtual directories,_ for example creating an extra Offline Address Book, will not be restored. Also this needs to be restored via a restore of the backup.