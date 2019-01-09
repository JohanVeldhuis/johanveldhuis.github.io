---
id: 2279
title: Usefull scripts for use during an Exchange 2010 migration
date: 2011-07-13T20:16:48+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2279
permalink: /handige-scripts-voor-tijdens-een-exchange-2010-migratie/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
Some times it can be very usefull to automate things by creating a script. Of course you will first have to think if it is usefull to automate it or just decide to do it manually. Which option you chose is really hard to say but let&#8217;s say if you have to modify more then 50 items becomes very interested to use a script.

Exchange 2010 contains a few scripts, for example a script which let&#8217;s you configure Public Folder replica&#8217;s during a migration. All scripts can be found in the _scripts_ directory. This directory can be found in the Exchange installation directory, for example  _c:\Program Files\Microsoft\Exchange Server\V14\Scripts_.

When you have opened the Exchange Management Shell (EMS) you can browse to it by typing _cd $exscripts_.

Here you will find a lot of scripts among them:

[table id=23 /]

Besides these scripts a lot of ready-to-use scripts are offered by Microsoft and other bloggers. Personally I like the following two scripts:

  * fix-alias.ps1
  * ConvertFrom-LdapFilter.ps1

<div>
  The first script can be used to fix aliases of mailboxes, mailcontacts and Public Folders. In some cases you will find that users might have an alias which contains incorrect characters. Starting from Exchange 2007 this isn&#8217;t allowed anymore. When you ignore this error you may see strange issues such as users dissapearing fromt the addresslist.
</div>

<div>
  To prevent this kind of issues Microsoft has published a script. The script will give you the ability to search for specific characters and replace them. For example assume all aliasses will end with domain.com. By usinfg the fix-alias script using the following parameters domaim.com will be replaced by nothing:
</div>

<div>
   
</div>

<div>
  <em>fix-alias.ps1 -type mailbox -search &#8220;domein.com&#8221; -replace &#8220;&#8221;</em>
</div>

<div>
  <em></em> 
</div>

<div>
  The script has one limitation it can&#8217;t fix two errors. So if an allias contains an @ and a space the script will generate an error.
</div>

<div>
   
</div>

<div>
  The second script is really usefull when you are migrating address lists or recipient policies. Normally you will have to manually rebuild both and convert the LDAP filter to an OPATH filter. When you will do this on a regular basis this will not be an issue but in most cases this is not what you do daily. In that case we can migrate them automatically by using the <em>ConvertFrom-LdapFilter </em>script. For example let&#8217;s say we have a recipient filter which is called support. This recipient policy will be applied to all employees of the support department and will add an e-mail address using the following domain support.domain.com. To convert this policy we can use the script as follows:
</div>

<div>
  <em></em> 
</div>

<div>
  <em>Set-EmailAddresspolicy Support -RecipientFilter (.\ConvertFrom-LdapFilter.ps1 $.LdapRecipientFilter)</em>
</div>

<div>
   
</div>

<div>
  As you can see there are enough scripts which can help you during a migration. The scripts mentioned above can be downloaded from the sites below:
</div>

<div>
   
</div>

<div>
  <a href="http://gallery.technet.microsoft.com/scriptcenter/411aec4e-8c01-4594-b993-fbd968f15399" target="_blank">Fix-Alias</a>
</div>

<div>
  <a href="http://gallery.technet.microsoft.com/scriptcenter/7c04b866-f83d-4b34-98ec-f944811dd48d" target="_blank">ConvertFrom-LdapFilter</a>
</div>