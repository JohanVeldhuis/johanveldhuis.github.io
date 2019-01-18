---
id: 190
title: UM opties activeren voor gebruiker
date: 2008-01-06T22:03:26+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=190
permalink: /configure-um-options-for-user/
categories:
  - Exchange
---
This tutorial will explain how you can activate the UM options for a user.

There are two ways to activate the UM options for a user:
<ul>
	<li>via the Exchange Management Console</li>
	<li>via the Exchange Management Shell</li>
</ul>
In this tutorial we will do it via the easy way, via the Exchange Management Console.

First we startup the <em>Exchange Management Console</em> and open the <em>Recipient Configuration</em> and choose <em>mailbox. </em>The middle part of the screen will display the current users who can use Exchange.

 <a title="Mailbox" href="https://johanveldhuis.nl/wp-content/uploads/2008/03/image14.jpg"><img src="https://johanveldhuis.nl/wp-content/uploads/2008/03/image14.thumbnail.jpg" alt="Mailbox" /></a>

By selecting the user for which you want to enable UM you will get an option in the right menu called <em>activate Unified Messaging</em> a wizard will be opened.

<a title="Wizard" href="https://johanveldhuis.nl/wp-content/uploads/2008/03/image111.jpg"><img src="https://johanveldhuis.nl/wp-content/uploads/2008/03/image111.thumbnail.jpg" alt="Wizard" /></a>

Click the button <em>browse</em> to select the policy which you want to assign to the user. Then in the <em>pin </em>section select the option to manually enter a pin or let Exchange generate a pin. Besides that you can select the option <em>Require user to reset pin at first telephone logon, </em>the user then needs to change his pin after his first logon.

Click on the <em>next </em>button to proceed, you will get the following screen:

<a title="Extension configuration" href="https://johanveldhuis.nl/wp-content/uploads/2008/03/image12.jpg"><img src="https://johanveldhuis.nl/wp-content/uploads/2008/03/image12.thumbnail.jpg" alt="Extension configuration" /></a>

Choose the extension/phone number which you want to assign to the user and click the <em>next</em> button.

We reached the final step, Exchange will give a short summary of the things we configured. When you click on <em>enable </em>all changes will be applied and the user can use the UM options.

<a title="Enable Unified Messaging" href="https://johanveldhuis.nl/wp-content/uploads/2008/03/image13.jpg"><img src="https://johanveldhuis.nl/wp-content/uploads/2008/03/image13.thumbnail.jpg" alt="Enable Unified Messaging" /></a>