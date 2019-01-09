---
id: 2518
title: Offfice Web Apps 2013 integration with Exchange 2013
date: 2012-09-06T20:38:01+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2518
permalink: /integratie-van-office-web-apps-2013-met-exchange-2013/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2013
---
In this blog we will have a look at the integration of Exchange 2013 with Office Web Apps What are the advantages of this change and we will have a look if there also are some disadvantages.

Starting from Exchange 2007 you needed to install the Office Converter Pack to use the preview, also known as Web Ready view, functionality in Outlook Web Access/App. This gave users the ability to read the content from for example Word files without actually opening Word. So if you had a machine which hadn’t had Word installed you were still able to view the file. This functionality is offered by using the IFilter functionality. Besides the Office Converter Pack some 3<sup>rd</sup> parties also published their own IFilter packages, for example Adobe.  Keep in mind that IFilters are not only used for the preview functionality but by Exchange Search for content indexing.

Starting from Exchange 2013 you still have the ability to use IFilters for the preview functionality. But there is another method. You can offer some extra functionality to users by integrating Exchange 2013 with Office Web Apps. This software has to be installed on a separate server. The Office Web Apps server can be used to edit Excel, PowerPoint and Word files. If you want to open/edit RMS files then I must disappoint you. RMS files can’t be opened using the Office Web Apps server.

The Office Web Apps server can be deployed in many scenarios.

In the table below you will see the deployment types and there specific requirements

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="307">
      <strong>Deployment</strong>
    </td>
    
    <td valign="top" width="307">
      <strong>Requirements</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      Only internal
    </td>
    
    <td valign="top" width="307">
      <ul>
        <li>
          Internal FQDN
        </li>
        <li>
          Certificate*
        </li>
      </ul>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      <ul>
        <li>
          Both internal and external
        </li>
      </ul>
    </td>
    
    <td valign="top" width="307">
      <ul>
        <li>
          Internal and external FQDN
        </li>
        <li>
          Certificate
        </li>
        <li>
          External IP
        </li>
        <li>
          Reverse proxy for publishing the OWA server(s)
        </li>
      </ul>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      Single
    </td>
    
    <td valign="top" width="307">
      <ul>
        <li>
          No special requirements besides the internal/external requirements
        </li>
      </ul>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      Pool
    </td>
    
    <td valign="top" width="307">
      <ul>
        <li>
          Multiple servers
        </li>
        <li>
          Hardware Load Balancer
        </li>
      </ul>
    </td>
  </tr>
</table>

*recommended in production environments and required when Lync also uses the server

So what is the advantage of making this integration? Well the Office Web Apps Server will give users the ability to also edit files via a web browser. Since BYOD is a hot concept at the moment this will not require you to have the Office suite installed on your machine or tablet. Personally I think it is a big advantage for the last type. This because there is still no Office version available for the tablets.

Installing the Office Web Apps server is pretty easy:

  * Install the prerequisites
  * Install the Office Web App server software
  * Configure the Office Wep App server

The prerequisites can be divided in two parts:

  * Windows components
  * Other prerequisits

The Windows components can be installed by using the servermanager module for Powershell:

_Import-Module ServerManager_

_Add-WindowsFeature Web-Server,Web-WebServer,Web-Common-Http,Web-Static-Content,Web-App-Dev,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Includes,Web-Security,Web-Windows-Auth,Web-Filtering,Web-Stat-Compression,Web-Dyn-Compression,Web-Mgmt-Console,Ink-Handwriting,IH-Ink-Support_

After the components have been installed you will need to reboot your machine to finish the installation. Once the machine is rebooted download and install the following prerequisites:

  * <a href="http://www.microsoft.com/en-us/download/details.aspx?id=29909" target="_blank">.NET Framework 4.5 RC</a>
  * <a href="http://www.microsoft.com/en-us/download/details.aspx?id=29939" target="_blank">Windows PowerShell 3.0</a>
  * <a href="http://www.microsoft.com/en-us/download/details.aspx?displaylang=en&id=27929" target="_blank">KB2592525</a>

After installing the three items above you will need to reboot the server again. Once the reboot has completed it’s time to install the Office Web Apps server software. Since this is just a case of next – next finish I won’t go in to detail for this step.

Once the setup has completed it’s time to configure the Office Web Apps server. To do this we will need to use Powershell.

_New-OfficeWebAppsFarm  “https://owa.domain.com” –CertificateName “Office Web Apps”_

_In this scenario we have configured Office Web Apps to be available only via HTTPS and both the internal and external url are set to [https://owa.domain.com](https://owa.domain.com/)_

_Now we have finished the Office Web App server side let’s have a look what has to be configured for Exchange 2013._

The configuration on the Exchange 2013 side is quite simple. Just open the Exchange Management Shell (EMS) and run the following cmdlet:

_Set-OrganizationConfig -WACDiscoveryEndPoint https://owa.domain.com/hosting/discovery_

In this case we will set our Office Web Apps connection point to [_https://owa.domain.com/hosting/discovery_](https://owa.domain.com/hosting/discovery). When a user now uses the preview functionality Exchange will send a call to the Office Web Apps Server which will open the file.

To make this function work both on the local network as on the internet you will need to make sure it is accessible via both ways. The local network shouldn’t be a big problem so let’s continue with the internet side.

To offer the functionality on the internet we will need to publish our Office Web Apps Server to the internet. The recommend scenario is to put it behind a reverse proxy, for example TMG. Documentation on how to configure your TMG to publish Office Web Apps can be found [here](http://technet.microsoft.com/en-us/library/jj204665(v=ocs.15).aspx).

But what if you only want to allow this usage on private computers and not public computers? First of all keep in mind that the user is the one who is responsible for choosing the correct option when logging in via OWA.

But how to allow the use of the Office Web Apps Server only from private computers?

_Set-OwaVirtualDirectory &#8220;EX01\owa (Default Web Site)&#8221; -WacViewingOnPrivateComputersEnabled $true  -WacViewingOnPublicComputersEnabled $false_

The parameter _–WacViewingOnPrivateComputersEnabled_ will enable the use of Office Web Apps from private computers. The second parameter _WacViewingOnPublicComputersEnabled_ will disable the feature for public computers.

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="307">
      <strong>Advantages</strong>
    </td>
    
    <td valign="top" width="307">
      <strong>Disadvantages</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      Gives users the ability to edit Word, Excel and PowerPoint files
    </td>
    
    <td valign="top" width="307">
      Software needs to be installed on separate machine
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      No additional software is needed on the clients
    </td>
    
    <td valign="top" width="307">
      Must be available from the internet if you want to offer the same services as on your local network. (for Lync 2013 this is required)
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      Can also be used by SharePoint 2013 and Lync 2013 so the server is not only used by Exchange 2013.
    </td>
    
    <td valign="top" width="307">
      More than one server required in an HA environment
    </td>
  </tr>
</table>

<div id="UMS_TOOLTIP" style="z-index: 2147483647; position: absolute; display: none; background: none transparent scroll repeat 0% 0%; cursor: pointer;">
  <img id="ums_img_tooltip" class="UMSRatingIcon" alt="" />
</div>