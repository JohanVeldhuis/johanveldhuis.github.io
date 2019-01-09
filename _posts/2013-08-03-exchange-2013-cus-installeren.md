---
id: 3220
title: 'Deploy Exchange 2013 CU&#8217;s'
date: 2013-08-03T12:04:11+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3220
permalink: /exchange-2013-cus-installeren/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2013
---
This weeks the second version of the second cumulative update has been released for Exchange 2013. As you may already know Microsoft has changed his update process completely with the introduction of Exchange 2013. No more rollups and only cumulative updates (CU’s).

A pretty big change as the CU’s require you to make changes to the AD also as step of the update process. For those not familiar with rollups of Exchange 2010, the rollups where just bit updates and did not include AD changes. In Exchange 2010 the AD changes where only included in service packs.

CU’s are a complete install of Exchange 2013. So if you plan to install Exchange 2013 in the future you will only need to install the latest CU and you’re done.

But what has changed from deployment standpoint? Well pretty much because we now have to think of the Managed Availability feature of Exchange 2013. This feature will continually monitor the environment and takes action if necessary.

You can compare it with placing a node in maintenance mode in a load balancer. Although with placing a node in maintenance mode in a load balancer only ensures that it doesn’t offer any traffic anymore to the specific server.

Managed availability goes steps further, it can do this because the monitors contain knowledge about the product something load balancers don’t have.

For changing the status of the components on a server you will need to use the _Set-ServerComponentState_ cmdlet. Using this cmdlet with the necessary parameters you can influence the components of a server.

Which components are active on a server depends on which roles are deployed to  server. To find out which components are available on a server you can run _Get-ServerComponentState_. In the example below you will see an output example of a multi-role Exchange 2013 server:

[<img alt="get-servercomponentstate" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-300x122.png?resize=300%2C122" width="300" height="122" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate.png)

As you can see all components are up and running. Let’s assume that we have prepared our AD and are now ready to deploy the bits on our Exchange 2013 servers.

Our environment consists of two Exchange 2013 multirole servers. A third server is used as the File Share Witness (FSW) to maintain quorum.

[<img alt="get-servercomponentstate serverwideoffline" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline-300x124.png?resize=300%2C124" width="300" height="124" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline.png)

The first step will me to ensure that the transport queues will be empty before continuing the process. Using the S_et-ServerComponentState_ cmdlet we can set the status of a component. Besides the status we will need to provide the requestor. In this case the requestor we are going to use is _maintenance._

_Set-ServerComponentState –identity ex02 –component –state draining –requestor  maintenance[<img alt="get-servercomponentstate serverwideoffline" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline-300x124.png?resize=300%2C124" width="300" height="124" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline.png)_

[<img alt="hub_draining" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/hub_draining-300x15.png?resize=300%2C15" width="300" height="15" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/hub_draining.png)

By using the cmdlet above we will put the transport component in draining state. This means it will take care of the messages which are currently in the queue but will not accept any new messages.

You can speed up the process by moving the messages to a transport component hosted on another server. To do this you will need to use the _move-messages_ cmdlet:

_Redirect-Messages -server ex02 –targetserver ex01.corp.local_

[<img alt="redirect-message" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/redirect-message-300x45.png?resize=300%2C45" width="300" height="45" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/redirect-message.png)

To check if the queues are empty we can use the good old _get-queue_ cmdlet:

_Get-Queue –server ex02_

[<img alt="queue" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/queue-300x27.png?resize=300%2C27" width="300" height="27" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/queue.png)

If all queues are clean we can continue with disabling all the other components which are active on the server:

_Set-ServerComponentState –identity ex02 –component serverwideoffline –state inactive –requestor maintenance_

[<img alt="set-servcomponentstat serverwideoffline restore hub" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore-hub-300x9.png?resize=300%2C9" width="300" height="9" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore-hub.png)

To verify if all components are set to the status inactive we could run the _Get-ServerComponentState_ cmdlet again:

[<img alt="get-servercomponentstate serverwideoffline" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline-300x124.png?resize=300%2C124" width="300" height="124" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate-serverwideoffline.png)

Now all components are inactive it’s time to handle the database availability group (DAG) part.

There are a two ways to put a DAG member in maintenance mode. Those who are familiar with Exchange 2010 will remember the s_tart-dagmaintenance_ script which will help you in putting s DAG member in maintenance model Well good news the script is still available and can be found in the same location as in Exchange 2010, the Exchange scripting directory.

Another method to put  DAG member in maintenance mode is to set the status of the cluster component using the _Suspend-ClusterNode,_ for example:

_Suspend-ClusterNode_

[<img alt="suspend-clusternode" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/suspend-clusternode-300x56.png?resize=300%2C56" width="300" height="56" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/suspend-clusternode.png)

Once the cluster node has been stopped you will need to prevent the databases from being moved d on the member:

_Set-MailboxServer  -Identity ex02-DatabaseCopyActivationDisabledAndMoveNow $trueSet-MailboxServer  -DatabaseCopyAutoActivationPolicy Blocked_ 

[<img alt="set-mailboxserver activation" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-mailboxserver-activation-300x11.png?resize=300%2C11" width="300" height="11" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-mailboxserver-activation.png)

And as final step we want to set the auto activation policy temporarily to blocked:

_Set-MailboxServer  -Identity ex02 -DatabaseCopyAutoActivationPolicy Blocked_

Now all prerequired steps have been taken it is time to kick of the setup. In this blog we will use the cmdline to update our Exchange 2013 server. To update the server start the setup using the following parameters:

_Setup.exe /m:upgrade /IacceptExchangeServerLicensing_

This will start the upgrade to CU2 as you can see below:

[<img alt="setup.exe /m:upgrade" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/accept-license-300x15.png?resize=300%2C15" width="300" height="15" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/accept-license.png)

Once the setup has finished you might decide to reboot the server. Once the server is back online it is time to restore the services.

To restore the services we will need need to perform the steps mentioned earlier only then in reverse order.

So we will start with putting the DAG member back online:

First we will make the DAG member and active of part of the cluster again:

_Resume-ClusterNode_

Once this has been done we need to remove the limits for database failovers which we configured earlier:

_Set-MailboxServer  -Identity ex02-DatabaseCopyActivationDisabledAndMoveNow $trueSet-MailboxServer  -DatabaseCopyAutoActivationPolicy Blocked_

_Set-MailboxServer  -Identity ex02 -DatabaseCopyAutoActivationPolicy Blocked_

[<img alt="resume-clusternode" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/resume-clusternode-300x45.png?resize=300%2C45" width="300" height="45" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/resume-clusternode.png)

Now our DAG member is back online we need to change the component states to active:

_Set-ServerComponentStatus –identity ex02 –component serverwideoffline –status active –requestor maintenance_

[<img alt="set-servcomponentstat serverwideoffline restore" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore-300x22.png?resize=300%2C22" width="300" height="22" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore.png)

When running the _Get-ServerComponentStatus_ cmdlet you will see that the status of the transport component is still _draining_.

To stop the draining process for the transport component we will need to run the _Set-ServerComponentStatus_ cmdlet again only using a different _action_ parameter:

_Set-ServerComponentStatus –identity ex02 –component transport –status active –requestor maintenance_

[<img alt="set-servcomponentstat serverwideoffline restore hub" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore-hub1-300x9.png?resize=300%2C9" width="300" height="9" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/set-servcomponentstat-serverwideoffline-restore-hub1.png)

Now when running the _Get-ServerComponent_ cmdlet again the status of each component should show _active._

[<img alt="get-servercomponentstate_fullrestore" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate_fullrestore-300x143.png?resize=300%2C143" width="300" height="143" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2013/07/get-servercomponentstate_fullrestore.png)

Here ends the blog about how to install a CU on an Exchange 2013 server. If you hate to type the cmdlets manually then have a look at this script from Michael van Hoorenbeeck:

Micheals script: <a href="http://michaelvh.wordpress.com/2013/04/08/script-putting-exchange-server-2013-into-maintenance-mode/" target="_blank">open</a>

The script will perform the same cmdlets only with less typing for your and will simplify the proces of putting a server in maintenance and restore the services again.