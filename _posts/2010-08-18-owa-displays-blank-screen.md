---
id: 1988
title: OWA displays blank screen
date: 2010-08-18T21:24:31+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1988
permalink: /owa-displays-blank-screen/
categories:
  - Exchange
---
During a troubleshooting sessions at one of our customers I had an issue which can be found on several forums now a days, OWA will only display a blank screen instead of the logon page. But what is the cause of this issue? Well there are several reasons which can cause it:

  * not all required Windows Components are installed
  * changes have been made in the configuration using IIS

**Required Windows Components are missing**

The first reason is quite strange as you would expect that the installation of Exchange will check if all required components are in place before starting the installation.

When you forget, for example, the _static content_ item of IIS this may cause the blank screen of OWA. To make it a bit easier you can use the script below to install all required Windows Components on a Windows 2008 server which will become a CAS server:

_ServerManagerCmd -i Powershell
  
ServerManagerCmd -i Web-Server
  
ServerManagerCmd -i Web-ISAPI-Ext
  
ServerManagerCmd -i Web-Metabase
  
ServerManagerCmd -i Web-Lgcy-Mgmt-Console
  
ServerManagerCmd -i Web-Basic-Auth
  
ServerManagerCmd -i Web-Digest-Auth
  
ServerManagerCmd -i Web-Windows-Auth
  
ServerManagerCmd -i Web-Dyn-Compression_

If your planning to use Outlook Anywhere don&#8217;t forget to install the RPC over HTTP feature:

_ServerManagerCmd -i RPC-over-HTTP-proxy_

If all the above components are installed you can start installing Exchange 2007.

**OWA virtual directory configuration is corrupted**

Making configuration changes using IIS may cause you OWA configuration to be corrupted. So don&#8217;t use OWA to make changes but use the Exchange Managment Shell or Exchange Management Console to make configuration changes.

But if you made changes using IIS and OWA does not work anymore how can it be solved? Well there is only one solution, remove the OWA virtual directory and recreate it. This can be done by using the _remove-owavirtualdirectory_ and _new-owavirtualdirectory_ cmdlets_._

First step is to remove the old OWA directory:

_remove-owavirtualdirectory “owa (Default Web Site)”_

This will remove the virtual directory as you can see in the screenshot below:

[<img class="alignnone size-thumbnail wp-image-1992" title="IIS - Exchange Vdir's" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/owa-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2010/08/owa.jpg)

Once the directory is removed we can create a new one by using the cmdlet below:

_new-owavirtualdirectory -OwaVersion “Exchange2007″ -Name “owa (Default Web Site)”_

This will recreate the OWA virtual directory and if your lucky OWA will work again. This were just 2 options which might cause this issue. If you got the same issue but the above steps didn&#8217;t work contact me so I can add them to this article johan (a) johanveldhuis.nl