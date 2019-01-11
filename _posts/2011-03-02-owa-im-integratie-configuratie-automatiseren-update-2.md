---
id: 2131
title: 'Automate OWA IM Integration configuration &#8211; update 2'
date: 2011-03-02T22:21:56+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2131
permalink: /owa-im-integratie-configuratie-automatiseren-update-2/
categories:
  - Exchange
---
It&#8217;s time for another update for the prepare\_owa\_im script, this update is pretty big compared to the earlier update. Starting with this version it&#8217;s possible to configure both OWA and Lync using the script. There is one limitation: it&#8217;s not possible to enable the new topology.

The cause of this limitation is that this is not allowed when remotely connected to the Lync Front End Server. The remote connection will allow almost everything except running the enable-CsTopology cmdlet. This cmdlet is required to enable the new topology.

So don&#8217;t forget to execute the enable-CsTopology cmdlet manually when you ran the script.

At this moment the script will need to be execute on every CAS server which needs the IM integration. In a future update this will change.

If you have any feature requests please let me know so I can add them to a future release of the script.

Caution: this script may need to change the ExecutionPolicy settings temporary

prepare\_owa\_im script versie 1.2 <a href="http://www.johanveldhuis.nl/tools/scripts/prepare_owa_im_v12.ps1" target="_self">download</a>