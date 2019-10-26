---
id: 3202
title: Review ScanMail Suite for Microsoft Exchange
date: 2013-06-13T21:47:35+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3202
permalink: /review-scanmail-suite-for-microsoft-exchange/
categories:
  - Exchange
---
Exchange 2013 is available for a few months now and people may start to consider to implement it either in greenfield or in their current Exchange environment. The last one is an option which became an option with the release of Exchange 2013 CU1.

A lot has changed in Exchange 2013 the server which contains the Mailbox role does all the work and the CAS does only proxying and redirection. Redirection is only used for SIP request to the UM server.

From antivirus perspective also a lot has changed. This since Microsoft has announced that it will discontinue Forefront Protection for Exchange. So what options do we have for AV then in Exchange 2013? There are two options

  * Use the build-in AV solution from Exchange 2013
  * Use a 3rd party solution which supports Exchange 2013

The first one might be an option for organizations who can live with the limited functionality. However I think most organizations will start to use 3rd party solutions.

Starting from Exchange 2013 can&#8217;t hook in on the VSAPI which was available in previous releases and was used to perform scanning.

Currently all vendors are working hard or have already released their new versions of the product which is compatible with Exchange 2013.

Among those vendors is Trend Micro, they have just release the RTM version of ScanMail™ Suite for Microsoft® Exchange™  , also known as SMEX. You may think that it took long before they released the new version for Exchange 2013 but keep in mind Exchange 2013 is totally different then Exchange 2010 as discussed earlier.

[<img alt="SMEX console" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/06/SMEX-console-300x149.png?resize=300%2C149" width="300" height="149" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/06/SMEX-console.png)

With SMEX 11 Trend Micro does continue to build on previous releases of the product only then available for Exchange 2013. Starting from SMEX 11 you can&#8217;t install the product anymore on Exchange 2003. This is a logical result of the support for Exchange 2003 will end in April 2014.

Just like the previous releases SMEX will give organizations the possibility to perform both transport and mailbox scanning. It does contain several scan filters which can be used to perform scanning

As this blog would be to long too describe all of the filters in detail I have out them in the table below. In this table the scan filters are listed including a short description:

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="312">
      <b>Scan Filter</b>
    </td>
    
    <td valign="top" width="312">
      <b>description</b>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Attachment Blocking
    </td>
    
    <td valign="top" width="312">
      Allows you to scan for attachment types and block them
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Content Filtering
    </td>
    
    <td valign="top" width="312">
      Allows you to verify messages for specific content and block them
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Data Loss Prevention
    </td>
    
    <td valign="top" width="312">
      Solution to scan messages for certain content to prevent the leakage of data
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Spam Prevention Rules
    </td>
    
    <td valign="top" width="312">
      Filter which allows you to perform basic antispam filtering
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Web Reputation
    </td>
    
    <td valign="top" width="312">
      Filter which allows you to scan content for malicious url’s
    </td>
  </tr>
</table>

All these methods are built on the years of experience Trend Micro has in the world of antivirus for Exchange.

**Web Reputation Services**

Now we know which filters are available let&#8217;s have a look at some new/enhanced features of SMEX 11. From the documentation there are 3 featured where they performed a lot of work to include these in the product.

At first the web reputation service (WRS), as already described in the table this feature will check url&#8217;s to websites in messages. For each url it sends a query to check the reputation of a url. If the url has a value which passes the threshold SMEX will perform the configured action.

Queries can be either send directly to the Smart Protection Network (a Cloud based solution) or a Smart Protection Server which is located on the local network. You can limit the Smart Protection Server to prevent queries to the Smart Protection Network but this will restrict the web reputation security level to low. The reason for this is that the Smart Protection Servers cannot maintain the complete repository of the Smart Protection Network.

New functionality introduced in WRS is the integration of the Trend Micro Command & Control (C&C) Contact Alert Services. Using this services you can benefit from the Global Intelligence list. This list is compiled by Trend Micro Smart Protection Network from sources all over the world and test and evaluates the risk level of each C&C callback address. The Web Reputation security level determines the action that needs to be taken on malicious websites or C&C servers bases on the assigned risk levels. Besides the C&C service integration it is also available on other Trend layered defense such as network, endpoint and server security. It will give you a holistic review of entire organization cyber security and targeted attack visibility.

**Search and Destroy**

The next feature is the search and destroy feature, I think most people will know what it does. Indeed search for items and destroy them. However this is the short story.

The search and destroy functionality is only available when SMEX is installed on an Exchange 2010 SP1 or Exchange 2013 server. When looking under the hood you will find out that SMEX does use the e-discovery functionality from Exchange for this.

So before you can use the functionality you will need to ensure that the service account you are going to use for search and destroy has the required permissions. For those who are unfamiliar with Exchange, since Exchange 2010 Microsoft has implemented Role-Based Access Control (RBAC) to specify what users can do. Exchange contains a default RBAC role called Discovery Management which is attached to the security group Exchange Discovery Management. So in this case add the service account to the group and you should be able to perform search and destroy tasks.

The search and destroy functionality uses two types of accounts which must be configured in addition to the Exchange part:

  * Search & Destroy Administrators, which can search for, monitor and delete undesirable content;
  * Search & Destroy operators, which can search for and monitor undesirable content;

At least one search & destroy administrator needs to be assigned, this since “normal” administrators won’t be able to perform the search & destroy tasks unless assigned this role.

[<img alt="Search & Destroy" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/06/sd-300x157.png?resize=300%2C157" width="300" height="157" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/06/sd.png)

The Search & Destroy feature has the ability to create PST files before removing the content. The content in that case will be exported to PST and stored in a folder on the local server. So if performing large search & destroy operations make sure you have enough space left on the volume where you install SMEX. This option does require the Exchange Mailbox Import Export role to be assigned to the user account.

So what happens when performing a search & destroy search:

  1. User specifies the search criteria;
  2. SMEX creates a new mailbox search in Exchange;
  3. Exchange performs the mailbox search, places the result in the discovery mailbox of Exchange and returns the results to SMEX;
  4. User can view the results and either chose to directly delete the content from the mailbox or first export it to PST;

I had a look at this specific feature of SMEX for a while during a co-existence scenario where both Exchange 2010 and Exchange 2013 were implemented. If you do plan to do this make sure to discovery mailboxes exist one for each environment at least else you won’t be able to perform searches. Despite this an additional throttling policy has to be assigned to the service account. This because Exchange will limit the amount of concurrent mailbox searches to a maximum of 2 by default.

Every step which need to be configure for search & destroy is very clear documented in the PDF which is available for download from the Trend Micro website.

**Deep Discovery Advisor**

New in SMEX 11 is the integration with Trend’s Deep Discovery Advisor. A new product which is currently only available as hardware appliance. Using Deep Discovery Advisor you will get a sort of virtual virus doctor in your network which offers:

  * Centralized location for aggregate, manage and analyze logs;
  * Advanced visualization and investigation tool which monitors, explores and diagnoses security events on your network;
  * Custom signature and custom defense against targeted attack.

To configuration in SMEX consists of a few steps:

  1. Enable the Advanced Threat Scan Engine;
  2. Configure the pickup directory on the Exchange Server;
  3. Specify the IP address of the appliance in SMEX;

Once configured SMEX will forward content that meets the criteria configured in the AV scanning method to the Deep Discovery Advisor. The Deep Discovery Advisor will analyze the content and will report back the results back to SMEX.

While they might have waited a bit longer than expected Trend Micro did a lot of good work which resulted in a new version of SMEX with a lot of new features.  Especially the search & destroy and enhancements in WRS are a great addition to the product. So if you decide to migrate to Exchange 2013 or have a current Exchange 2007 or Exchange 2010 environment and you are looking for an antivirus product for Exchange make sure you have a look at Scanmail.

A trail version of SMEX can be downloaded via the link below:

[download](http://downloadcenter.trendmicro.com/index.php?regs=NABU&clk=latest&clkval=4363&lang_loc=1)