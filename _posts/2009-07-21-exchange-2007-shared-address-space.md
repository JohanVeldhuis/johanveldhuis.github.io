---
id: 1251
title: Exchange 2007 shared address space
date: 2009-07-21T20:10:49+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1251
permalink: /exchange-2007-shared-address-space/
categories:
  - Exchange
---
Sometimes you will find the situation having several types of mailservers within one organization, for example Exchange in combination with another mailserver. But how can you arrange that Exchange will accept the mail, checks if the recipient exists on the Exchange server and if not will forward it to the other mailserver.

In this tutorial we will ensure that mail which is send to the domain johanveldhuis.nl will be accepted by Exchange and if the user does not exist Exchange will forward it to the other mailserver with ip address 192.168.0.52

First we will need to make sure Exchange will accept the mail for the specific domain. This can be done via the <em>Exchange Management Console</em> or via the <em>Exchange Management Shell.</em>
Start the EMC and select the HUB Transport server below organizational configuration and select the option new accepted domain. A wizard will start and will help you to create the new accepted domain.

 
<a title="Wizard new accepted domain - step 1" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_accepted_domainl.jpg"><img class="alignnone size-thumbnail wp-image-1254" title="Wizard new accepted domain - step 1" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_accepted_domainl-150x150.jpg" alt="Wizard new accepted domain - step 1" width="150" height="150" /></a>

Fill in a name and the accepted domain. You could choose to accept only mail which is send to johanveldhuis.nl or also every subdomain. In this case you will need to put *. in front of the domain name or ensure a checkmark is placed in the box before include all subdomains.

Next option is to select the type of domain, in this case we choose the option internal relay domain. When all options are set correctly click on new and after that on finish to close the wizard.

<a title="Wizard new accepted domain - step 2" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_accepted_domain_2.jpg"><img class="alignnone size-thumbnail wp-image-1253" title="Wizard new accepted domain - step 2" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_accepted_domain_2-150x150.jpg" alt="Wizard new accepted domain - step 2" width="150" height="150" /></a>
 

When you choose the incorrect option, for example the default option authoritive domain, Exchange would generate a NDR when it can't find a user which matches the e-mail address of the recipient.
The second step is to create the send connector, with this Exchange knows what to do with mail when a user is not found on the Exchange server. Select the option new send connector again a wizard will be started.

<a title="Wizard new send connector - step 1" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector.jpg"><img class="alignnone size-thumbnail wp-image-1255" title="Wizard new send connector - step 1" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector-150x150.jpg" alt="Wizard new send connector - step 1" width="150" height="150" /></a>

Fill in a logical name, for example the domainname for which the send connector is created, and select internal as the type connector and then click next to continue.

<a title="Wizard new send connector - step 2" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_2.jpg"><img class="alignnone size-thumbnail wp-image-1257" title="Wizard new send connector - step 2" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_2-150x150.jpg" alt="Wizard new send connector - step 2" width="150" height="150" /></a>

In the next screen you will need to specify a name space, the domainname for which the send connector will be used.In this case johanveldhuis.nl, all other options are keeping the default values. When the name space is added click on next to go to the next step.
 

<a title="Wizard new send connector - step 3" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_3.jpg"><img class="alignnone size-thumbnail wp-image-1258" title="Wizard new send connector - step 3" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_3-150x150.jpg" alt="Wizard new send connector - step 3" width="150" height="150" /></a>

In this step we will define the network settings. There are two options: deliver via dns of via a smarthost. In this case we choose the option smarthost and fill in the ip address of the other mailserver in the newly opened window. When it is added click on next to go to the next step.

<a title="Wizard new send connector - step 4" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_4.jpg"><img class="alignnone size-thumbnail wp-image-1259" title="Wizard new send connector - step 4" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_4-150x150.jpg" alt="Wizard new send connector - step 4" width="150" height="150" /></a>

In this screen we define the authentication method. For security reasons it may be necessary to specify a username and password of a certificate which is used for authentication. Select the correct authentication method, selecting the incorrect one can prevent mail from getting delivered.

<a title="Wizard new send connector - step 5" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_5.jpg"><img class="alignnone size-thumbnail wp-image-1260" title="Wizard new send connector - step 5" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_5-150x150.jpg" alt="Wizard new send connector - step 5" width="150" height="150" /></a>

One of the last steps is specifying the source server, in this case we only have one server so this is correct. If there are more HUB Transport servers or you are using the Edge Server ensure that all correct servers are added.

 
<a title="Wizard new send connector - step 6" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_6.jpg"><img class="alignnone size-thumbnail wp-image-1261" title="Wizard new send connector - step 6" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_6-150x150.jpg" alt="Wizard new send connector - step 6" width="150" height="150" /></a>

Click on next and then on new to create the send connector.

<a title="Wizard new send connector - step 7" href="https://johanveldhuis.nl/wp-content/uploads/2009/07/new__send_connector_7.jpg"><img class="alignnone size-thumbnail wp-image-1262" title="Wizard new send connector - step 7" src="https://johanveldhuis.nl/wp-content/uploads/2009/07/new_send_connector_7-150x150.jpg" alt="Wizard new send connector - step 7" width="150" height="150" /></a>

The configuration is finished, of course when the other mailserver is configured correctly, mail can be send from the internet to users on both the Exchange server and the other mailserver.

Ofcourse all steps can also be performed via the Exchange Management Shell, below two commands with the correct parameters which can be used:

```PowerShell
New-AcceptedDomain -Name "johanveldhuis.nl" -DomainName johanveldhuis.nl -DomainType InternalRelay
New-SendConnector -Name "johanveldhuis.nl" -Internal -AddressSpace johanveldhuis.nl -DnsRoutingEnabled $false -SmartHosts 192.168.0.52 -SmartHostAuthMechanism ExternalAuthoritative -MaxMessageSize 20MB
```