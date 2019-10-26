---
id: 2599
title: 'Setting up a Geo DNS environment in your test lab &#8211; part I'
date: 2012-12-02T20:54:35+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2599
permalink: /een-geo-dns-omgeving-opzetten-deel-i/
categories:
  - Exchange
---
In one of my previous blogs about Exchange 2013 we talked about how we can install Exchange 2013 using the cmdline.

As you may know there have been made several changes to Exchange related to high availability and site resilience. In this blog we will build a test environment which makes it possible to test the concept of geo DNS.

Let’s start with explaining what geo DNS is. Geo DNS is a system which returns IP-addresses to the client depending on their location. This location is determined by their IP address. Using geo DNS you will get the option to send clients to the datacenter for their region.

Below a graphical overview of our lab environment which we are going to build:

[<img class="aligncenter size-medium wp-image-2600" title="Network overview" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2012/11/Network-overview-300x287.jpg?resize=300%2C287" alt="" width="300" height="287" srcset="https://i2.wp.com/myuclab.nl/wp-content/uploads/2012/11/Network-overview.jpg?resize=300%2C287&ssl=1 300w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2012/11/Network-overview.jpg?w=531&ssl=1 531w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2012/11/Network-overview.jpg)

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="211">
      <strong>Server</strong>
    </td>
    
    <td valign="top" width="197">
      <strong>Role</strong>
    </td>
    
    <td valign="top" width="197">
      <strong>IP</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="211">
      DC01
    </td>
    
    <td valign="top" width="197">
      Domain Controller
    </td>
    
    <td valign="top" width="197">
      192.168.2.50
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="211">
      DC02
    </td>
    
    <td valign="top" width="197">
      Domain Controller
    </td>
    
    <td valign="top" width="197">
      192.168.3.50
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="211">
      EX01
    </td>
    
    <td valign="top" width="197">
      Exchange 2013 Multirole server
    </td>
    
    <td valign="top" width="197">
      192.168.2.51
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="211">
      EX02
    </td>
    
    <td valign="top" width="197">
      Exchange 2013 Multirole server
    </td>
    
    <td valign="top" width="197">
      192.168.3.51
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="211">
      GEODNS
    </td>
    
    <td valign="top" width="197">
      Windows Server with only the DNS role installed
    </td>
    
    <td valign="top" width="197">
      192.168.1.50
    </td>
  </tr>
</table>

I will assume the following prerequisites are met:

  * Both DC’s are in place and replication between them works correctly
  * Both Exchange 2013 Multirole servers are installed using my previous blog or one of the many other blogs which are available on the internet
  * The GEODNS server contains a basic OS and the DNS role is installed

Let’s start with the GEODNS server you may think does Windows offer this functionality? But for real world scenarios you will most likely use one of the DNS servers from vendors offering the service.

To make our GEODNS server ready the only thing we will have to do is add some DNS records which point to the servers in both datacenters. In the table below you will find an overview of the DNS records we will create:

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="302">
      <strong>Record</strong>
    </td>
    
    <td valign="top" width="302">
      <strong>IP</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="302">
      autodiscover.myuclab.nl
    </td>
    
    <td valign="top" width="302">
      192.168.2.51</p> 
      
      <p>
        192.168.3.51</td> </tr> 
        
        <tr>
          <td valign="top" width="302">
            mail.myuclab.nl
          </td>
          
          <td valign="top" width="302">
            192.168.2.51</p> 
            
            <p>
              192.168.3.51</td> </tr> </tbody> </table> 
              
              <p>
                As you can see we will create the records twice, one per IP. So how will the Windows DNS server answer? By default it will use Round Robin to provide the answers:
              </p>
              
              <p>
                <em>Nslookup autodiscover.myuclab.nl</em>
              </p>
              
              <p>
                <em>192.168.2.51<br /> 192.168.3.51</em>
              </p>
              
              <p>
                When we peform the same answer we will get this answer:
              </p>
              
              <p>
                <em>Nslookup autodiscover.myuclab.nl</em>
              </p>
              
              <p>
                <em>192.168.3.51<br /> 192.168.2.51</em>
              </p>
              
              <p>
                But there’s a nice feature of Windows DNS we can use for our geo DNS solution called netmask ordering. Using this feature we can arrange that the IP of the server which matches the client subnet is returned as the first answer if round robin has been disabled.
              </p>
              
              <p>
                For example when we do an nslookup from a machine which is placed in the 192.168.3 segment we will get the following answer:
              </p>
              
              <p>
                <em>Nslookup autodiscover.myuclab.nl</em>
              </p>
              
              <p>
                <em>192.168.3.51<br /> 192.168.2.51</em>
              </p>
              
              <p>
                For all operating systems make sure the following registry key is in place:
              </p>
              
              <p>
                <em>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters<br /> </em><em>DWORD = OverrideDefaultAddressSelection </em>
              </p>
              
              <p>
                &nbsp;
              </p>
              
              <p>
                <em>Value data: = 0</em>
              </p>
              
              <p>
                This will enable the netmasking feature. Besides this disable round robin on the server. Disabling the round robin feature on a server can be done by opening the DNS MMC and getting the properties of the server. Select the <em>Advanced </em>tab and uncheck the <em>Enable round robin </em>option. Restarting DNS maybe necessary to activate the change.
              </p>
              
              <p>
                <a href="https://i0.wp.com/myuclab.nl/wp-content/uploads/2012/11/DNS-properties.jpg"><img class="aligncenter size-medium wp-image-2601" title="DNS properties" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2012/11/DNS-properties-257x300.jpg?resize=257%2C300" alt="" width="257" height="300" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2012/11/DNS-properties.jpg?resize=257%2C300&ssl=1 257w, https://i0.wp.com/myuclab.nl/wp-content/uploads/2012/11/DNS-properties.jpg?w=415&ssl=1 415w" sizes="(max-width: 257px) 100vw, 257px" data-recalc-dims="1" /></a>
              </p>
              
              <p>
                Let’s assume we perform the same action as in the previous example and see what happens:
              </p>
              
              <p>
                <em>Nslookup autodiscover.myuclab.nl</em>
              </p>
              
              <p>
                <em>192.168.3.51<br /> </em><em>192.168.2.51</em>
              </p>
              
              <p>
                Next time you perform the same query you will get the following answer:
              </p>
              
              <p>
                <em>Nslookup autodiscover.myuclab.nl</em>
              </p>
              
              <p>
                <em>192.168.2.51<br /> 192.168.3.51</em>
              </p>
              
              <p>
                So to summarize the configuration part:
              </p>
              
              <ul>
                <li>
                  Disable round robin
                </li>
                <li>
                  Create/modify the registry key
                </li>
                <li>
                  Create the necessary DNS records
                </li>
                <li>
                  Perform some tests from a client to see if it works
                </li>
              </ul>
              
              <p>
                Now we have completed the configuration of the geo DNS server we can continue with configuring Exchange 2013.
              </p>
              
              <p>
                Configuration of the Exchange 2013 environment can be split up in a few parts:
              </p>
              
              <ul>
                <li>
                  Configuring the Database Availability Group (DAG)
                </li>
                <li>
                  Configure the CAS role
                </li>
              </ul>
              
              <p>
                Let’s start with the DAG. Since we only have two Exchange servers we will need to select a third server to act as Witness-server to get quorum in the cluster. In this scenario we have selected DC01 to be the witness-server. Before creating the DAG make sure the <em>Exchange Trusted Subsystem </em>is a member of the <em>administrators</em> group. In production environments it is not recommend to use a DC for this purpose
              </p>
              
              <p>
                In this scenario we have multiple sites which are well connected. But in some scenarios you might have some replication latency. If this is the case pre-stage the Cluster Name Object (CNO). This because else you might see that a second CNO is created which will cause issues.
              </p>
              
              <p>
                Because this is not the case in our scenario we could skip this step but I thought it would be nice to explain how you can create it:
              </p>
              
              <ul>
                <li>
                  Open <em>Active Directory Users and Computers (ADUC)</em>
                </li>
                <li>
                  Browse to the OU which you like to contain the object
                </li>
                <li>
                  Create a new <em>computer </em>account an give it the DAG name as the computername
                </li>
                <li>
                  Disable the computer account
                </li>
                <li>
                  Ensure the <em>advanced </em>options are enabled in ADUC
                </li>
                <li>
                  Get the properties of the computer account
                </li>
                <li>
                  Select the <em>security </em>tab
                </li>
                <li>
                  Add the <em>Exchange Trusted Subsystem </em>security group or the computer account of the first DAG node
                </li>
                <li>
                  Give the group/account <em>full control</em>
                </li>
              </ul>
              
              <p>
                Once the CNO object has been created and replication has occurred we can execute the cmdlet to create the DAG:
              </p>
              
              <p>
                <em>New-DatabaseAvailabilityGroup -Name DAG01 -WitnessServer DC01 -WitnessDirectory C:\DAG01 </em>&#8211;<em>DatabaseAvailabilityGroupIpAddresses 192.168.2.60, 192.168.3.60</em>
              </p>
              
              <p>
                This cmdlet will create a DAG called <em>DAG01 </em>and will configure <em>DC01 </em>to be set as the witness server. During this process the directory and share are created on DC01.
              </p>
              
              <p>
                Now the DAG has been created we can add both servers to the DAG:
              </p>
              
              <p>
                <em>Add-DatabaseAvailabilityGroupServer -Identity DAG01 -MailboxServer EX01</em>
              </p>
              
              <p>
                Followed by:
              </p>
              
              <p>
                <em>Add-DatabaseAvailabilityGroupServer -Identity DAG01 -MailboxServer EX02</em>
              </p>
              
              <p>
                Once these two steps have been performed and both servers are successfully added to the DAG it’s time to configure the additional database copies:
              </p>
              
              <p>
                In our scenario we want to configure the following:
              </p>
              
              <table border="1" cellspacing="0" cellpadding="0">
                <tr>
                  <td valign="top" width="201">
                    <strong>Database</strong>
                  </td>
                  
                  <td valign="top" width="201">
                    <strong>Server</strong>
                  </td>
                  
                  <td valign="top" width="201">
                    <strong>Activation Preference</strong>
                  </td>
                </tr>
                
                <tr>
                  <td valign="top" width="201">
                    MBDB01
                  </td>
                  
                  <td valign="top" width="201">
                    EX01
                  </td>
                  
                  <td valign="top" width="201">
                    1
                  </td>
                </tr>
                
                <tr>
                  <td valign="top" width="201">
                    MBDB01
                  </td>
                  
                  <td valign="top" width="201">
                    EX02
                  </td>
                  
                  <td valign="top" width="201">
                    2
                  </td>
                </tr>
                
                <tr>
                  <td valign="top" width="201">
                    MBDB02
                  </td>
                  
                  <td valign="top" width="201">
                    EX01
                  </td>
                  
                  <td valign="top" width="201">
                    2
                  </td>
                </tr>
                
                <tr>
                  <td valign="top" width="201">
                    MBDB02
                  </td>
                  
                  <td valign="top" width="201">
                    EX02
                  </td>
                  
                  <td valign="top" width="201">
                    1
                  </td>
                </tr>
              </table>
              
              <p>
                To create the configuration as listed above we will use the <em>Exchange Management Shell (EMS)</em>. Configuring the additional database copies can be done by using the <em>Add-MailboxDatabaseCopy </em>cmdlet:
              </p>
              
              <p>
                <em>Add-MailboxDatabaseCopy -Identity MBDB01 -MailboxServer EX02 -ActivationPreference 2</em>
              </p>
              
              <p>
                <em>Add-MailboxDatabaseCopy -Identity MBDB02 -MailboxServer EX01 -ActivationPreference 2</em>
              </p>
              
              <p>
                After running the cmdlet it’s just a matter of time before the seeding process completes. Please verify that the second copy of each database has the status healthy to confirm the process has completed.
              </p>
              
              <p>
                So to summarize the steps above:
              </p>
              
              <ul>
                <li>
                  Create the CNO object
                </li>
                <li>
                  Create the DAG
                </li>
                <li>
                  Add the servers to the DAG
                </li>
                <li>
                  Create the additional database copies
                </li>
              </ul>
              
              <p>
                With this step we have completed the Mailbox role side.
              </p>
              
              <p>
                Here ends the first part of setting up a geo DNS solution in a test lab. In this part we did setup the GEODNS server and had a look at netmasking feature from the DNS server. We finished this part with configuring the Database Availability Group.
              </p>
              
              <p>
                In the next part we will continue with configuring both Client Access Servers and after that it’s time to perform some testing.
              </p>