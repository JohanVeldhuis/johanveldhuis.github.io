---
id: 2228
title: 'Uninstall of Scanmail 8 doesn&#8217;t remove everything'
date: 2011-05-30T19:46:36+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2228
permalink: /uninstall-of-scanmail-8-doesnt-remove-everything/
categories:
  - Exchange
---
During the removal of an Exchange 2003 cluster I found an issue after the removal of Trend Micro Scanmail (SMEX) 8.0. After the deinstallation was completed the Cluster Administrator started with an error. Once of the things I expected to cause the issue was the resource object from SMEX which was still there. This could be solved easily by removing the default procedure for removing cluster resources.

Despite removing the resource the Cluster Administrator kept prompting with and error. After some research I discovered that the issue was caused by a resource type clusRDLL which was still their.

To cleanup this resource type you will need to use the _cluster_ command:

```Console
cluster restype clusRDLL /delete /type
```

After this command was executed the error did dissapear and I could remove the Exchange 2003 Virtual Server.

Trend Micro has published a knowledge article about this issue:

Uninstalling Scanmail for Exchange (SMEX) 8.0 from cluster servers <a href="http://esupport.trendmicro.com/Pages/Uninstalling-ScanMail-for-Exchange-SMEX-80-from-cluster-servers.aspx?print=true" target="_blank">open</a>