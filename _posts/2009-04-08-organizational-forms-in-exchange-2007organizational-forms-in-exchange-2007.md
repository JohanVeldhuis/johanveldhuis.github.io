---
id: 1168
title: Organizational forms in Exchange 2007
date: 2009-04-08T22:38:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1168
permalink: /organizational-forms-in-exchange-2007/
categories:
  - Exchange
---
Organizational forms were used in Exchange 2003 by several applications and were very easy to implement. In Exchange 2007 this is a bit more complicated to configure organizational forms.

In this tutorial I will explain how you can configure organizational forms inExchange 2007. Before we start make sure you have the software mentioned below:

<a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=55FDFFD7-1878-4637-9808-1E21ABB3AE37&amp;displaylang=en" target="_blank">MFCMapi</a>

The first step is to create the organization forms library, this can be done via Powershell by using the command below:

```PowerShell
New-PublicFolder -Path "\NON_IPM_SUBTREE\EFORMS REGISTRY" -Name "My Organizational Forms Library"
```

When the library has been succesfully created you will see the same result as below

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step1.jpg"><img class="size-thumbnail wp-image-1151 alignnone" title="Organizational forms library" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step1-150x150.jpg" alt="Organizational forms library" width="150" height="150" /></a>

When it is created you can see the folder by using the Public Folder Management Console from Exchange 2007. The folder is created in the Systen Public Folders

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step2.jpg"><img class="size-thumbnail wp-image-1152 alignnone" title="System Public Folders" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step2-150x82.jpg" alt="System Public Folders" width="150" height="82" /></a>

When this has succeeded we can start using MFCmapi to continue the configuration.

Start MFCmapi and when asked create a new profile of select an existing one. When logged in with the profile select the <em>session </em>menu and choose the option <em>Logon and Display Store Table. </em>You will see something like below

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step3.jpg"><img class="size-thumbnail wp-image-1153 alignnone" title="Store table" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step3-150x83.jpg" alt="Store table" width="150" height="83" /></a>

Select the menu <em>MDB </em>and choose the option <em>Open Public Folder Store </em>and select <em>OK</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step4.jpg"><img class="size-thumbnail wp-image-1154 alignnone" title="MDB menu" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step4-150x150.jpg" alt="MDB menu" width="150" height="150" /></a>

 <a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step5.jpg"><img class="size-thumbnail wp-image-1155 alignnone" title="Use admin privileges" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step5-150x105.jpg" alt="Use admin privileges" width="150" height="105" /></a>

An overview of the <em>Public Folder Store table </em>will be displayed<em>. </em>Open the following folders <em>Public Root, NON_IPM_SUBTREE, EFORMS REGISTRY </em>and select the organizational forms library just created. In this case <em>My Organizational Forms Library.</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step6.jpg"><img class="size-thumbnail wp-image-1156 alignnone" title="Public Folder Store table" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step6-150x129.jpg" alt="Public Folder Store table" width="150" height="129" /></a>

When you have selected the correct folder you will need to find the value <em>PR_URL_NAME </em>in the right side of the screen called <em>property name(s). </em>Select the value and choose the menu <em>property pane </em>and choose the option <em>modify extra properties</em>.

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step7.jpg"><img class="size-thumbnail wp-image-1157 alignnone" title="Modify Extra Properties" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step7-150x150.jpg" alt="Modify Extra Properties" width="150" height="150" /></a>

A new window will be opened, select the button  <em>select property tag</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step8.jpg"><img class="size-thumbnail wp-image-1158 alignnone" title="Select Property tag" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step8-150x28.jpg" alt="Select Property tag" width="150" height="28" /></a>

A new window will be opened again, this windows will contain a long list of <em>properties </em>which can be added. Search for the <em>property PR_EFORMS_LOCAL_ID </em>and choose <em>OK.</em>

Click on the <em>OK </em>button again and startsearching for the <em>property PR_EFORMS_LOCAL_ID</em>, a red cross will be displayed in front of it. Doubleclick on the <em>property, </em>a new window will be opened

<a href="https://johanveldhuis.nl/wp-content/uploads/2009/04/step9.jpg"><img class="size-thumbnail wp-image-1159 alignnone" title="Property Editor" src="https://johanveldhuis.nl/wp-content/uploads/2009/04/step10-150x150.jpg" alt="Property Editor" width="150" height="150" /></a>

In the field <em>unsigned decimal </em>fill in the value of the language the forms library will be used for. In this case English, for a full overview of all languages have a look at the following  <a href="http://msdn2.microsoft.com/en-us/library/aa579489.aspx" target="_blank">page</a> .

Close MFCmapi, the only thing we need to do is specify the permissions on the forms, this can be done with the commands  <em>Add-PublicFolderPermission and</em> <em>Add-PublicFolderAdministrativePermission.</em>

First we will specify the client permissions:

```PowerShell
Add-PublicFolderClientPermission
```
Supply values for the following parameters:

User: domain\Johan
AccessRights[0]: FolderVisible
AccessRights[1]: ReadItems
AccessRights[2]:
Identity: \NON_IPM_SUBTREE\EFORMS REGISTRY\My Organizational Forms Library

The command above will give the user Johan the permissions to view the folders and read the content of them. This can be done per user or per group, simply replace the username by the groupname.

Next step is specifying the administrative permissions:

```PowerShell
Add-PublicFolderAdministrativePermission
```
Supply values for the following parameters:

Identity: \NON_IPM_SUBTREE\EFORMS REGISTRY\My Organizational Forms Library
User: domain\domain admins
AccessRights[0]: AllExtendedRights
AccessRights[1]:

This will ensure that all users that are a member of the domains admins group have all rights on the folder.

For more information on permissions on Public Folders have a look at the sites below.

<a href="http://technet.microsoft.com/en-us/library/aa997986.aspx" target="_blank">Add-PublicFolderPermission
Add-PublicFolderAdministrativePermission</a>