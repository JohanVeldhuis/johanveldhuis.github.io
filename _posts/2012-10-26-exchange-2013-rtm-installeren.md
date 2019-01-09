---
id: 2551
title: Installing Exchange 2013 RTM using the command prompt
date: 2012-10-26T19:28:33+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2551
permalink: /exchange-2013-rtm-installeren/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2012/10/setup-finished.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2013
---
In this blog we will have a look how we can implement a multi rol Exchange 2013 server. We will install the RTM version of Exchange 2013 on a Windows 2012 server.

Before you start the installation of Exchange 2013 you will need to install some prerequisits.

Before extending the schema you will need to install the ADDS tools on the system. These can be installed very easy by insing the following Powershell cmdlet _Install-WindowsFeature RSAT-ADDS_

<p style="text-align: center;">
  <a href="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/install-windowsfeature-rsat-adds.png"><img class="aligncenter" title="install-windowsfeature rsat-adds" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/install-windowsfeature-rsat-adds-300x33.png?resize=300%2C33" alt="" width="300" height="33" data-recalc-dims="1" /></a>
</p>

Once the installation has finished it&#8217;s time to install the other prerequisites. Which features of Windows you will need to install depends on the server roles which are installed. The example below will install all prerequisites for a multi role server:

_Install-WindowsFeature AS-HTTP-Activation, Desktop-Experience, NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, Web-Mgmt-Console, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation_

<p style="text-align: center;">
  <a href="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/install-windowsfeature-other.png"><img class="aligncenter" title="install-windowsfeature other prerequisites" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/install-windowsfeature-other-300x25.png?resize=300%2C25" alt="" width="300" height="25" data-recalc-dims="1" /></a>
</p>

After the installation of the prerequisites has completed you will need to reboot the server. Once rebooted it&#8217;s time for the last three prerequisites. These need to be downloaded from the Microsoft website, below you will find the links for the three downloads:

  * [Microsoft Unified Communications Managed API 4.0, Core Runtime 64-bit](http://go.microsoft.com/fwlink/p/?linkId=260990)
  * [Microsoft Office 2010 Filter Pack 64 bit](http://go.microsoft.com/fwlink/p/?linkID=191548)
  * [Microsoft Office 2010 Filter Pack SP1 64 bit](http://go.microsoft.com/fwlink/p/?LinkId=254043)

Install them in the order as listed above. Once these files have been installed finally time to install Exchange.

You will have two options to install Exchange 2013 via the GUI of via the command prompt. Since several manuals can be found how to install it via the GUI we will use the command prompt. We will install Exchange 2013 in seperate steps. First we will prepare the schema. Make sure the account the account which is used for the installation is a member of the Schema Admins and Enterprise Admins. During this step several objects are added to the Active Directory schema which are necessary for Exchange 2013.

Open the command prompt, browse to the Exchange 2013 setup directory en execute the following command:

_setup.exe /PS /IAcceptExchangeServerLicenseTerms_

<p style="text-align: center;">
  <em><a href="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/schema-prep.png"><img class="aligncenter" title="AD Schema Prep" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/schema-prep-300x88.png?resize=300%2C88" alt="" width="300" height="88" data-recalc-dims="1" /></a></em>
</p>

The setup will tell you if the extension of the schema completed succesfully or not. Optionally you could use _ADSIEdit_ to verify if the schema is extended. Verify if the value of the object _ms-Exch-Schema-Verision-Pt_ and more specific the parameter _rangUpper _has the value 15137.

<p style="text-align: center;">
  <a href="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/adsiedit_schema.png"><img class="aligncenter" title="Adsiedit" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/adsiedit_schema-300x190.png?resize=300%2C190" alt="" width="300" height="190" data-recalc-dims="1" /></a>
</p>

Now the schema has been extended it&#8217;s time for the next step prepare the AD. This can be done by using the following cmdlet:

__setup.exe /P  /OrganizationName: &#8220;First Organizationname&#8221; /IAcceptExchangeServerLicenseTerms__

During this steps several security groups are created for Exchange 2013. Besides this several objects are created in the configuration partition of AD. After the step has completed you can use _Active Directory Users & Computers_ and _ADSIEdit_ to verify if the step has completed succesfully.

<p style="text-align: center;">
  <a href="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/aduc.png"><img class="aligncenter" title="Active Directory Users and Computers" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/aduc.png?resize=257%2C170" alt="" width="257" height="170" data-recalc-dims="1" /></a>
</p>

<p style="text-align: center;">
  <a href="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/ad_config.png"><img class="aligncenter" title="Configuration partition" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/ad_config-300x191.png?resize=300%2C191" alt="" width="300" height="191" data-recalc-dims="1" /></a>
</p>

After the AD has been prepped it&#8217;s time to install the bits.

To start the installation run setup using the following cmdlets:

_Setup.exe /mode:Install /role:ClientAccess,Mailbox /IAcceptExchangeServerLicenseTerms_

By using these parameters both the Client Access and Mailbox Server role will be installed on the server

<p style="text-align: center;">
  <a href="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/setup-finished.png"><img class="aligncenter" title="setup finished" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2012/10/setup-finished-300x212.png?resize=300%2C212" alt="" width="300" height="212" data-recalc-dims="1" /></a>
</p>

As you can see a reboot is required, after the reboot it&#8217;s time to configure Exchange.

Here ends the blog in which we talked about how to install Exchange 2013 on a Windows 2013 server. In the next blog we will have a look at how to configure Exchange 2013.