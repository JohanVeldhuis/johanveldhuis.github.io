---
id: 2109
title: 'Automate OWA IM Integration configuration &#8211; update'
date: 2011-01-31T21:12:22+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2109
permalink: /owa-im-integratie-configuratie-automatiseren-update/
categories:
  - Exchange
---
One of the options which was missing in the first edition of the script was to check if a certificate is self-signed or not. By default a self-signed certificate is installed on an Exchange CAS Server. The problem with this kind of certificates is that other servers won&#8217;t trust it.

If this is the case there are two options:

  * import the self-signed certificate on the other servers, in this case the Lync Front End;
  * install a valid certificate;

The first option is not  really the way you want to solve it but sometimes you don&#8217;t have another option.

Below the changes which have been made in the script:

  * check if a self-signed certificate is installed;
  * option to export the self-signed certificate;

If you got any tips or suggestions please leave a comment.

<a href="http://www.johanveldhuis.nl/tools/scripts/prepare_owa_im_v11.ps1" target="_blank">download</a> prepare\_owa\_im.ps1 v1.1