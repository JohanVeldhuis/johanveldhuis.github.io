---
id: 1223
title: Strange issue, easy solution
date: 2009-05-11T21:57:04+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1223
permalink: /strange-issue-easy-solution/
categories:
  - Exchange
---
Today I had a nice issue. After implementing 2 new domain controllers and deconfiguring the 2 old ones there where some strange issue with the Exchange Management Console. For example setting mail quota&#8217;s was not possible this caused the following error:

_The Exchange server address list service failed to respond. This could be because of an address list or email address policy configuration error._

First checked if the Exchange server wasn&#8217;t looking at one of the old domain controllers. After fixing this the issue still wasn&#8217;t resolved.

So I started searching the internet and found an issue which looked like pretty the same as I had. This was solved by restarting the Exchange System Attendant, after I did this also the issue was solved.