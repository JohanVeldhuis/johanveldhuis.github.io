---
id: 2060
title: Automate OWA IM Integration configuration
date: 2010-12-09T10:45:41+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2060
permalink: /owa-im-integratie-automatiseren/
categories:
  - Scripts
---
Since the release of Exchange 2010 Service Pack 1 the steps for configuring OCS/Lync IM integration for OWA has changed.

To simplify this proces I created a script which performs the following tasks:

  * check if the correct software and patches are installed;
  * configure the OWA virtual directory;
  * restart IIS;

The script will need to be executed from the CAS server and does only work for Exchange 2010 SP1. Besides the Exchange part don&#8217;t forget to configure the OCS/Lync side.

<a href="http://www.johanveldhuis.nl/tools/scripts/prepare_owa_im.ps1" target="_blank">download</a> prepare\_owa\_im.ps1 v1.0