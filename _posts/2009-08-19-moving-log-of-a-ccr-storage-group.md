---
id: 1306
title: Moving logs of a CCR enabled storage group
date: 2009-08-19T22:29:30+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1306
permalink: /moving-logs-of-a-ccr-storage-group/
categories:
  - Exchange
---
When you would like to change the log path of a normal storage group it's not very hard, but when you want to change the log path of a storage group which is CCR enabled then you will need to do a few more things.

In this tutorial I will explain how you can move the logs from the CCR enabled storage group.

For the first step we will need to open the <em>Exchange Management Console</em>, we will need to disable to log replication temporarily. This can be done by going to the <em>mailbox server </em>via <em>server configuration. </em>Then select the storage group and right click on it, the menu below will be displayed.

 <a href="https://myuclab.nl/wp-content/uploads/2009/08/step-1.jpg"><img title="Suspend Storage Group Copy" src="https://myuclab.nl/wp-content/uploads/2009/08/step-1-150x150.jpg" alt="Suspend Storage Group Copy" width="150" height="150" /></a>

In this menu we select the option <em>Suspend Storage Group Copy, </em>a new screen will be displayed which will let you enter the reason why you suspend the copy, you don't have to fill it in if you don't like it.

<a href="https://myuclab.nl/wp-content/uploads/2009/08/step-2.jpg"><img title="Administrative suspend" src="https://myuclab.nl/wp-content/uploads/2009/08/step-2-150x150.jpg" alt="Administrative suspend" width="150" height="150" /></a>

The status of the CCR will be changed from <em>healthy </em>to <em>suspended.</em>

Now the CCR copy has been disabled temporarily we need to open the <em>Exchange Management Shell </em>to perform the reconfiguration of the log path. This can only be done via the <em>Exchange Management Shell. </em>

<a href="https://myuclab.nl/wp-content/uploads/2009/08/step-3.jpg"><img title="Move storage group logs via Powershell" src="https://myuclab.nl/wp-content/uploads/2009/08/step-3-150x150.jpg" alt="Move storage group logs via Powershell" width="150" height="150" /></a>

By executing the command: <em>move-StorageGroupPath -Identity 'First Storage Group' -LogFolderPath 'E:\Mailbox\SG1' - ConfigurationOnly </em>we specify that we want to change the log path, files must be moved manually because the Powershell command won't do it for you. Two confirmations will be asked, one for the reconfiguration of the log path and the other tells you that all databases within the storage group will be dismounted. Please be aware that the storage group will not be available to users at that moment.

When the command has been executed successfully you will need to move the log files and fileswith the jrs extension manually to their new location. When this is done you can enable the mount the storage group again via the <em>Exchange Management Console </em>by right clicking on it and choose the option mount.

<a href="https://myuclab.nl/wp-content/uploads/2009/08/step-4.jpg"><img title="Mount database" src="https://myuclab.nl/wp-content/uploads/2009/08/step-5-150x123.jpg" alt="Mount database" width="150" height="123" /></a>

When the storage group and databases are mounted again you can enable CCR. This can be done by right clicking on the storage group and select the option <em>Restore Storage Group Copy</em>. After several seconds the status will change to <em>healthy </em>again. When you have a look at the properties of the storage group you will see that the log path has been changed to the new location.

<a href="http://myuclab.nl/wp-content/uploads/2009/08/step-5.jpg"><img title="Log path changed" src="http://myuclab.nl/wp-content/uploads/2009/08/step-6-150x22.jpg" alt="Log path changed" width="150" height="22" /></a>