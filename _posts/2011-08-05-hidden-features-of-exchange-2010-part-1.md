---
id: 2290
title: 'Hidden features of Exchange 2010 &#8211; part I'
date: 2011-08-05T20:00:19+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2290
permalink: /hidden-features-of-exchange-2010-part-1/
categories:
  - Exchange
---
When you have worked with Exchange 2010 you might know that some things only can be configured by using the Exchange Management Shell (EMS). A few examples are:

  * configuring relaying on a receive connector
  * enable logging for IMAP and POP3

<div>
  In some cases a hidden option is available in the Exchange Control Panel. In this serie of blogs we will have a look at these cmdlet&#8217;s and especially the parameters.
</div>

<div>
  We start with the hidden features of distribution groups. These groups can be used to send a message to multiple people. In Exchange 2010 three parameters are available which can be used to define the name and location of the distribution group.
</div>

<div>
  The parameters for this must be used i.c.w. the <em>set-organizationconfig </em>Powershell cmdlet:
</div>

<div>
  <a href="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/08/powershell.jpg"><img title="Three parameters" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/08/powershell-300x30.jpg?resize=300%2C30" alt="" width="300" height="30" data-recalc-dims="1" /></a>
</div>
<div>
  <strong></strong> 
</div>
<div>
  <strong>DistributionGroupDefaultOU</strong>
</div>

<div>
  As the name already tells you this parameter can be used to configure the default OU which is used to store the distribution groups. By using this parameter you can prevent that distribution groups will be created in multiple OU&#8217;s. For example we had an Active Directory called <strong>corp.local</strong> and we have created an OU <strong>Distribution Groups. </strong>To ensure that the new distribution groups will be stored in this OU we will need to use the following cmdlet:\
</div>

```PowerShell
Set-OrganizationConfig -DistributionGroupDefaultOU ' corp.local/Distribution Groups'
```

<div>
  Once configured all new distribution groups will be stored in this OU.
</div>

<div>
  <strong></strong> 
</div>

<div>
  <strong>DistributionGroupNameBlockedWordsList</strong>
</div>

<div>
  Using this parameter we can configure words which may not be used in names of distribution groups. This parameter may not work for all organizations. Before using this parameter make a correct inventory which words can&#8217;t be used. For example when we want to prevent the use of the words <strong>toys </strong>and<strong> computer </strong>as the name of a distribution group we will need to use the following cmdlet:
</div>

```PowerShell
Set-OrganizationConfig -DistributionGroupNameBlockedWordsList toys,computer
```
<div>
  This parameter can also be configured by using the Exchange Control Panel (ECP).
</div>

<div>
  <strong></strong> 
</div>

<div>
  <strong>DistributionGroupNamingPolicy</strong>
</div>

<div>
  Using this parameter we can configure the naming convention which will be applied when creating a distribution group. In this policy the following variables can be used:
</div>

<div>
  <ul>
    <li>
      Department
    </li>
    <li>
      Company
    </li>
    <li>
      Office
    </li>
    <li>
      StateorProvince
    </li>
    <li>
      CountryorRegion
    </li>
    <li>
      CountryCode
    </li>
    <li>
      Title
    </li>
    <li>
      CustomAttribute1 tot CustomAttribute15
    </li>
  </ul>
  
  <div>
    Let&#8217;s say we want all the names of distribution groups start with <strong>DG_ </strong>followed by the <strong>groupname </strong>en <strong>countrycode </strong>where we will split the last two by using an underscore:
  </div>
</div>

```PowerShell
Set-OrganizationConfig -DistributionGroupNamingPolicy 'DG_<GroupName><CountryCode>'
```

<div>
  When a new group is created called support it will be automatically renamed to for example: DG_Support>NL@corp.local. Keep in mind that the e-mail address assigned to the distribution group might not be correct, this of coure depends on you e-mail address policy. In this case the e-mail address will be something like <a href="mailto:DG_support_NL@corp.local">DG_support_NL@corp.local</a>.
</div>

<div>
  One remark must be made when using the earlier discussed variables. These values will be determined by copying the values from the user which creates the distribution groups.
</div>

<div>
  This parameter can also be configured by using the ECP.
</div>

<div>
  <strong></strong> 
</div>

<div>
  <strong>Combining parameters</strong>
</div>

<div>
  Of course it&#8217;s also possible to combine the three parameters. In the following example we will configure the parameters as followed:
</div>

<div>
  <ul>
    <li>
      all distribution groups will be created in an OU groups which is located in the OU demo
    </li>
    <li>
      all names of distribution groups need to start with DG_
    </li>
    <li>
      the word everyone may not be used
    </li>
  </ul>
  
  <div>
    To configure this we will need to use the following cmdlet:
  </div>
</div>

```PowerShell
Set-OrganizationConfig -DistributionGroupDefaultOU 'corp.local/demo/groups'  -DistributionGroupNamingPolicy 'DG_<GroupName>'  -DistributionGroupNameBlockedWordsList everyone
```

<div>
  When a new user is created using the EMC called <strong>demousers </strong> you will get the following result:
</div>

<div>
  <a href="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/08/new_group.jpg"><img title="Create New Distribution Group" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/08/new_group-300x25.jpg?resize=300%2C25" alt="" width="300" height="25" data-recalc-dims="1" /></a>
</div>

<div>
  When a group is created by using the name <strong>everyone </strong>the following error will be displayed:
</div>

<div>
  <a href="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/08/new_group_deny.jpg"><img title="New Distribution Group blocked word used" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2011/08/new_group_deny-300x166.jpg?resize=300%2C166" alt="" width="300" height="166" data-recalc-dims="1" /></a>
</div>

<div>
  Here ends the first blog about the hidden features of Exchange 2010. In the next blog we will continue to have a look at the <em>set-organizationconfig </em>cmdlet and will have a look at which parameters may be very usefull for you.
</div>