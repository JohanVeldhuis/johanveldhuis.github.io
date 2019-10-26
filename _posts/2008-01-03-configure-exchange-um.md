---
id: 178
title: Configure Exchange UM
date: 2008-01-03T12:32:15+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=202
permalink: /exchange-um-configureren/
categories:
  - Exchange
---
In this tutorial I will explain how you can configure the UM option in Exchange. In this tutorial I assume that you already have installed the UM functionality.

Configuring the UM functionality can be done in two ways:
<ul>
	<li>via the Exchange Management Console</li>
	<li>via the Exchange Management Shell</li>
</ul>
In this tutorial we will use the Exchange Management Console to configure the UM options

First we start the Exchange Management Console and open the option <em>Organization Configuration</em>.

<a title="Organization Configuration" href="https://myuclab.nl/wp-content/uploads/2008/03/image1.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image1.thumbnail.jpg" alt="Organization Configuration" /></a>

Below this you will find 4 sub menu's:
<ul>
	<li>mailbox</li>
	<li>client access</li>
	<li>hub transport</li>
	<li>unified messaging</li>
</ul>
The last of the 4 we need, this because we would like to configure the UM functionality. When you click on it the middle piece of the MMC changes and will get 4 tabs.

<a title="Unified Messaging" href="https://myuclab.nl/wp-content/uploads/2008/03/image2.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image2.thumbnail.jpg" alt="Unified Messaging" /></a>

The first tab is named <em>UM Dial Plans</em>; configuring starts here. In the right side of the screen a menu is displayed, click on <em>New UM Dial Plan</em>, the following window will be opened:

<a title="UM Dial Plan" href="https://myuclab.nl/wp-content/uploads/2008/03/image3.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image3.thumbnail.jpg" alt="UM Dial Plan" /></a>

As you can see above the window contains four fields. All the fields need to be filled in:
<ul>
	<li>name: give a name of the dial plan</li>
	<li>number of digits in extension numbers: fill in the amount of digits that you want to use for the extension.</li>
	<li>URI type: in this case we select <em>telephone extension</em></li>
	<li>VoIP Security: in this case unsecured, when you want to use TLS you will have to use <em>secured</em></li>
</ul>
When all fields are filled in click on <em>new </em>to create the dial plan. When the dial plan is created you will see it when you select the tab <em>UM Dial Plans</em>:

<a title="UM Dial Plan" href="https://myuclab.nl/wp-content/uploads/2008/03/image4.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image4.thumbnail.jpg" alt="UM Dial Plan" /></a>

When you select the <em>UM Mailbox Policies </em>tab you can see that there is a policy created with the name <em>name of the numberplan-default</em>. When you create a dial plan there will also be a default policy created. In this policy several things are specified: minimum pin length, how long may the voicemail message be and a lot of other options. This can be used to create separate policies for different users. For example you can give user A a shorter voicemail text then user B.

<a title="UM Mailbox Policy" href="https://myuclab.nl/wp-content/uploads/2008/03/image5.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image5.thumbnail.jpg" alt="UM Mailbox Policy" /></a> 

The next step will be to define the IP gateway, this is the device where all incoming calls are arriving at the Exchange server and via which all outgoing calls leave the Exchange server.  By pressing <em>New UM IP </em>Gateway in the right menu you will get the following window:

<a title="UM IP Gateway" href="https://myuclab.nl/wp-content/uploads/2008/03/image6.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image6.thumbnail.jpg" alt="UM IP Gateway" /></a>

In this windows we need to specify the following:
<ul>
	<li>name: name of the IP Gateway</li>
	<li>IP Address/FQDN: IP-address or fully qualified domainname of the IP Gateway</li>
</ul>
When this two fields are filled in you can assign the created <em>dial plan </em>to the <em>IP Gateway. </em>When doing this a hunt group will be created for the specific gateway. When you do not select a dial plan then you need to create the hunt group manually. When the wizard is finished you will have the following address:

<a title="UM IP Gateway" href="https://myuclab.nl/wp-content/uploads/2008/03/image7.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image7.thumbnail.jpg" alt="UM IP Gateway" /></a>

You can see that it exists of 2 levels:
<ul>
	<li>IP gateway</li>
	<li>default hunt group</li>
</ul>
The hunt group arranges that the <em>IP Gateway </em>and the <em>dial</em> <em>plan </em>can communicate with each other. When creating the <em>hunt group</em>  manually you will need to manually assign a pilot number to it. In the following example I will try to explain why this is needed:

If you create a hunt group with the following numbers: 301, 302, 303, 304 where 301 is the hunt group. When 301 is called the hunt group will arrange that the call will be transferred to the first number who is free.

The final step is to create an <em>auto attendant. </em>With this feature we can arrange that people who call will here a standard text or will get a menu from which they have to choose, for example reaching a specific department.

Go to the tab <em>auto attendant</em> and press <em>New UM Auto Attendant</em> in the right menu, you will get the following window:

<a title="Auto Attendant" href="https://myuclab.nl/wp-content/uploads/2008/03/image8.jpg"><img src="https://myuclab.nl/wp-content/uploads/2008/03/image8.thumbnail.jpg" alt="Auto Attendant" /></a>

We will need to fill in thw following fields:

name: naam van de auto attendant
<ul>
	<li>associated dial plan: select to which dial plan you want to assign the auto attendant</li>
	<li>extension numbers: add the extensions that you want to use for the auto attendant</li>
	<li>create auto attendant as enabled: will enable the auto attendant immediately after creating it.</li>
	<li>create auto attendant as voice enabled: will enable the auto attendent for voice support (with this option you can give commands by talking to the auto attendant)</li>
</ul>
The latest step is assigning the dial plan to the server, follow the next steps to complete the configuration:
<ul>
	<li>open <em>server configuration</em></li>
	<li>choose <em>Unified Messaging</em></li>
	<li>open the properties of the server</li>
	<li>click the <em>UM Settings tab</em></li>
	<li>click the <em>Add</em> button</li>
	<li>add the dial plan.</li>
</ul>
When you have done all steps you will have a working Exchange UM environment, if the PBX, etc is/are configured OK. If you don't have this you can also try the UM options via the Exchange UMTestPhone. You will find a tutorial on this website about it.