---
id: 377
title: Add and configure UM language-packs
date: 2008-06-29T20:29:50+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=377
permalink: /add-and-configure-um-language-packs/
categories:
  - Tutorials
---
When you use the UM functionality from Exchange 2007 only the English language pack will be installed by default.

But there are many more UM language packs for example Dutch.

In this tutorial I will describe how you can add and configure the Dutch language pack.

First thing to do is to download the language pack, a complete overview can be found on the following  <a href="http://technet.microsoft.com/nl-nl/exchange/bb330845(en-us).aspx" target="_blank">site</a>.

When the language pack is downloaded we can start installing it. This can be done by executing the following command:

```console
setup.com /AddUmLanguagePack:nl-NL /sourcedir:d:\Downloads\UmLanguagePacks
```
<ul>
	<li><em>setup.com</em>can be foud in the Exchange install directory, when you have installed SP1 you need to use the <em>setup.com</em> of SP1.</li>
	<li>the next parameter is <em>AddUmLanguagePack:nl-NL</em>with this one we tell the setup that we want to install the Dutch language pack. If you want to install German for example then we need to type de-DE, the question is how can you discover this ? The file name of the download has the following syntax umlang-en-AU the last piece of the file name is the piece we need as the parameter to install the language pack.</li>
	<li>the last parameter is used to give the directory where the MSI is located in this case  <em>d:\Download\UMLanguagePacks.</em></li>
</ul>
When the command is executed you will get the following result:

 <a href="https://myuclab.nl/wp-content/uploads/2008/06/install_lgpk.jpg"><img class="alignnone size-thumbnail wp-image-378" title="Install Exchange language pack" src="https://myuclab.nl/wp-content/uploads/2008/06/install_lgpk-150x150.jpg" alt="" width="150" height="150" /></a>

It can take a few minutes before the language pack is installed. When the installation is completed you can start the <em>Exchange Management Console.</em>

Open <em>Organization Configuration -&gt; Unified Messaging</em>

The first thing we need to modify is the <em>dialplan</em> , with this setting we modify the default language for the <em>Subscriber Access</em>. Users can change this via the OWA if they want another language.

Select the <em>UM Dial Plans </em>tab en get the properties of the <em>dialplan</em>. A new window will be opened with a few tabs, choose the tab <em>Settings.</em>

<a href="https://myuclab.nl/wp-content/uploads/2008/06/prop_dp.jpg"><img class="alignnone size-thumbnail wp-image-379" title="UM Dialplan properties" src="https://myuclab.nl/wp-content/uploads/2008/06/prop_dp-150x150.jpg" alt="" width="150" height="150" /></a>

As you can see in the screenshot above the default language is <em>English (United States)</em> . When you click on the arrow you will get a complete overview of all installed languages.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/installed_lg.jpg"><img class="alignnone size-thumbnail wp-image-380" title="Installed languages" src="https://myuclab.nl/wp-content/uploads/2008/06/installed_lg-150x54.jpg" alt="" width="150" height="54" /></a>

When you don't have this options, check if the <em>dialplan</em>  is assigned to the Exchange server. You can check this by looking at the <em>Associated UM Servers </em>column. When this is not configured OK you can't view the installed language.

Select <em>Dutch (Netherlands)</em> from the list to set Dutch as the default language for the <em>Subscriber Access </em>and click <em>OK</em>.

The <em>Subscriber Access</em> is modified, when you use auto attendants you need to modify them also. This can be done via the following steps.

Click on the tab <em>UM AutoAttendants</em> and get the properties of the auto attendant that you want to modify.

 <a href="https://myuclab.nl/wp-content/uploads/2008/06/prop_aa.jpg"><img class="alignnone size-thumbnail wp-image-381" title="Properties AA" src="https://myuclab.nl/wp-content/uploads/2008/06/prop_aa-150x150.jpg" alt="" width="150" height="150" /></a>

A new windows will be opened, click on the tab <em>Features</em> en select the language you want to use.

Earlier we spoke about the option that users can change their default language.  This can be done via the OWA.

<a href="https://myuclab.nl/wp-content/uploads/2008/06/owa.jpg"><img class="alignnone size-thumbnail wp-image-382" title="Outlook Web Access" src="https://myuclab.nl/wp-content/uploads/2008/06/owa-150x150.jpg" alt="" width="150" height="150" /></a>

Let the user login to OWA and select <em>options </em>in the left menu. Next select Regional settings and let the user choose their default language. The list that is displayed to the user is longer then the installed language packs. It can happen that the user selects a language which is not installed which cause that the user will not hear the language he expects.