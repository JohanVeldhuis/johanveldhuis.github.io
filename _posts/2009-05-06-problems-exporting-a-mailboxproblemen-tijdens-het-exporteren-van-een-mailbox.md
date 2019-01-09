---
id: 1215
title: Problems exporting a mailbox
date: 2009-05-06T19:31:00+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1215
permalink: /problems-exporting-a-mailboxproblemen-tijdens-het-exporteren-van-een-mailbox/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange
---
Exporting mail from a mailbox is in most cases no issue, but sometimes you can have issues with it:

Export-Mailbox : Error was found for johan ([<span style="color: #993333;">johan@domain.com</span>](mailto:johan@domain.com)) be
  
cause: Error occurred in the step: Moving messages. Failed to copy messages to
  
the destination mailbox store with error:
  
MAPI or an unspecified service provider.
  
ID no: 00000000-0000-00000000, error code: -1056749164
  
At line:1 char:15
  
+ export-mailbox  <<<< -identity johan -startdate &#8220;01/01/07&#8221;-enddate &#8220;06/30/
  
08&#8221; -pstfolderpath c:\temp\johan.pst -deletecontent

Strange error, isn&#8217;t it ? The user performing the job got enough rights so this shouldn&#8217;t be the issue. The solution is not really hard, just run fixmapi and then try again.

The example above is directly from a forum, first I thought it were the wrong parameters used with the command. With some help of other forum members we found the solution.

For more information about fixmapi have a look at the site below.

<a href="http://support.microsoft.com/kb/256946" target="_blank">fixmapi</a>