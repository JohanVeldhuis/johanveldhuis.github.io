---
id: 2161
title: 'EMC can&#8217;t be closed after IE 9 is installed'
date: 2011-04-20T15:07:59+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2161
permalink: /emc-kan-niet-meer-worden-afgesloten-nadat-ie-9-is-geinstalleerd/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2011/04/ex_close.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
<span style="color: #ff0000;">Update 1-5-2010: this issue only occurs if opening one of the items which are located in the organizational management folder</span>

On several fora messages are posted about problems with closing the Exchange Management Console (EMC). This issue was caused after the installation of Internet Explorer 9 which resulted in the following error:

[<img title="EMC: Close all dialog boxes" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2011/04/ex_close-300x107.jpg?resize=300%2C107" alt="" width="300" height="107" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2011/04/ex_close.jpg)

The problem was reported using both the EMC for Exchange 2007 and Exchange 2010 which run on Windows 2007, Windows 2008 and Windows 2008 R2. Including the ones fully updated to Service Pack 1.

The solution is pretty simply: remove Internet Explorer 9.

Because I was curious if I would get the same error I installed a clean Windows 2008 R2 with Exchange 2010 SP1. Unfortunatly the problem couldn&#8217;t be reproduced on this machine. Even after the installation of SP1 the problem was still not reproducible

But since this is a clean install it&#8217;s not a nice comparison. If you find issues with the EMC in combination with IE 9 please let me know.