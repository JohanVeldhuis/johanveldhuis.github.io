---
id: 1680
title: Remove/disable Transport Agents
date: 2009-11-25T22:36:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1680
permalink: /remove-disable-transport-agents/
categories:
  - Exchange
---
_Microsoft Exchange couldn&#8217;t start transport agents. The Microsoft Exchange Transport service will be stopped._ This is one of the errors you may get when you&#8217;ve got a corrupted transport agent. This can cause that the transport service won&#8217;t start anymore as you can see in the example, which causes that the mail traffic will stall.

There are two solutions for this issue

&#8211; remove the transport agent
  
&#8211; disable the transport agent

The first method maybe is the best method because you have a corrupted agent on your system which you don&#8217;t want. To remove the agent execute the following Powershell command:

```PowerShell
Uninstall-TransportAgent 'Name of the Agent'
```

If you would like to do some more research you may decide to temporarily disable the agent, this can be done by using the following Powershell command:

```PowerShell
Disable-TransportAgent -Identity 'Name of the Agent'
```

When you solved the issue you can enable the agent by using this command:

```PowerShell
Enable-TransportAgent -Identity 'Name of the Agent'
```

If you would like to have more information then have a look at the site below:

Technet: Transport Agent Cmdlets <a href="http://technet.microsoft.com/en-us/library/aa998620.aspx" target="_blank">open</a>