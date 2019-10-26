---
id: 1192
title: Enable logging in Exchange 2010
date: 2009-04-20T19:53:06+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1192
permalink: /enable-logging-in-exchange-2010/
categories:
  - Exchange
---
In Exchange 2007 you could only enable most of the logging via Powershell. In Exchange 2010 Beta this has changed back to configuring it via the GUI just as in Exchange 2003.
  
Enabling the logging can be done via a simple press on the button and specifying the correct log and level of logging.

  * open the Exchange Management Console
  * choose one of the serverroles under _server configuration_
  * click on the button _manage diagnostic logging_ in the right menu

[<img class="alignnone size-thumbnail wp-image-1193" title="Diagnostic Logging" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_1-150x121.jpg?resize=150%2C121" alt="Diagnostic Logging" width="150" height="121" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_1.jpg)

A new window will be opened where you can select the items you which to enable logging for:

[<img class="alignnone size-thumbnail wp-image-1194" title="Item's you can diagnose" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_2-150x150.jpg?resize=150%2C150" alt="Item's you can diagnose" width="150" height="150" srcset="https://i2.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_2.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_2.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_2.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2009/04/diagnostic_2.jpg)

For some items you can specify sub-items, in the case of Activesync this are: configuration and requests.
  
When you have chosen the item you wish to log you need to specify the level of logging, this can be specified from lowest to expert. When you have selected the correct options you can press the button _configure_ and logging is configured.

When ready with troubleshooting you can reset the logging levels to factory default by simply choose the option _reset all services to default logging levels._

 

Besides logging for troubleshooting you can enable audit logging in Exchange 2010 Beta. With this option it&#8217;s possible to log the use of Powershell commands by administrators.

Configuring audit logging can only be done via Powershell and can be done by executing the following steps:

  * specify which commands you want to log: _Set-AdminAuditLogConfig -AdminAuditLogCmdlets *
  
_ In the previous example all commands will be logged. This can be changed if you like to only log specific commands, for example: _Set-AdminAuditLogConfig -AdminAuditLogCmdlets New-Mailbox, *TransportRule_
  * next step is specifying the parameters you want to log: _Set-AdminAuditLogConfig -AdminAuditLogParameters *
  
_ In the previous example all parameters will be logged, just like _-AdminAuditLogCmdlets_ you can change this so only specific parameters will be logged instead of all parameters.
  * next step will be define the mailbox where the logs need to be send to: _Set-AdminAuditLogConfig -AdminAuditLogMailbox_ [_user@domain.com_](mailto:user@domain.com)
  * final step is enabling the logging:  _Set-AdminAuditLogConfig -AdminAuditLogEnabled $True_

This is the end of the second article about Exchange 2010 Beta.