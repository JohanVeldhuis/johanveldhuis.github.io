---
id: 729
title: Microsoft Exchange System Manager for Windows Vista 1.0
date: 2008-08-21T00:07:08+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=729
permalink: /microsoft-exchange-system-manager-for-windows-vista-10/
categories:
  - Software
---
Microsoft has release version 1.0 of the Exchange System Manager for Windows Vista. With this tool you can manage your Exchange 2003 server from a Vista machine. There are a few restrictions in the software, belof a few of them:

  * SMTP current session node is not supported (SMTPadmin.dll cannot be registered).
  * NNTP property view is not supported (NNTPadmin.dll cannot be registered).
  * Installing Exchange System Manager on the same computer as Microsoft Office Outlook is not supported, because MAPI CDO cannot be installed.
  * You may encounter the following issues during uninstall: 
      * If Exchange System Manager is open during the uninstall process, Microsoft Management Console (MMC) is likely to crash. To resolve this, manually close the Exchange System Manager.
      * If the MAPI CDO package was uninstalled manually before uninstalling the Exchange System Manager, a runtime error may appear. This error can be ignored and the uninstall process will complete successfully.
Would you like to have this tool, then use the link below to download it.

<a href="http://download.microsoft.com/download/7/c/5/7c592066-4f5f-41fd-a31c-a4bb5688d655/ESMVISTA.EXE" target="_blank">open</a>