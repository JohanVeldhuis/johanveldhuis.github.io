---
id: 1094
title: Prepare Windows 2008 for Exchange 2007
date: 2009-02-17T00:29:34+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1094
permalink: /prepare-windows-2008-for-exchange-2007/
categories:
  - Exchange
---
Just as like Windows 2003 you need to add some components to Windows 2008 before you can install Exchange 2007. In this tutorial I will explain which need to be installed on which server and made some scripts for it, that's far more easier then typing the commands one by one ;-).

When you gone prepare the AD for Exchange 2007 from a Windows 2008 server you first need to install the Active Directory Domain Services remote management tools. These tools make it possible to modify the schema and domain so that Exchange 2007 can be installed.

This can be done by executing the following script:

```Console
prepad4ex07.cmd

ServerManagerCmd -i RSAT
shutdown -r
```

After the installation of the tools the server will be  rebooted, this last thing is optional and is not always needed.

After the tools have been installed the next step is the CAS server. First we will install Powershell, this is a prerequisite for Exchange 2007. Next fase is installing several IIS components for the web applications such as: OWA and AutoDiscovery that will be hosted on the CAS.  When you are going to use Outlook Anywhere you also need to install the RPC over HTTP proxy, this will be done in the last step.

```Console
CASpreex07.cmd

ServerManagerCmd -i PowerShell
ServerManagerCmd -i Web-Server
ServerManagerCmd -i Web-ISAPI-Ext
ServerManagerCmd -i Web-Metabase
ServerManagerCmd -i Web-Lgcy-Mgmt-Console
ServerManagerCmd -i Web-Basic-Auth
ServerManagerCmd -i Web-Digest-Auth
ServerManagerCmd -i Web-Windows-Auth
ServerManagerCmd -i Web-Dyn-Compression
ServerManagerCmd -i RPC-over-HTTP-proxy
shutdown -r
```

After installing the components the server will be rebooted, this again is optional.

When the CAS server is prepared it's time for the HUB server. If you want to use a script for it, it's your own decission, this because just one component will be installed.

```Console
HUBpreex07.cmd

ServerManagerCmd -i PowerShell
shutdown -r
```

Now that the CAS and HUB server are prepared it's time for the mailbox server.

```Console
MBpreex07.cmd

ServerManagerCmd -i PowerShell
ServerManagerCmd -i Web-Server
ServerManagerCmd -i Web-ISAPI-Ext
ServerManagerCmd -i Web-Metabase
ServerManagerCmd -i Web-Lgcy-Mgmt-Console
ServerManagerCmd -i Web-Basic-Auth
ServerManagerCmd -i Web-Windows-Auth
shutdown -r
```

As you can see IIS is installed besides Powershell. Exchange 2007 doesn't use the SMTP and NNTP from IIS anymore, some other components do need IIS.

When you want to build a cluster of mailbox servers you will need to add an extra line of code to the script.

```Console
MBCpreex07.cmd

ServerManagerCmd -i PowerShell
ServerManagerCmd -i Web-Server
ServerManagerCmd -i Web-ISAPI-Ext
ServerManagerCmd -i Web-Metabase
ServerManagerCmd -i Web-Lgcy-Mgmt-Console
ServerManagerCmd -i Web-Basic-Auth
ServerManagerCmd -i Web-Windows-Auth
ServerManagerCmd -i Failover-Clustering 
shutdown -r
```

<em></em>A next step could be installing the Edge Sync server.

```Console
Edgpreex07.cmd

<em>ServerManagerCmd -i PowerShell
ServerManagerCmd -i ADLDS
shutdown -r
```

This script will install Powershell again, besides this Active Directory Lightweight Directory Services will be installed. This services have the same functionality as the Active Directory Application Mode (ADAM) as it was known in Windows 2003.

When you would like to use the auto attendant and voicemail functionality of Exchange 2007 you will need to install the UM role.

```Console
UMpreex07.cmd

ServerManagerCmd -i PowerShell
ServerManagerCmd -i Desktop-Experience
shutdown -r
```

<em></em>This script will install the codecs for audio/video from the Windows Media Player.

When you have a dedicated management station it may be necessary to install the manegement tools on it. For this only Powershell and two IIS components are needed.

```Console
Mgpreex07.cmd

ServerManagerCmd -i PowerShell
ServerManagerCmd -i Web-Metabase
ServerManagerCmd -i Web-Lgcy-Mgmt-Console
```

I think we have talked about all the prerequisites for all rolles now. Below there are some links to some resources that contain extra information about this.

<a href="http://technet.microsoft.com/en-us/library/bb691354.aspx" target="_blank">How to Install Exchange SP1 Prerequisites on Window Server 2008 or Vista</a>
<a href="http://msexchangeteam.com/archive/2008/03/10/448407.aspx" target="_blank">Speeding up installation of Exchange Server 2007 SP1 Prerequisites on Windows Server 2008</a>