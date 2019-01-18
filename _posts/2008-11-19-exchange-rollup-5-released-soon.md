---
id: 945
title: Exchange Rollup 5 released soon
date: 2008-11-19T23:56:55+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=945
permalink: /exchange-rollup-5-released-soon/
categories:
  - Exchange
---
On the site of the Microsoft Exchange Team an article is published about rollup 5 which will be available within a few days. One of the fixes in the rollup will ensure that all services will start after the installation of a patch. There are some known cases that this will not happen after the installation of a rollup. The problem is caused by a check of a certificate which is used to sign the binaries. This check wil try to contact crl.microsoft.com but when the environment has limited or no internet access this can cause this issue.

Besides this fix the rollup will contain fixes for the issues below:

  * <span style="font-size: x-small;">Need an option to apply ELC policy to only the root instead of applying it recursively to root and all subfolders</span>
  * <span style="font-size: x-small;">Add generatePublisherEvidence enabled=&#8221;false&#8221; to Exchange Services Config Files</span>
  * <span style="font-size: x-small;">SCR does not copy logs in a disjoint namespace scenario</span>
  * <span style="font-size: x-small;">SCR cannot be enabled when DNS suffixes differ on source/target in disjoint namespace scenarios</span>
  * <span style="font-size: x-small;">Exchange 2007 CAS cannot copy the OAB from the OAB share on Windows Server 2008-based Exchange 2007 CCR clusters  </span>
  * <span style="font-size: x-small;">Messages get stuck in outbox on Windows Mobile 6.1 devices When using  CAS proxy</span>
  * <span style="font-size: x-small;">MSI patching doesn&#8217;t update logon.aspx if the file is modified by customer</span>