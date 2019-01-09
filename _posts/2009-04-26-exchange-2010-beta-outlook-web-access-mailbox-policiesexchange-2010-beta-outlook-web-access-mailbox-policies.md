---
id: 1199
title: 'Exchange 2010 beta: Outlook Web Access Mailbox Policies'
date: 2009-04-26T13:47:40+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1199
permalink: /exchange-2010-beta-outlook-web-access-mailbox-policiesexchange-2010-beta-outlook-web-access-mailbox-policies/
aktt_notify_twitter:
  - 'no'
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Exchange 2010
---
It&#8217;s time for the 3rd article about Exchange 2010 Beta, in this article we will have a closer look _Outlook Web Access Mailbox Policies_. In Exchange 2007 configuring which features you want to activate in OWA could only be done per user or global on the OWA itself, in Exchange 2010 Beta there&#8217;s a new features called: _Outlook Web Access Mailbox Policies._ With this policies you can deactivate items for users. When selecting the _CAS server_ under the _Organization Configuration_ you will see two tabs instead of one tab, just as in Exchange 2007.

[<img class="alignnone size-thumbnail wp-image-1200" title="Outlook Web Access Mailbox Policies" src="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-1-150x119.jpg?resize=150%2C119" alt="Outlook Web Access Mailbox Policies" width="150" height="119" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-1.jpg?resize=150%2C119&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-1.jpg?zoom=2&resize=150%2C119&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-1.jpg)

Default there is only one policy called _default,_ in this policy all features are enabled. If you would like to change this you can create a new policy or change the default policy. When creating a new policy you will see the following screen:

[<img class="alignnone size-thumbnail wp-image-1202" title="Create new Outlook Web Access Mailbox Policy" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-3-150x150.jpg?resize=150%2C150" alt="Create new Outlook Web Access Mailbox Policy" width="150" height="150" srcset="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-3.jpg?resize=150%2C150&ssl=1 150w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-3.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-3.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-3.jpg)

The only thing you will need to define is a name for the policy and which features you would like to deactivate, default all options are enabled.
  
When finished configuring the policy just push the _new_ policy and the policy is created.

[<img class="alignnone size-thumbnail wp-image-1203" title="New Outlook Web Access Mailbox policy created" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-4-150x150.jpg?resize=150%2C150" alt="New Outlook Web Access Mailbox policy created" width="150" height="150" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-4.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-4.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-4.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-4.jpg)

When the policy is created the only thing you will need to do is assign the polocy to users. This can be done by selecting a user below the _recipient configuration_ option, get the properties of the user and select the tab  _mailbox features:_

[<img class="alignnone size-thumbnail wp-image-1204" title="Mailbox features" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-5-150x150.jpg?resize=150%2C150" alt="Mailbox features" width="150" height="150" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-5.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-5.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-5.jpg)

Here you will see all connection possibilities that a user has to access his/her mailbox, select _Outlook Web Access_ and select _properties_

[<img class="alignnone size-thumbnail wp-image-1205" title="Outlook Web Access Properties" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-6-150x149.jpg?resize=150%2C149" alt="Outlook Web Access Properties" width="150" height="149" srcset="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-6.jpg?resize=150%2C149&ssl=1 150w, https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-6.jpg?zoom=2&resize=150%2C149&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2009/04/cas-6.jpg)

In the new opened window you can assign Outlook Web Access mailbox policy to the user. For this you will need to do two things place a checkmark before _Outlook Web Access mailbox policy_ and choose the policy which you like to assign to the user by selecting the _browse button._