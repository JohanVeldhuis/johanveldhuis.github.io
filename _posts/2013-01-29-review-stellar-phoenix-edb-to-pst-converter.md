---
id: 2679
title: 'Review: Stellar Phoenix EDB to PST converter'
date: 2013-01-29T09:51:47+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2679
permalink: /review-stellar-phoenix-edb-to-pst-converter/
categories:
  - Reviews
---
<span style="font-size: 13px; line-height: 19px;">In this blog we will have a look at the EDB to PST converter from Stellar Phoenix. As the name already tells you the tool can be used to export EDB content to PST format.</span>

Nothing new you might think, Exchange 2010 already includes this ability using the _New-MailboxExportRequest._ Well the tool has got a nice option called _Convert Offline EDB to PST_. Using this option you are able to export content from an EDB file to PST. In some scenarios this may be really useful. Think of the scenario where the server is completely dead and the only thing you have is the EDB file. In this scenario you can use the tool from Stellar Phoenix to export all data to a PST and the import it on the new Exchange server again.

Currently the tool can be used against Exchange 5.5, 2000, 2003, 2007 and 2010. Support for 2013 will be included in a future version. The system requirements for the tool are as follows:

  * Windows XP, Vista, 7 and 2003
  * Microsoft Office (both 32 and 64-bit), at this moment no support for Office 2013

When looking at the system requirements you can see there is some work to do to get the tool certified for more modern operating systems en Office versions.

So let’s have a look at how the tool works:

Once you have selected option convert and offline EDB to PST you will have to provide two parameters:

  * The EDB file
  * The version of Exchange

Once these two parameters have been provided the tool will read the content of the EDB. This may take a while depending on the amount of mailboxes which are located in the DB. For a database of 1 GB it took just a few seconds till the overview of mailboxes was displayed. This was including the folders that were placed in the mailbox:

[<img class="aligncenter size-medium wp-image-2680" title="Mailstore content" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailstore-content-300x163.png?resize=300%2C163" alt="" width="300" height="163" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailstore-content.png?resize=300%2C163&ssl=1 300w, https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailstore-content.png?w=376&ssl=1 376w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailstore-content.png)

Selecting a folder will cause the tool to load all the items which are located in the folder. One of the nice features of the tool is a preview of the content of the folder content as you can see in the screenshot below. If you select one of the items event the content of the message including attachments will be displayed.

[<img class="aligncenter size-medium wp-image-2682" title="Mailbox content" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailbox-content-300x66.png?resize=300%2C66" alt="" width="300" height="66" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailbox-content.png?resize=300%2C66&ssl=1 300w, https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailbox-content.png?w=707&ssl=1 707w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Mailbox-content.png)

This option gives you the ability to check the content of the EDB first before exporting it to PST. Another reason why this feature may be useful if you just want to export a specific message and not the complete content.

Exporting an item or a complete mailbox can be performed by pressing this symbol in the toolbar:

[<img class="aligncenter size-full wp-image-2681" title="Save icon" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Save-icon.png?resize=59%2C57" alt="" width="59" height="57" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2013/01/Save-icon.png)

This will launch a window where you have to provide a location where the PST folders can be stored. The PST file will get the name of the mailbox. So for example if you export a mailbox called Johan the PST will be named Johan.pst

During the process a progress bar is being viewed which displays:

  * Which mailbox is currently processed
  * The folder which is currently processed
  * The amount of items being recovered

[<img class="aligncenter size-medium wp-image-2683" title="Progress" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Progress-300x126.png?resize=300%2C126" alt="" width="300" height="126" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Progress.png?resize=300%2C126&ssl=1 300w, https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Progress.png?w=569&ssl=1 569w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2013/01/Progress.png)

Besides exporting a mailbox or message to PST the tool has the ability to export single messages to the .MSG or .EML format.

As an additional software package a server console is available. Using this tool you can easily set and remove full mailbox access on mailboxes. This is necessary to access a mailbox with the tool. For the older versions of Exchange I can imagine that this is a nice addition. But for Exchange 2007 and newer most admins will probably choose to set the full mailbox access via the Exchange Management Shell.

To summarize my experiences with the tool: it’s a nice tool which can be really useful in several scenarios. Personally I think that they would need to do something about the supported operating systems as Windows 2008 and Windows 2008 R2 are still not supported. The progress bar used for displaying the progress of an export works OK but it is not really useful. The reason for this is that it doesn’t display the progress for the complete process. I’ve talked to Stellar Phoenix about the support for Exchange 2013 and Outlook 2013 and they have told me that they will have support for this in the first half of 2013.

If you would like to have a look at the tool yourself you can download a trial from the site below:

<http://edbtopstconverter.stellarservertools.com/>