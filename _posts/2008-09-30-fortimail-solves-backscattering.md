---
id: 868
title: Fortimail solves backscattering
date: 2008-09-30T22:36:51+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=868
permalink: /fortimail-solves-backscattering/
categories:
  - Blog
---
Today I had an online presentation of the new software version of the Fortimail. In the new version there&#8217;s a solution for the unwanted NDR&#8217;s called _Bounce Verification._ The Fortimail will add an extra entry to the header of each mail send from internally. When a NDR is received by the Fortimail it will check for this entry. If it can&#8217;t find the entry it will execute the action that is specified in the specific policy. If the entry exists it is an legitime NDR and the Fortimail will let this message past.

A nice solution for a very irritating issue.