---
id: 1973
title: Exchange 2010 schema prep fails when Exchange 2007 SP3 is installed
date: 2010-07-26T20:26:48+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1973
permalink: /exchange-2010-schema-prep-fails-when-exchange-2007-sp3-is-installed/
categories:
  - Exchange
---
According to the Technet documentation you should be able to install Exchange 2010 in an environment where Exchange 2007 is running. A while ago I got a question from a customer who had an issue when trying to install Exchange 2010. The problem occured running the _setup.com /ps_ to extend the schema for Exchange, the following error message was displayed:

[<img title="Exchange 2010 schema upgrade" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2010/07/ad-prep-300x61.png?resize=300%2C61" alt="" width="300" height="61" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2010/07/ad-prep.png)

The schema version of Exchange 2007 SP3 is higher than the one from the Exchange 2010 setup. This makes it impossible to install Exchange 2010.

When you have installed Exchange SP3 you will have to wait for a service pack which will extend the schema. Because a lot of people will probably install Exchange 2007 SP3 this may be included in SP1 for Exchange 2010.

Below an overview of the Exchange versions and which schema version they use:

[table id=18 /]

If you would like to know how you can find out which version of AD schema you are using then take a look at the site below:

<a href="http://support.microsoft.com/kb/556086" target="_blank">open</a>