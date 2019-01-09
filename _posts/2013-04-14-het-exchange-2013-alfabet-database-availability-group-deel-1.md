---
id: 2749
title: 'The Exchange 2013 alphabet: Database Availability Group &#8211; part 1'
date: 2013-04-14T21:57:48+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2749
permalink: /het-exchange-2013-alfabet-database-availability-group-deel-1/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_Multi_AD_sites.jpg&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2013
---
In an earlier blog we had a brief look at the Database availability Group (DAG) of Exchange 2013. In this blog we will have a closer look how it works and how you can create it.

The DAG functionality was introduced in Exchange 2010 to replace all the other cluster methods Exchange 2007 contained. Using a DAG it is possible to create multiple copies of a database within the DAG. This is limited to 16 copies per database which I personally have never seen during implementations.

Database Copies can have several statuses which are displayed in the table below:

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="312">
      <b>Status</b>
    </td>
    
    <td valign="top" width="312">
      <b>Description</b>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Active
    </td>
    
    <td valign="top" width="312">
      The database is active on the specific server and handles requests
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Mounted (passive)
    </td>
    
    <td valign="top" width="312">
      The database is in sync and waits till it needs to come in action
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Failed
    </td>
    
    <td valign="top" width="312">
      The database copy is in failed state and might require a full reseed
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="312">
      Suspended
    </td>
    
    <td valign="top" width="312">
      The database copy has been suspended and new logs will not be replayed
    </td>
  </tr>
</table>

When looking under the hood of the DAG you will discover that is uses windows clustering. These components are automatically installed when adding a server to a DAG. One import remark that must be made is that this requires an enterprise edition when deployed on Windows 2008 R2.  For Windows 2012 is doesn’t matter anymore because the failover feature is available in both standard and datacenter. Although it uses the failover feature of the OS it is not recommend to make changes via the failover cluster manager.

Within the DAG one server has the primary active manager (PAM). This server will make the decisions which copies are active and passive. When an issue occurs with the active copy the PAM is responsible for getting the topology change notifications and reacting to the failure. The server which hosts the PAM is always the owner of the cluster quorum group. If the server hosting the PAM will fail it will automatically failover to one of the DAG members who has survived.

Besides the PAM role there is an additional role called the standalone active manager (SAM). This role is active on all servers within the DAG but on the server which contains the PAM role the PAM will perform the actions of the SAM. The SAM role is responsible for detecting local database and local Information Store failures and acting on actions initiated by the PAM.

As you may have noticed we talked about the quorum. This is pretty important to understand. If you are familiar with clustering this must sound familiar to you. Because the DAG is a kind of clustering it also uses quorum to prevent issues like split-brain. In a DAG there are two options for this. Either implement an odd amount of DAG members, for example 3. Or decide to implement a Failover Witness Share. In this last case a shared folder is created on another server which is not a part of the DAG. For example if you have two DAG members we will need to add the failover witness share to get quorum.

To calculate how many at least need to be online to we can use the following formula (n / 2) + 1 where n is the number of DAG nodes within the DAG. For example we have 3 DAG members which makes (3/2) +1=2.5. Since halves do not count we need to round this down to 2. This means that at least 2 members will need to be online to leave the DAG running.  Members can be either the mailbox servers or a mix of one mailbox server and the server containing the FSW. Another example, let’s say we have 6 DAG members which makes (6/2)+1=4 which is equal. In this case at least 4 members of the DAG will need to be online.

We already talked about the multiple copies of a database but how does this work? Well each copy of a database has an activation preference. The initial database gets an activation preference of 1. All additional copies will get a unique ID assigned. For example the second copy gets 2 as activation preference etc. This preference is used as one of the parameters when the PAM needs to select a copy which needs to be activated if a failover is initiated.

**Some examples**

OK enough theory let’s have a look at some examples. The easiest example is a DAG within a datacenter which contains 3 multirole Exchange 2013 servers. Each server contains a copy of each database. The preferences of the databases have been configured in a way that during normal operation each server will only host one active copy:

[<img class="alignnone size-medium wp-image-3142" alt="DAG_3_Members_One_AD_Site" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_One_AD_Site1-300x277.jpg?resize=300%2C277" width="300" height="277" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_One_AD_Site1.jpg?resize=300%2C277&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_One_AD_Site1.jpg?w=484&ssl=1 484w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_One_AD_Site1.jpg)

Let’s assume one of the nodes has an issue and would need to be taken down for maintenance. No problem just put the node in maintenance and the PAM will ensure the database will be moved to another server.

After the maintenance has been performed on the server just stop the maintenance. The other servers will see that the node is back and will ensure the copies hosted on the server will be brought up-to-date. A manual action however is needed to move the database originally active on this server.

In the next example we will have our DAG members spread across two different datacenters. Each datacenter is defined as an AD site. We are still having 3 multirole servers in our Exchange 2013 environment. The only difference with the first example is that two of them are located in the primary datacenter and the third one in the secondary datacenter. The second data center is used for disaster recovery purposes:

[<img class="alignnone size-medium wp-image-3143" alt="DAG_3_Members_Multi_AD_sites" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_Multi_AD_sites-300x206.jpg?resize=300%2C206" width="300" height="206" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_Multi_AD_sites.jpg?resize=300%2C206&ssl=1 300w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_Multi_AD_sites.jpg?w=493&ssl=1 493w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/04/DAG_3_Members_Multi_AD_sites.jpg)

Let’s assume the WAN link goes down in this scenario. Think of the formula what do you think will happen? Right the users can access their mailbox. Let’s use the formula (3/2)+1 = 2.5 which can be rounded down to 2. Which means at least two mailbox servers of a combination of one FSW and one mailbox server should be online. But if the complete primary data center burns down we will need to follow the procedure as described next.

A DAG can be either created within one AD Site or across two AD sites. In this last case it is pretty important in which site you locate the file share witness (FSW). In most cases this will be the site which you want to survive which might be primary site. In this case if the WAN link between the two sites goes down the site containing the quorum will survive. To bring the DR site online again we will need to introduce an alternate FSW and then bring the DAG online again.

Here ends the first part of the blog about database availability groups. In this article we looked at the theory behind the DAG and looked at some example configurations. In part two we will start building a DAG.