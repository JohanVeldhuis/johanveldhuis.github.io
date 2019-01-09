---
id: 837
title: Add multiple BypassedSenderDomains
date: 2008-09-19T22:36:55+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=837
permalink: /meerdere-bypassedsenderdomains-toevoegen/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2007
---
Maybe you discovered it yourself, maybe not. When you want to add values to the _bypassedsenderdomains_ parameter via the _set-contentfilterconfig_ you will lose all previous settings.

After some searching on Google I found the solution:

_$list = (Get-ContentFilterConfig).BypassedSenderDomains
  
$list.add(&#8220;test100.com&#8221;)
  
set-contentfilterconfig -BypassedSenderDomains:$list_

With the first rule we will get the value of the _BypassedSenderDomains_ and will save it as the variable _$list._

Next we will add the domain _test100.com_ to the variable. When you would execute the command_$list_ you would get a complete list of the _BypassedSenderDomains_.

When your happy with the list we can update the _BypassedSenderDomains_ with the new values.

You may sometimes want to delete a value, this can be done with the following code:

_$list = (Get-ContentFilterConfig).BypassedSenderDomains
  
$list.remove(&#8220;test100.com&#8221;)
  
set-contentfilterconfig -BypassedSenderDomains:$list_