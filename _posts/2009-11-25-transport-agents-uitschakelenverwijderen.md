---
id: 1680
title: Remove/disable Transport Agents
date: 2009-11-25T22:36:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1680
permalink: /transport-agents-uitschakelenverwijderen/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange
---
_Microsoft Exchange couldn&#8217;t start transport agents. The Microsoft Exchange Transport service will be stopped._ This is one of the errors you may get when you&#8217;ve got a corrupted transport agent. This can cause that the transport service won&#8217;t start anymore as you can see in the example, which causes that the mail traffic will stall.

There are two solutions for this issue

&#8211; remove the transport agent
  
&#8211; disable the transport agent

The first method maybe is the best method because you have a corrupted agent on your system which you don&#8217;t want. To remove the agent execute the following Powershell command:

_Uninstall-TransportAgent &#8220;Name of the Agent&#8221;_

If you would like to do some more research you may decide to temporarily disable the agent, this can be done by using the following Powershell command:

_Disable-TransportAgent -Identity &#8220;Name of the Agent&#8221;_

When you solved the issue you can enable the agent by using this command:

_Enable-TransportAgent -Identity &#8220;Name of the Agent&#8221;_

If you would like to have more information then have a look at the site below:

Technet: Transport Agent Cmdlets <a href="http://technet.microsoft.com/en-us/library/aa998620.aspx" target="_blank">open</a>