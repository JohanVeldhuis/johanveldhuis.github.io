---
id: 697
title: Implement an Edge Transport server
date: 2008-08-20T19:19:34+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=697
permalink: /implement-an-edge-transport-server/
categories:
  - Tutorials
---
In this tutorial we will have a look which steps are needed to implement an Edge Transport server in an Exchange 2007 environment.</p>
<p>Installing the Edge Transport server is not very hard and configuring it is not a lot of work. We could start with the setup which will tell us which prerequisites are needed. If you would like to prevent this then download and install the following software before you start the setup:</p>
<ul>
<li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=10ee29af-7c3a-4057-8367-c9c1dab6e2bf&amp;DisplayLang=en" target="_blank">Powershell 1.0</a></li>
<li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=4C84F80B-908D-4B5D-8AA8-27B962566D9F&amp;displaylang=en" target="_blank">MMC 3.0</a></li>
<li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=0856eacb-4362-4b0d-8edd-aab15c5e04f5&amp;displaylang=en" target="_blank">.Net 2.0</a></li>
<li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=79BC3B77-E02C-4AD3-AACF-A7633F706BA5&amp;displaylang=en" target="_blank">.Net 2.0 SP1</a></li>
<li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=9688F8B9-1034-4EF6-A3E5-2A2A57B5C8E4&amp;displaylang=en" target="_blank">Active Directory Application Mode</a></li>
</ul>
<p>The Active Directory Application Mode (ADAM) will let the Edge Transport server check the Active Dire tory if a user exists and if not block the e-mail.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_1.jpg"><img class="alignnone size-thumbnail wp-image-698" title="Edge Transport server " src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_1-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>During the setup we choose the option <em>Custom Exchange Server Installation </em>with this option we can choose that we only install the <em>Edge Transport Server </em>on this server. When we click on <em>next </em>we will get the following screen:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_2.jpg"><img class="alignnone size-thumbnail wp-image-699" title="Edge Transport Server" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_2-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Here we only select the <em>Edge Transport Server Role </em>and click on the <em>next </em>button</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_3.jpg"><img class="alignnone size-thumbnail wp-image-700" title="Edge Transport Server warning" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_3-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Exchange will first run some tests: it will check if all necessary software is installed and the system meets the systemrequirements. As you can see this is not the case in my situation. I am trying to install the Edge Transport server on a 32-bit OS. This is not supported by Microsoft, in this case it doesn't matter because we run it in a test environment. If installing it in a production environment install it on a server with a 64-bit OS. When clicking on <em>install </em>we continue with the installation.</p>
<p>When the installation is finished we can start the <em>Exchange Management Console</em>, this will look like the screenshot below:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_4.jpg"><img class="alignnone size-thumbnail wp-image-701" title="Exchange Managemente Console" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_4-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>You can see that a few tabs are the same as on the Hub Transport Server. These tabs are empty at this moment but will be filled automatically during the configuration.</p>
<p>Because the Edge Transport Server and Hub Transport Server not know of eachother we first need to export the <em>Edge Subscription </em>and then import it on the Hub Transport Server. This can be done with the following command: <em>New-EdgeSubscription </em>by executing it with the correct parameters a XML file is created which can be imported on the Hub Transport Server.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_5.jpg"><img class="alignnone size-thumbnail wp-image-702" title="New-edgesubscription" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_5-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The following command will create a file in the root of C.</p>

```PowerShell
New-EdgeSubscription -filename "c:\Edgeexport.xml"
```

<p>When you would like to put it in a directory first create the directory before executing the command.</p>
<p>The next step is to import the <em>Edge Subscription</em> on the Hub Transport server. Please keep in mind that this needs to be done within a few hours, else you can't subscribe the Edge to the Hub Transport. To do this we go via the <em>Organization Configuration</em> to the <em>Hub Transport Server</em> and select the tab <em>Edge Subscriptions. </em>Then select <em>New Edge Subscription </em>from the right menu or click somewhere in the white space of the tab with the right mouse button and select the option. When you have done this a wizard will be started.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/setup_6.jpg"><img class="alignnone size-thumbnail wp-image-703" title="New Edge Subscription wizard" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/setup_6-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Via <em>browse </em>select the file just created and select the correct AD Site.  When you did this click on <em>New. </em>The option to create a new send connector on the Hub Transport Server is on by default. This connector will be configured to only send mail to the internet via the Edge Transport Server.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/setup_7.jpg"><img class="alignnone size-thumbnail wp-image-704" title="New Edge Subscription completed" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/setup_7-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When the file is imported and the connector is created you will get a warning. The Hub Transport Server and Edge Transport Server need to communicate via port 50636.</p>
<p>After completing this the Hub Transport server is ready for synchronisation with the Edge Transport Server. But first we need to configure some things on the Edge Transport Server before we can really start the synchronisation.</p>
<p>First we need to create a new <em>SMTP Receive Connector </em>on the Edge Transport Server. This can be done via the <em>Exchange Management Console. </em>When we start it we need to go via <em>Organization configuration</em> to the <em>Edge Transport Server</em> and select the tab <em>Receive connectors</em>. By selecting the option <em>New SMTP Receive Connector </em>from the right side of the screen we will get a wizard. Within the wizard we will seect the option to create a connector of the type <em>Internal.</em> When we have done this we click on <em>next, </em>you will get the following screen:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_10.jpg"><img class="alignnone size-thumbnail wp-image-706" title="New SMTP Receive Connector" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_10-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Here we fill in the IP-address of the <em>Hub Transport Server </em>with a subnet mask of  255.255.255.255, this will only allow this IP-address. When we click on <em>next </em>we get a short summary and after pushing the button <em>new </em>the connector is created.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_11.jpg"><img class="alignnone size-thumbnail wp-image-707" title="New SMTP Receive connector" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_11-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Now we did all preparations it's time to start the Edge Synchronisation, this can be done via the following command <em>Start-EdgeSynchronization</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_13.jpg"><img class="alignnone size-thumbnail wp-image-708" title="Start-EdgeSubscription" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_13-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When everything is configured OK we will see that both tasks have the status <em>Success. </em>When you go back to the <em>Exchange Management Console </em>you can see that somethings are imported.</p>
<p><a href="http:s//johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_14.jpg"><img class="alignnone size-thumbnail wp-image-709" title="Edge Transport Accepted Domains" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_14-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The <em>accepted domains </em>are added to the <em>Edge Transport Server </em>and 2 new <em>Send Connectors </em>are created.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_15.jpg"><img class="alignnone size-thumbnail wp-image-710" title="Edge Transport Send Connectors" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_15-150x103.jpg" alt="" width="150" height="103" /></a></p>
<p>When we now go back to the <em>Hub Transport Server </em>you will see that also there 2 new <em>Send Connectors </em>are created.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_16.jpg"><img class="alignnone size-thumbnail wp-image-711" title="Hub Transport Send Connectors" src="https://johanveldhuis.nl/wp-content/uploads/2008/08/edge_setup_16-150x136.jpg" alt="" width="150" height="136" /></a></p>
<p>One connector is used for traffic to the internet, this will be send to the <em>Edge Transport Server</em>. The other connector is used for receiving mail from the <em>Edge Transport Server</em>.</p>
<p>Now the only things that are needed to be configured are the rules for the different agents. This will fall out of this scope of this tutorial but are described in an earlier tutorial <a href="http://johanveldhuis.nl/?page_id=288">Install Anti-spam Agents on the Hub Transport server</a></p>