
---
id: 713
title: Which ports need to be opened between the Edge Transport server and the Hub Transport server
date: 2008-08-17T21:57:46+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=713
permalink: /ports-open-between-edge-transport-server-and-hub-transport-server/
categories:
  - Exchange
---
As you may know you can place an Edge Transport Server in your DMZ to communicate between the internet and the Hub Transport server, but which ports need to be opened for that ? Below a short overview:

For inbound traffic:

  * SMTP &#8211; TCP port 25 (from internet)
  * SMTP &#8211; TCP port 25 (from Edge Transport server to Hub Transport server)
  * DNS &#8211; UDP port 53 ((from Edge Transport server to Hub Transport server)

For outbound traffic:

  * SMTP &#8211; TCP/UDP port 25 (from Edge Transport server to internet)
  * SMTP &#8211; TCP/UDP port 25 (from Hub Transport server to Edge Transport server)
  * LDAP for EdgeSync &#8211; TCP port 50389 (from Hub Transport server to Edge Transport server)
  * Secure LDAP for EdgeSync &#8211; TCP port 50636 (from Hub Transport server to Edge Transport server)
  * DNS &#8211; UDP port 53 (from Edge Transport server to internet)