---
id: 1142
title: Ports used by Exchange 2007
date: 2009-03-29T20:16:51+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1142
permalink: /ports-used-by-exchange-2007/
categories:
  - Exchange
---
Via one of my <a href="http://www.vdknaap.com" target="_blank">colleagues</a> I received a pretty nice site with an overview of all ports used for communication between the Exchange 2007 server roles. Below the overview:

<table border="1">
  <tr>
    <td>
      <strong>Data path</strong>
    </td>
    
    <td>
      <strong>Required ports</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      Hub Transport server to Hub Transport server
    </td>
    
    <td>
      25/TCP (Secure Sockets Layer [SSL]), 587/TCP (SSL)
    </td>
  </tr>
  
  <tr>
    <td>
      Hub Transport server to Edge Transport server
    </td>
    
    <td>
      25/TCP (SSL)
    </td>
  </tr>
  
  <tr>
    <td>
      Edge Transport server to Hub Transport server
    </td>
    
    <td>
      25/TCP (SSL)
    </td>
  </tr>
  
  <tr>
    <td>
      Edge Transport server to Edge Transport server
    </td>
    
    <td>
      25/TCP (SSL), 389/TCP/UDP, and 80/TCP (certificate authentication)
    </td>
  </tr>
  
  <tr>
    <td>
      Mailbox server to Hub Transport server via the Microsoft Exchange Mail Submission Service
    </td>
    
    <td>
      135/TCP (RPC)
    </td>
  </tr>
  
  <tr>
    <td>
      Hub Transport to Mailbox server via MAPI
    </td>
    
    <td>
      135/TCP (RPC)
    </td>
  </tr>
  
  <tr>
    <td>
      Microsoft Exchange EdgeSync service
    </td>
    
    <td>
      50636/TCP (SSL), 50389/TCP (No SSL)
    </td>
  </tr>
  
  <tr>
    <td>
      Active Directory Application Mode (ADAM) directory service on Edge Transport server
    </td>
    
    <td>
      50389/TCP (No SSL)
    </td>
  </tr>
  
  <tr>
    <td>
      Active Directory directory service access from Hub Transport server
    </td>
    
    <td>
      389/TCP/UDP (LDAP), 3268/TCP (LDAP GC), 88/TCP/UDP (Kerberos), 53/TCP/UDP (DNS), 135/TCP (RPC netlogon)
    </td>
  </tr>
</table>

If you would like to know the authentication method used by the specific roles have a look at the site below.

<a href="http://technet.microsoft.com/en-us/library/bb691338.aspx" target="_blank">open</a>