---
id: 804
title: Messaging Records Management
date: 2008-09-06T17:27:15+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=804
permalink: /Messaging-Records-Management/
categories:
  - Exchange
---
In Exchange 2007 there are a lot of new features which are designed for message retention:</p>
<ul>
<li>Managed Default Folders</li>
<li>Managed Custom Folders</li>
<li>Managed Folder Mailbox Policies</li>
</ul>
<p>Not all features will work in all Outlook versions, some features will only work in Outlook 2003 SP2 or higher and there are a few that only work in Outlook 2007. For a complete overview have a look at the following <a href="http://www.microsoft.com/exchange/evaluation/featurecomparison.mspx" target="_blank">site</a>.</p>
<p>First the tab <em>Managed Default Folders, </em>in the first sight you may say he this are the default folders a user will get in his mailbox. In this case this isn't true, this are the parameters which are used to specify the settings you would like to apply on the standard Outlook folders (inbox, outbox, sent items, etc.). For example it's possible to add a second mailbox to the <em>Managed Default Folders </em>with a longer retention time.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folders.jpg"><img class="alignnone size-thumbnail wp-image-783" title="Managed Default Folders" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folders-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In previous versions of Exchange you could arrange the automatic delection of deleted items by using  <em>Recipient Policies.</em> With all the new laws (especially in the USA) it may be needed to keep mails for a longer time. But doing this manually is a lot of work so why don't let Exchange do it for you. With the<em> Managed Content Settings </em>you can setup things like:</p>
<ul>
<li>move items to deleted items after a specified period</li>
<li>move items to an other folder which is created by <em>Managed</em> <em>Custom Folders</em></li>
<li>delete items but keep the possibility to recover them</li>
<li>permanent delete items</li>
<li>mark items when the retention time has expired</li>
</ul>
<p>But how do we configure this, it's not really hard to do this. You click with your right mouse button on the folder or you choose the option <em>entire mailbox </em>to create one setting that will be applied to the complete mailbox. Next we select the option <em>New Managed Content Settings, </em>you will get the following screen:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content.jpg"><img class="alignnone size-thumbnail wp-image-784" title="Managed Content Settings" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>I think all field descriptions are clear enough but here's a short overview:</p>
<ul>
<li><em>name</em>, name of the <em>Managed Content setting</em></li>
<li><em>message type</em>, on which items does this setting need to be applied.</li>
<li><em>length of retention period</em>, this field needs to be enabled to specify the other settings. When you only would to enable <em>journaling </em>we don't have to enable this option. In the field after this field we can specify the amount of days an item need to be kept.</li>
<li><em>retention period starts</em>, when Exhange checks the items if their retention time is expired what is the start date. This can be the date the item arrives at the mailbox or the date that the item is placed in a specific folder.</li>
<li><em>action to take at the end of the retention period</em>, what needs to be done after the retention time expires.</li>
<li><em>move to the following managed custom folder, </em>this field can only be filled in when the option in the previous version is set to <em>move to a managed custom folder</em></li>
</ul>
<p>When all fields are filled in we click on <em>next</em> and we get the option to enable <em>journaling </em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/journaling.jpg"><img class="alignnone size-thumbnail wp-image-785" title="journaling" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/journaling-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>With journaling we can arrange that from each item in the folder a copy is forwarded to an apart email address. With this we have the option to still have a copy of the message when it is deleted from the original mailbox. This mailbox is in most times not accesible for standard users but for example only accessible for managers.</p>
<p>By placing a checkmark before <em>Forward copies to </em>and select a mailbox which the messages need to be forwarded to we can configure journaling. Besides these two options we can fill in which file-type the original message should have when attached to the journaling message. </p>
<p>When all settings are the way you like click on <em>new</em></p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content_new.jpg"><img class="alignnone size-thumbnail wp-image-786" title="Managed Content Settings new" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content_new-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When all settings are applied with success you will get the following screen:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content_fin.jpg"><img class="alignnone size-thumbnail wp-image-787" title="Managed Content Settings finish" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_content_fin-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>As you can see all settings are applied succesfully and we get a short overview of which Powershell command is used to do this.</p>
<p>When we look at the overview of folders we will see a <em>+ </em>in front of the folder we just created the <em>Managed Content Setting </em>for. When clicking on it you will see the name of it.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/inbox_pol.jpg"><img class="alignnone size-thumbnail wp-image-788" title="Managed Folder Settings inbox" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/inbox_pol-150x33.jpg" alt="" width="150" height="33" /></a></p>
<p>As said earlier all the names on this tab are just parameters and not the folders itself. Lets create an other folder with a longer retention time for example for the mailbox for the management.</p>
<p>We could do this by creating a new <em>Managed Default Folder</em>. This can be done via the menu and selecting the option <em>New Managed Default Folder </em>or right click somewhere in the white space of the tab.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folder_new.jpg"><img class="alignnone size-thumbnail wp-image-796" title="New managed default folder" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folder_new-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In the screenshot above we can specify the following:</p>
<ul>
<li><em>name, </em>name of the parameter</li>
<li><em>default folder type, </em>which type need this parameter  to be</li>
<li><em>display the following comment when the folder is viewed in Outlook, </em>with this option we will display a message.warning to a user. For example we can display the retention time that is active on this folder.</li>
<li><em>do not allow the users to minimize this comment in Outlook, </em>with this option we can prevent that users minimize this message/warning</li>
</ul>
<p>When ready click on the <em>next </em>button to create the new parameter, when this has successfully been completed you will see the following screen:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folder_fin.jpg"><img class="alignnone size-thumbnail wp-image-797" title="New Managed Default Folder" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folder_fin-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When we now have a look at the overview if the tab <em>Managed Default Folders </em>we see the new parameter between the other parameters:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folders_2.jpg"><img class="alignnone size-thumbnail wp-image-798" title="Managed Default Folders" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/default_folders_2-150x37.jpg" alt="" width="150" height="37" /></a></p>
<p>The next tab that we discuss is the <em>Managed Custom Folders </em>with this we can create an extra folder that we want to add to a users mailbox.  This folder will not be created in each mailbox but only to mailboxes from users where the policy has been applied to.</p>
<p>A new folder can be created by:</p>
<ul>
<li>right click in a white part of the tab and select <em>New Managed Custom Folders</em></li>
<li>in the menu in the right side of the screen select <em>New Managed Customer Folder</em></li>
</ul>
When we select this option we will get the following screen:
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom.jpg"><img class="alignnone size-thumbnail wp-image-789" title="New Managed Custom Folder" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Below a description of the fields:</p>
<ul>
<li><em>name, </em>name of the new folder</li>
<li><em>displayed the following name when the folder is viewed in Office Outlook, </em>the name that is displayed in Outlook</li>
<li><em>storage limit (in KB) for this folders and its subfolders</em>, the maximum size of the folder and it's sub-folders.</li>

<li><em>display the following comment when the folder is viewed in Outlook, </em>with this option we will display a message.warning to a user. For example we can display the retention time that is active on this folder.</li>
<li><em>do not allow the users to minimize this comment in Outlook, </em>with this option we can prevent that users minimize this message/warning</li>

<p></em></ul>
<p>When all fields are filled in we click on the <em>next </em>button, the folder is created and after it has been created you will see the following screenshot:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom_fin.jpg"><img class="alignnone size-thumbnail wp-image-790" title="Managed Custom Folder finished" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom_fin-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Next we can click on <em>finish </em>to close the screen. We can now see the new item we just created</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom_fldr.jpg"><img class="alignnone size-thumbnail wp-image-791" title="Managed Customer Folder" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_custom_fldr-150x34.jpg" alt="" width="150" height="34" /></a></p>
<p>When you would like to create <em>Managed Content Settings </em>you can follow the steps as described by the <em>Managed Default Folders</em>.</p>
<p>Now we have created the <em>Custom Folder</em>  we need to create a <em>Managed Folder Mailbox Policy </em>to add it to the users mailbox. You can apply only one policy per user, but the policy can contain multiple folders.</p>
<p>In the right menu select the option <em>New Managed Folder Mailbox Policy </em>to start creating a new policy.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy.jpg"><img class="alignnone size-thumbnail wp-image-793" title="New Managed Folder Policy" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>As you can see above we need to fill in some fields:</p>
<ul>
<li><em>managed folder mailbox policy name, </em>name of the policy</li>
<li><em>specify the managed folders that you want to link to this policy, </em>with this option we can add folders:<a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy_sel.jpg"><img class="alignnone size-thumbnail wp-image-795" title="Managed Folder Policy select folders" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy_sel-150x150.jpg" alt="" width="150" height="150" /></a>This makes it possible to add multiple folders to a mailbox from a user. By pressing the <em>add </em>button we can add a folder to this policy. Besides the <em>custom </em>we can also add the <em>default </em>folders to a user.</li>
</ul>
<p>After completing all settings you can click on the <em>next </em>button. We will see the following screenshot then:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy_fin.jpg"><img class="alignnone size-thumbnail wp-image-794" title="Managed Folder Policy finished" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/managed_folder_policy_fin-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>After completing this step there's only one thing to do, assign the policy to a user.</p>
<p>When we would like to assign it to an existing user we first get the properties of the user and then select the <em>Mailbox Settings </em>tab. As warned on the bottom of the tab you will need an Exchange Enterprise Cal to use Messaging Records Managment.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/mrm.jpg"><img class="alignnone size-thumbnail wp-image-799" title="Tab Mailbox Settings" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/mrm-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Next we select <em>Messaging Records Management </em>and click the button<em> properties</em>.</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/mrm_settings.jpg"><img class="alignnone size-thumbnail wp-image-800" title="Messaging Records Management properties" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/mrm_settings-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>You can specify a few things here:</p>
<ul>
<li> <em>managed folder mailbox policy, </em>here we select the policy which we want to apply to the user</li>
<li><em>enable retention hold for items in this mailbox</em>, with this option we can exclude the mailbox from a user for a specified time</li>
</ul>
<p>When you want to assign a policy to a new user you will find the <em>Managed Folder Mailbox Policy </em>on the screen of the 4th step:</p>
<p><a href="https://johanveldhuis.nl/wp-content/uploads/2008/09/newuser.jpg"><img class="alignnone size-thumbnail wp-image-801" title="Managed Folder Mailbox Policy new user" src="https://johanveldhuis.nl/wp-content/uploads/2008/09/newuser-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>By placing a checkmark before <em>Managed Folder Mailbox Policy</em>  and select the policy we can assign it to a user directly.</p>
<p>When you compare the options to the ones that were available in Exchange 2003 you will find out that it are a lot of more options. Keep in mind when implementing this it will have an effect on the storage capacity you will need to have available.