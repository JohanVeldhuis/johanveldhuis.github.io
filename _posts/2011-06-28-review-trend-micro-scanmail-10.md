---
id: 2253
title: Review Trend Micro Scanmail 10
date: 2011-06-28T20:44:37+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2253
permalink: /review-trend-micro-scanmail-10/
categories:
  - Reviews
---
In this article we will have a look at Trend Micro Scanmail (SMEX) 10. This is the latest version of Trend Micro’s antivirus/antispam solution for Microsoft Exchange Server.

The product can be used with Exchange 2003, 2007 and the most current version of 2010. Let’s start with having a look at the new features of SMEX 10.

**New features**

Just like Exchange 2010 Trend Micro has also introduced the Role Based access. Using this method of assigning permissions it will let you create templates and assign those templates to users.

Another nice addition to the product is the ability to use AD objects in the policies you configure. This will give you the ability to create policy for a specific AD group. For example, you have got a group of developers in your company. These developers must have the ability to receive specific file types which are blocked by the default policy. In this scenario you can exclude the developers group from the default policy and apply the custom created policy.

SMEX 10 contains two types of reputation services:

  * Web reputation (WRS), which will check all url’s in a message
  * E-mail reputation (ERS), which checks the IP-address of the sending mail server

Especially the last option can decrease the amount of spam/viruses messages which will have to be processed by the policy or arriving at the end users mailbox.

The Web Reputation Services (WRS)  feature included in SMEX will check every e-mail for malicious URL’s. By enabling WRS you will add an extra detection layer on top of the Anti-spam/Anti-virus technology which is already used by the product. WRS can detect “0-Day” attack, as well as recently new type of spam and phishing attack like “Here you are “ spam and spear phishing.

If you are having a Trend Micro SmartScan server deployed you can configure SMEX 10 to use it. The advantage of using the smartScan method compared to the conventional scanning method is that the footprint on the server is smaller. This is caused by the fact that the pattern files are a lot smaller. Another advantage is better detection.  Cloud side (Trend file reputation service) always deploys latest anti-malware knowledge which is ahead of conventional anti-malware pattern. 

In the picture below you see how the process works:

<div>
  <div>
    <div>
      <p>
        <a href="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/trend-frs.jpg"><img title="File Reputation Services" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/trend-frs-300x120.jpg?resize=300%2C120" alt="" width="300" height="120" data-recalc-dims="1" /></a>
      </p>
    </div>
  </div>
</div>

As last major change, besides the optimization of the product, is integration of Data Leakage Prevention (DLP) Policies. Using these default DLP policies you can prevent data being leaked via e-mail from your company to the outside world.
  
The installation of SMEX 10 is pretty easy. But before starting the installation add the CGI component to the IIS server. Once this is done the setup can be launched. One of the first steps in the setup will ask you which Exchange version you have deployed. If deploying it on an Exchange 2007 or 2010 Server you must specify if you are installing it on an Edge or on a Hub Transport/Mailbox Server.Depending on the roles installed on your server a set of scan methods are available. For example on a mailbox server a mail store scan can be performed. While on a Hub Transport server scanning can be done during transport.

[<img title="Server en rol selecteren" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/select_server-300x245.jpg?resize=300%2C245" alt="" width="300" height="245" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/select_server.jpg)

In the next step you will need to add one or multiple servers. This can either be done by adding a server manually or via the browse option. In this last scenario make sure you enable the Computer Browser service which might be disabled by default depending on your OS.

Next step is to provide the credentials of an account which is a member of the Organization Management Exchange security group. If you are planning to use the End User Quarantine option this account also needs to have domain admin permissions.

By default the installation will be performed on the C drive of the server. Scanmail will need to install a web application for management purposes. By default an additional website will be created in IIS for this purpose. Another option is to place it in the default website. My recommendation is to install it in a separate site. The reason for this is that Exchange uses the default website by default for all Exchange Web Services.

Optionally you can select the option to enable SSL. When enabling this option a self-signed certificate will be installed for the website.

The next step will verify if all prerequisites have been met. If this is not the case you will be warned and you will need to solve these issues before you can continue.

[<img title="Controle systeem eisen" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/check_prereq-300x245.jpg?resize=300%2C245" alt="" width="300" height="245" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/check_prereq.jpg)

Because Scanmail will retrieve its updates from the internet you may need to provide a proxy server. If this is not the case leave the option unselected. After providing the activation key you get the option to participate in the World Virus Tracking Program. This program will gather real time data for the Virus Map of Trend Micro.

As already mentioned Scanmail will have the option to place spam messages in a specific folder. Scanmail will give you to options:

  * Integrate with Outlook Junk Mail
  * Integrate with EUQ which is a separate folder created by Scanmail

Personally I prefer the Outlook Junk Mail as this will provide users with one location where they can find they’re quarantined messages.

If you are having multiple Trend Micro solutions you might have implemented Trend Micro Control Manager. This program will give you the ability to manage all Trend Micro products via one interface.

Because of the Active Directory integration the setup will give you the option to select an Active Directory group which has access permissions to the Access Console.

Before starting the installation you will get a short summary. If you are satisfied with the settings then continue and start the installation.

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="614" valign="top">
      <strong>Note:</strong></p> 
      
      <p>
        One thing you should keep in mind is that the setup will install a SQL Express 2005 instance on your Exchange server. If you don’t want this prepare the database on an external SQL server and specify this SQL server during the setup.</td> </tr> </tbody> </table> 
        
        <p>
          After the installation has been completed make sure you install the latest service pack and patches available.
        </p>
        
        <p>
          <strong>Configuration</strong>
        </p>
        
        <p>
          Now SMEX has been installed let’s have a look at the configuration part. By default only the following antispam/antivirus components are enabled:
        </p>
        
        <ul>
          <li>
            Security Risk Scan, which scans messages for viruses and spyware both on transport and store level;
          </li>
          <li>
            Web reputation, which scans all messages for malicious URL’s;
          </li>
          <li>
            Content Scanning, which is part of the Spam prevention option and scans messages for undesirable content. For example sensitive info and unprofessional info;
          </li>
        </ul>
        
        <p>
          Because each environment is unique it might be necessary to adjust the default configuration settings. For example, you might want to scan all messages for all spyware/grayware. By default SMEX only scans for spyware and adware.
        </p>
        
        <p>
          But how does the web reputation service work? Every url is checked against a database which contains a rate for the url. The Web Reputation rating is based on a number of factors including domain profiling, malware behavior related to the site, site content scanning, site categorization and correlation with phishing and spam intelligence among other things. To configure which ratings should be blocked you will need to configure the security level. SMEX does contain three security levels:
        </p>
        
        <ul>
          <li>
            High, blocks a greater number of Web threats, each url with a rating of 80 or lower. Change of false positives increases.
          </li>
          <li>
            Medium, blocks most Web threats and limits the amount of false positives. Each url with a rating of 65 or lower
          </li>
          <li>
            Low, blocks fewer Web threats and decreases the amount of false positives. Each url with a rating of 50 or lower
          </li>
        </ul>
        
        <p>
          In the diagram below you can see a diagram of the complete process:<br /> <a href="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/wrs.jpg"><img title="WRS proces" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/wrs-300x52.jpg?resize=300%2C52" alt="" width="300" height="52" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          When a message arrives the following steps are performed:
        </p>
        
        <ul>
          <li>
            A message arrives at the Edge or Hub Transport server which contains SMEX 10;
          </li>
          <li>
            SMEX detects a url in the message and sends it to the WRS Cloud service;
          </li>
          <li>
            WRS checks the url and returns the rating to SMEX 10;
          </li>
          <li>
            If the rating is passes the threshold the message will be either delivered using a modified subject or placed in quarantine;
          </li>
        </ul>
        
        <p>
          Additionally you might want to enable some extra components. For example block all attachments which have program/scripting extensions such as bat, cmd and wsh or just block specific file types.
        </p>
        
        <p>
          A second option which you might want to enable is the content filtering component. This component contains some predefined policies. These policies can be split up in:
        </p>
        
        <ul>
          <li>
            Specific word categories: such as profanity, hoaxes and chainmail;
          </li>
          <li>
            DLP, default DLP policies for specific countries/continents;
          </li>
        </ul>
        
        <p>
          As already explained every environment requires different policies. For example you might receive a lot of spam which is not detected by other filters. In this case create a custom policy which filters specifically those words.
        </p>
        
        <p>
          <a href="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/policies.jpg"><img title="Policies" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/policies-300x183.jpg?resize=300%2C183" alt="" width="300" height="183" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          The second component I would highly recommend is the E-mail Reputation Service (ERS) which is part of the Spam Prevention part of SMEX. ERS works just like a black list is an IP address found then the connection is dropped. The advantage of ERS compared to blacklists is that you can configure them using a web portal provided by Trend Micro. For example, if you don’t want to block messages from a specific country even if they are listed make the configuration change in the ERS web portal.
        </p>
        
        <p>
          <a href="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/ers.jpg"><img title="ERS Portal" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/ers-300x258.jpg?resize=300%2C258" alt="" width="300" height="258" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          As you can see in the screenshot above you can also add specific ISP’s and ip addresses to the approved list. Besides approving it’s also possible to block a country, ISP or ip address using this website.
        </p>
        
        <p>
          One important note about the ERS is that there must be no other MTA between the sending server and Exchange. This will cause ERS not be able to work correctly because it only checks the last MTA’s ip address.
        </p>
        
        <p>
          Once you are satisfied with the configuration you can replicate the configuration to other servers. This option is very useful if you are having multiple SMEX instances but want to keep the configuration the same on all of them.
        </p>
        
        <p>
          By selecting the <em>Server Management</em> option you will get an overview of all SMEX instances:
        </p>
        
        <p>
          <a href="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/server_mgmt.jpg"><img title="Server Management" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/server_mgmt-300x87.jpg?resize=300%2C87" alt="" width="300" height="87" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          Select the server(s) to which you would like to replicate and press the replicate button. The next step is to select which configuration settings will need to be replicated. By default all settings will be replicated. In this case you would like to replicate only a subset select only those features which you would like to replicate.
        </p>
        
        <p>
          <strong>Reporting and logging</strong>
        </p>
        
        <p>
          In addition to the real time monitoring of the traffic SMEX has the option to generate reports. These reports can either be created manually or automatically via a schedule.
        </p>
        
        <p>
          In the screenshot below you can see an example of which content you can add to a report. A scheduled report can be created daily, weekly or monthly. As you can see you can add a lot of content to the report. Using these reports you might see some trends for example one specific user is receiving a lot of spam. Or you just want to know how much traffic passes the SMEX solution.
        </p>
        
        <p>
          <a href="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/scheduled_report.jpg"><img title="Scheduled report" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/scheduled_report-300x181.jpg?resize=300%2C181" alt="" width="300" height="181" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          Compared to a manual report a scheduled report also has the option to send the report to one or multiple e-mail addresses. Which might be very useful if you do not want to login to the admin console daily.
        </p>
        
        <p>
          But how does a report looks like? Well in the screenshot below a small part of the report being generated. In this example you can see the Spam Prevention statistics. It starts with a summary which gives you a quick overview. Because you might want to distribute this report to the management it might be nice to also include the graph. The graph will display the percentage of spam messages compare to the complete amount of messages.
        </p>
        
        <p>
          <a href="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/spam_prevention_stat.jpg"><img title="Spam Prevention Statistics" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/spam_prevention_stat-300x282.jpg?resize=300%2C282" alt="" width="300" height="282" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          Below the graph an overview of the top 5 spam senders will be displayed. Due to privacy I haven’t included them in the screenshot above.
        </p>
        
        <p>
          In addition to the reports you may also consult the log files available. The logs are divided in a few types:
        </p>
        
        <ul>
          <li>
            Security risk scan, gives an overview of messages  which did break the security risks configured;
          </li>
          <li>
            Attachment blocking, gives an overview of attachments blocked;
          </li>
          <li>
            Content filtering, gives an overview of messages which are tagged by the content filter;
          </li>
          <li>
            Update, an overview of the update process, here you will find if an update has succeeded or failed;
          </li>
          <li>
            Scan event, an overview of manual and scheduled scan tasks;
          </li>
          <li>
            Backup for security risk, information about the files that the Security Risk Scan moved to the backup folder;
          </li>
          <li>
            Backup for content filter, information about the files that Content Filtering moved to the backup folder;
          </li>
          <li>
            Unscannable message parts, gives an overview of messages which couldn’t be scanned partitially;
          </li>
          <li>
            Event tracking, gives an overview of administrative tasks performed, for example log in/outs, configuration changes made or messages released from quarantine;
          </li>
          <li>
            Web reputation, gives an overview of web reputation checks performed;
          </li>
        </ul>
        
        <p>
          In the screenshot below a part is displayed of the Content filtering log. As you can see a lot of information is displayed:
        </p>
        
        <p>
          <a href="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/cont_filt_log.jpg"><img title="Content filtering log" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/06/cont_filt_log-300x49.jpg?resize=300%2C49" alt="" width="300" height="49" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          But this is not all information when scrolling to the right you will find the most interesting information:
        </p>
        
        <p>
          <a href="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/06/cont_filt_log_2.jpg"><img title="Content Filtering log" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/06/cont_filt_log_2-300x119.jpg?resize=300%2C119" alt="" width="300" height="119" data-recalc-dims="1" /></a>
        </p>
        
        <p>
          In this piece of the logging you can see detailed information about:
        </p>
        
        <ul>
          <li>
            which policy did get applied to the message;
          </li>
          <li>
            which action has been taken;
          </li>
          <li>
            which matching keyword(s) where found;
          </li>
        </ul>
        
        <p>
          So as you can see a lot of information is stored in the logs which might be very useful during troubleshooting.
        </p>
        
        <p>
          <strong>Conclusion</strong>
        </p>
        
        <p>
          Here ends my article about Trend Micro’s Scanmail for Exchange 10. Trend Micro did include a lot of nice new features.  By default the antispam and antivirus settings might require you to make some modifications. For example Email Reputation is disabled by default; it might be worth to enable the option if possible. Enabling this option will prevent a lot of spam arriving in the end users mailbox but also saves a lot of processing time from Scanmail.
        </p>
        
        <p>
          To fine tune your solution you might consider creating a custom content filter. By using this custom filter you can block specific messages which pass the other filters. This will result in less spam arriving at the end users mailbox. If you are finding it a little bit tricky to just delete the message use the quarantine option. This will place the message in the junk mail folder or EUQ folder from the user. If a user misses a message he or she can retrieve the message easily.
        </p>
        
        <p>
          At this moment the beta for SMEX 10.2 will almost start I am very curious which new features will be added.
        </p>