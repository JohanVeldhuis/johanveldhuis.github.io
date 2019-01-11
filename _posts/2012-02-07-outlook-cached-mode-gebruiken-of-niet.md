---
id: 2411
title: Use Outlook cached mode or not?
date: 2012-02-07T21:25:43+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2411
permalink: /outlook-cached-mode-gebruiken-of-niet/
categories:
  - Exchange
---
**<span style="font-size: small;"><span style="font-family: Calibri;">Use Outlook cached mode or not?</span></span>**

<span style="font-size: small;"><span style="font-family: Calibri;">Since Outlook 2003 it is possible to run Outlook in two modes:</span></span>

  * <span style="font-size: small; font-family: Calibri;">Online mode</span>
  * <span style="font-size: small; font-family: Calibri;">Cached Exchange mode</span>

<span style="font-size: small;"><span style="font-family: Calibri;">But what are the differences between those modes?</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>Online mode<br /> </strong>When the Outlook profile is configured in Online Mode Outlook will create a direct connection to the Information Store of Exchange. This has as advantage that messages will appear almost immidiatly when delivered to the mailbox. When the connection to the Exchange server is not available you don’t have access to the mailbox.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>Cached Exchange mode<br /> </strong>When the Outlook profile is configured in Cached Exchange mode a local cache file will be created from the mailbox. This file is also known as the offline data file which can be recognized easily when looking at the extension which is OST. By default the file is stored in <em>Local Settings\Application Data\Microsoft\Outlook.</em> When looking at the size of the OST you will see the size is different than the size of the mailbox.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">An OST file can be 50 to 80 percent bigger than the mailbox. The cause of this is the method which is being used to store items. Outlook does use a less efficient way then Exchange Server.  </span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">The maximum size of the OST is differs per type:</span></span>

  * <span style="font-size: small;"><span style="font-family: Calibri;">Non-Unicode (ANSI): maximum 2 GB;</span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Unicode: maximum size is configurable, default 50 GB;</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">Which type is used can be discovered by using the following steps:</span></span>

  * <span style="font-size: small;"><span style="font-family: Calibri;">Select <strong>Tools;</strong></span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Select the option <strong>E-mail accounts;</strong></span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Select the <strong>Exchange e-mail account </strong>and press the <strong>change </strong>button;</span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Select <strong>More Settings;</strong></span></span>
  * <span style="font-size: small; font-family: Calibri;">Select the <strong>Advanced </strong>tab</span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Check the value of <strong>Mailbox Mode</strong>;</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">Besides the OST file a user in Cached Exchange Mode also uses Offline Address Book (OAB). </span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">The advantage of Cached Exchange Mode is that mailbox content is also available when you don’t have a connection to Exchange, excluded the new items which haven’t been cached. When connected to Exchange messages will arrive with a slight delay in the mailbox. This is caused by Outlook which will check for new messages every 30 seconds by default. A disadvantage of Cached Exchange Mode that the OST file is only cached locally. When a user is working on another workstation a new OST file will be generated if not available.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">Starting from Outlook 2010 Microsoft recommends to use Cached Exchange Mode. When the autodiscover functionality of Exchange is being used you will see that the Cached Exchange Mode will be enabled by default.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">In environments with a limited bandwidth (slow connection) you can choose to only download the e0mail headers and the First 256 characters of a message.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">When the speed of a network connection is 128 KB or less a connection is stamped as slow connection. </span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">The amount of RPC requests, compared with Online mode, is less. This because the local cache on the workstation is being used.  The influence of the harddisk from the workstation is bigger.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>What is being cached?<br /> </strong>When using Outlook 2010 by default both the user mailbox and additional mailboxes are added to the cache. The Public Folder is not stored in the cache. It is possible to add Public Folder favorites to the cache but in this case you will need to enable the option manually or via a GPO.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">As mentioned earlier Outlook will use an Offline Address Book (OAB). Initially a complete download is being performed of the address book. After that only incremental updates are downloaded from the address book. The OAB is being downloaded once every 24 hours if the OAB contains new data.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>When shouldn’t you use Cached Mode?<br /> </strong>But are there scenario’s where you don’t want to use Cached Exchange mode?<strong></strong></span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">Yes there are, below an overview of these scenario’s:</span></span>

  * <span style="font-size: small;"><span style="font-family: Calibri;">Computers which are being used by multiple people and where a delay of downloading the new messages is not acceptable;</span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Environments where compliance and security rules which prohibits the store of data locally; </span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">The complete cached file can’t be stored because of lack due to disk space;</span></span>
  * <span style="font-size: small; font-family: Calibri;">Mailboxes greater then 25 GB;</span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Virtual or Remote Desktop Service environments where Outlook 2007 and Outlook 2003 is installed. Cached Exchange Mode isn’t supported on a system which offers  Remote Desktop Services;</span></span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Virtual or Remote Desktop Service environments where Outlook 2010 is used but not enough disk space or I/O’s are available;</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>Impact of Cached Exchange Mode on Outlook functionalities<br /> </strong>Besides the earlier called scenarios there are some additional functionalities which are influenced when using Outlook in Cached Exchange Mode. Below an overview of the functionalities:</span></span>

  * <span style="font-size: small; font-family: Calibri;">Delegate mailbox data stores;</span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Shared Folders which are not made available offline;</span></span>
  * <span style="font-size: small; font-family: Calibri;">Retrieve Free/Busy information;</span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Configure/change/disable Out-Of-Office;</span></span>
  * <span style="font-size: small; font-family: Calibri;">Access to Public Folders;</span>
  * <span style="font-size: small; font-family: Calibri;">Retrieving IRM messages;</span>
  * <span style="font-size: small; font-family: Calibri;">Changing rules;</span>
  * <span style="font-size: small; font-family: Calibri;">Retrieving MailTips;</span>

<span style="font-size: small;"><span style="font-family: Calibri;">These functions require a connection to the Exchange environment. When there is no connection this functions are not available. If there is a connection with the Exchange Server it can happen that these functions are working slower then normally. This is only the case when connecting via a connection with a high latency.</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;">Besides the earlier called functionalities there are a few functions which Microsoft doesn’t recommend to use:</span></span>

  * <span style="font-size: small;"><span style="font-family: Calibri;">Using the toast alert function with digitale signatures;</span></span>
  * <span style="font-size: small; font-family: Calibri;">Multiple address book containers;</span>
  * <span style="font-size: small;"><span style="font-family: Calibri;">Custom properties on the General tab;</span></span>

<span style="font-size: small;"><span style="font-family: Calibri;"><strong>Influance of large .ost files<br /> </strong>Large ost files can cause performance issues in Outlook. Users can recognize this because Outlook doesn’t respond correctly. This can happen if one of the following tasks is being performed:</span></span>

  * <span style="font-size: small; font-family: Calibri;">Reading messages;</span>
  * <span style="font-size: small; font-family: Calibri;">Moving messages;</span>
  * <span style="font-size: small; font-family: Calibri;">Removing messages;</span>

<span style="font-size: small;"><span style="font-family: Calibri;">Depending on the Outlook version which is being used you will need to use the following guidelines:</span></span>

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="307">
      <strong><span style="font-size: small;"><span style="font-family: Calibri;">Outlook 2007 with performance update or Outlook 2007 SP1 without the cumulative updates of February 2009 </span></span></strong>
    </td>
    
    <td valign="top" width="307">
      <strong><span style="font-size: small;"><span style="font-family: Calibri;">Outlook 2007 with SP1 and cumulative updates of  February 2009 or later</span></span></strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      <span style="font-size: small;"><span style="font-family: Calibri;">2 GB or less<br /> Users should not experience any delay</span></span><span style="font-size: small;"><span style="font-family: Calibri;">2 GB to 4 GB<br /> </span></span><span style="font-size: small;"><span style="font-family: Calibri;">Depending on the hardware a user might experience some delay</span></span><span style="font-size: small;"><span style="font-family: Calibri;">More than 4 GB<br /> Users will definitely experience a delay using most hardware</span></span></p> 
      
      <p>
        <span style="font-size: small;"><span style="font-family: Calibri;">More than 10 GB<br /> The amount of delays will increase</span></span></td> 
        
        <td valign="top" width="307">
          <span style="font-size: small;"><span style="font-family: Calibri;">5 GB or less<br /> </span></span><span style="font-size: small;"><span style="font-family: Calibri;">Users should not experience any delay </span></span><span style="font-size: small;"><span style="font-family: Calibri;">5 GB to 10 GB<br /> </span></span><span style="font-size: small;"><span style="font-family: Calibri;">Depending on the hardware a user might experience some delay</span></span></p> 
          
          <p>
            <span style="font-size: small;"><span style="font-family: Calibri;">More than 10 GB<br /> Users will definitely experience a delay using most hardware</span></span>
          </p>
          
          <p>
            <span style="font-size: small;"><span style="font-family: Calibri;">More than 25 GB<br /> The amount of delays will increase</span></span></td> </tr> </tbody> </table> 
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;"><strong>Cached Exchange Mode i.c.w. BlackBerry devices<br /> </strong>Cached Exchange Mode used  i.c.w. mobile devices to synchronize can cause issues. The cause in most cases is that the mobile server will download the message after the message has been downloaded to the Outlook cache file.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">BlackBerry Server is one of these mobile servers. The BlackBerry Server will add several properties to a message among them <em>RefID</em> which causes the item store in the Information Store to be changed. If a user does make a change to the message it will be updated in the Information Store. Because the properties of both messages are not the same this will result in conflicts.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">The BlackBerry will download the updated item. One of the items is assigned as primary item. The conflict item will be store in the <em>Sync Issues – Conflicts </em>so a user can restore the copy of the message.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">To decrease the amount of conlict items it is possible to apply a workaround. This can be done by making a registry change:</span></span>
            </p>
            
            <ul>
              <li>
                <span style="font-size: small;"><span style="font-family: Calibri;">Open <em>regedit</em></span></span>
              </li>
              <li>
                <span style="font-size: small;"><span style="font-family: Calibri;">Go to <em>HKEY_LOCAL_MACHINE\SOFTWARE\Research In Motion\BlackBerry Enterprise Server\Agents</em></span></span>
              </li>
              <li>
                <span style="font-size: small;"><span style="font-family: Calibri;">Create a new Dword which has as value <em>ProcessMailDelay</em></span></span>
              </li>
              <li>
                <span style="font-size: small;"><span style="font-family: Calibri;">Assign a value of <em>45</em></span></span>
              </li>
            </ul>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">Using the workaround we will ensure that the BlackBerry Server will retrieve the mail with a delay of 45 seconds. Note that this should only be used for testing. BlackBerry recommends to decrease this value once you have confirmed this fixes the sync issues.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;"><strong>Cached Exchange Mode i.c.w. Windows Desktop Search<br /> </strong>Windows Desktop Search can be used to index the content of a mailbox. In Cached Exchange Mode you will need leave Outlook running to index the content of the OST. When you quit Outlook Windows Desktop Search won’t index the OST.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">The advantage of using Cache Exchange Mode i.c.w. Windows Desktop Search is that the requests will be processed locally instead of sending them to the Exchange Server. If you choose to work in Online Mode make sure you are implementing Windows Desktop Search 4.0. Windows Desktop Search 4.0 is the only search engine at this moment which doesn’t create any additional read requests.</span></span>
            </p>
            
            <p>
              <span style="font-size: small;"><span style="font-family: Calibri;">Here ends the blog about Outlook and Cached Exchange Mode. As you have seen there are a lot of things you should consider before enabling it. One of these things is the Outlook version that is in use. It will depend on the organization but in most cases you will see that it Cached Exchange Mode will be enabled both for desktops and laptops. Excluded are desktops which are used as flexible workstations.</span></span>
            </p>