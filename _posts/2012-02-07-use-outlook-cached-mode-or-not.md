---
id: 2411
title: Use Outlook cached mode or not?
date: 2012-02-07T21:25:43+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2411
permalink: /use-outlook-cached-mode-or-not/
categories:
  - Exchange
---
**Use Outlook cached mode or not?**

Since Outlook 2003 it is possible to run Outlook in two modes:

  * Online mode
  * Cached Exchange mode

But what are the differences between those modes?

<strong>Online mode<br /> </strong>When the Outlook profile is configured in Online Mode Outlook will create a direct connection to the Information Store of Exchange. This has as advantage that messages will appear almost immidiatly when delivered to the mailbox. When the connection to the Exchange server is not available you don’t have access to the mailbox.

<strong>Cached Exchange mode<br /> </strong>When the Outlook profile is configured in Cached Exchange mode a local cache file will be created from the mailbox. This file is also known as the offline data file which can be recognized easily when looking at the extension which is OST. By default the file is stored in <em>Local Settings\Application Data\Microsoft\Outlook.</em> When looking at the size of the OST you will see the size is different than the size of the mailbox.

An OST file can be 50 to 80 percent bigger than the mailbox. The cause of this is the method which is being used to store items. Outlook does use a less efficient way then Exchange Server.

The maximum size of the OST is differs per type:

  * Non-Unicode (ANSI): maximum 2 GB;<
  * Unicode: maximum size is configurable, default 50 GB;<

Which type is used can be discovered by using the following steps:<

  * Select <strong>Tools;</strong><
  * Select the option <strong>E-mail accounts;</strong><
  * Select the <strong>Exchange e-mail account </strong>and press the <strong>change </strong>button;<
  * Select <strong>More Settings;</strong><
  * Select the <strong>Advanced </strong>tab</span>
  * Check the value of <strong>Mailbox Mode</strong>;<

Besides the OST file a user in Cached Exchange Mode also uses Offline Address Book (OAB). <

The advantage of Cached Exchange Mode is that mailbox content is also available when you don’t have a connection to Exchange, excluded the new items which haven’t been cached. When connected to Exchange messages will arrive with a slight delay in the mailbox. This is caused by Outlook which will check for new messages every 30 seconds by default. A disadvantage of Cached Exchange Mode that the OST file is only cached locally. When a user is working on another workstation a new OST file will be generated if not available.<

Starting from Outlook 2010 Microsoft recommends to use Cached Exchange Mode. When the autodiscover functionality of Exchange is being used you will see that the Cached Exchange Mode will be enabled by default.<

In environments with a limited bandwidth (slow connection) you can choose to only download the e0mail headers and the First 256 characters of a message.<

When the speed of a network connection is 128 KB or less a connection is stamped as slow connection. <

The amount of RPC requests, compared with Online mode, is less. This because the local cache on the workstation is being used.  The influence of the harddisk from the workstation is bigger.<

<strong>What is being cached?<br /> </strong>When using Outlook 2010 by default both the user mailbox and additional mailboxes are added to the cache. The Public Folder is not stored in the cache. It is possible to add Public Folder favorites to the cache but in this case you will need to enable the option manually or via a GPO.<

As mentioned earlier Outlook will use an Offline Address Book (OAB). Initially a complete download is being performed of the address book. After that only incremental updates are downloaded from the address book. The OAB is being downloaded once every 24 hours if the OAB contains new data.<

<strong>When shouldn’t you use Cached Mode?<br /> </strong>But are there scenario’s where you don’t want to use Cached Exchange mode?<strong></strong><

Yes there are, below an overview of these scenario’s:<

  * Computers which are being used by multiple people and where a delay of downloading the new messages is not acceptable;<
  * Environments where compliance and security rules which prohibits the store of data locally; <
  * The complete cached file can’t be stored because of lack due to disk space;<
  * Mailboxes greater then 25 GB;</span>
  * Virtual or Remote Desktop Service environments where Outlook 2007 and Outlook 2003 is installed. Cached Exchange Mode isn’t supported on a system which offers  Remote Desktop Services;<
  * Virtual or Remote Desktop Service environments where Outlook 2010 is used but not enough disk space or I/O’s are available;<

<strong>Impact of Cached Exchange Mode on Outlook functionalities<br /> </strong>Besides the earlier called scenarios there are some additional functionalities which are influenced when using Outlook in Cached Exchange Mode. Below an overview of the functionalities:<

  * Delegate mailbox data stores;</span>
  * Shared Folders which are not made available offline;<
  * Retrieve Free/Busy information;</span>
  * Configure/change/disable Out-Of-Office;<
  * Access to Public Folders;</span>
  * Retrieving IRM messages;</span>
  * Changing rules;</span>
  * Retrieving MailTips;</span>

These functions require a connection to the Exchange environment. When there is no connection this functions are not available. If there is a connection with the Exchange Server it can happen that these functions are working slower then normally. This is only the case when connecting via a connection with a high latency.<

Besides the earlier called functionalities there are a few functions which Microsoft doesn’t recommend to use:<

  * Using the toast alert function with digitale signatures;<
  * Multiple address book containers;</span>
  * Custom properties on the General tab;<

<strong>Influance of large .ost files<br /> </strong>Large ost files can cause performance issues in Outlook. Users can recognize this because Outlook doesn’t respond correctly. This can happen if one of the following tasks is being performed:<

  * Reading messages;</span>
  * Moving messages;</span>
  * Removing messages;</span>

Depending on the Outlook version which is being used you will need to use the following guidelines:<

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="307">
      <strong>Outlook 2007 with performance update or Outlook 2007 SP1 without the cumulative updates of February 2009 <</strong>
    </td>
    
    <td valign="top" width="307">
      <strong>Outlook 2007 with SP1 and cumulative updates of  February 2009 or later<</strong>
    </td>
  </tr>
  
  <tr>
    <td valign="top" width="307">
      2 GB or less<br /> Users should not experience any delay<2 GB to 4 GB<br /> <Depending on the hardware a user might experience some delay<More than 4 GB<br /> Users will definitely experience a delay using most hardware<</p> 
      
      <p>
        More than 10 GB<br /> The amount of delays will increase<</td> 
        
        <td valign="top" width="307">
          5 GB or less<br /> <Users should not experience any delay <5 GB to 10 GB<br /> <Depending on the hardware a user might experience some delay<</p> 
          
          <p>
            More than 10 GB<br /> Users will definitely experience a delay using most hardware<
          </p>
          
          <p>
            More than 25 GB<br /> The amount of delays will increase<</td> </tr> </tbody> </table> 
            
            <p>
              <strong>Cached Exchange Mode i.c.w. BlackBerry devices<br /> </strong>Cached Exchange Mode used  i.c.w. mobile devices to synchronize can cause issues. The cause in most cases is that the mobile server will download the message after the message has been downloaded to the Outlook cache file.<
            </p>
            
            <p>
              BlackBerry Server is one of these mobile servers. The BlackBerry Server will add several properties to a message among them <em>RefID</em> which causes the item store in the Information Store to be changed. If a user does make a change to the message it will be updated in the Information Store. Because the properties of both messages are not the same this will result in conflicts.<
            </p>
            
            <p>
              The BlackBerry will download the updated item. One of the items is assigned as primary item. The conflict item will be store in the <em>Sync Issues – Conflicts </em>so a user can restore the copy of the message.<
            </p>
            
            <p>
              To decrease the amount of conlict items it is possible to apply a workaround. This can be done by making a registry change:<
            </p>
            
            <ul>
              <li>
                Open <em>regedit</em><
              </li>
              <li>
                Go to <em>HKEY_LOCAL_MACHINE\SOFTWARE\Research In Motion\BlackBerry Enterprise Server\Agents</em><
              </li>
              <li>
                Create a new Dword which has as value <em>ProcessMailDelay</em><
              </li>
              <li>
                Assign a value of <em>45</em><
              </li>
            </ul>
            
            <p>
              Using the workaround we will ensure that the BlackBerry Server will retrieve the mail with a delay of 45 seconds. Note that this should only be used for testing. BlackBerry recommends to decrease this value once you have confirmed this fixes the sync issues.<
            </p>
            
            <p>
              <strong>Cached Exchange Mode i.c.w. Windows Desktop Search<br /> </strong>Windows Desktop Search can be used to index the content of a mailbox. In Cached Exchange Mode you will need leave Outlook running to index the content of the OST. When you quit Outlook Windows Desktop Search won’t index the OST.<
            </p>
            
            <p>
              The advantage of using Cache Exchange Mode i.c.w. Windows Desktop Search is that the requests will be processed locally instead of sending them to the Exchange Server. If you choose to work in Online Mode make sure you are implementing Windows Desktop Search 4.0. Windows Desktop Search 4.0 is the only search engine at this moment which doesn’t create any additional read requests.<
            </p>
            
            <p>
              Here ends the blog about Outlook and Cached Exchange Mode. As you have seen there are a lot of things you should consider before enabling it. One of these things is the Outlook version that is in use. It will depend on the organization but in most cases you will see that it Cached Exchange Mode will be enabled both for desktops and laptops. Excluded are desktops which are used as flexible workstations.<
            </p>