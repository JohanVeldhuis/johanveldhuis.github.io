---
id: 768
title: E-mail address policy
date: 2008-09-01T21:08:34+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=768
permalink: /e-mail-address-policy/
categories:
  - Exchange
---
E-mail address policies are always nice to play with, but when you don&#8217;t use them often you sometimes forget the variables which you can provide to build an e-mail address. I made a short list of available variables:

  * _%g_ given name
  * _%i_ middle name
  * _%s_ surname
  * _%d_ display name
  * _%m_ Exchange alias

The variables can also be used in combination with numbers. With this we can select only the first 2 letters of a first name by specifying the following variable %2g.

If we want to create an e-mail address for the user Pietje Puk and we only want to use the first letter of his first name and his complete lastname then we should provide the following variable with the parameter_EnabledEmailAddressTemplates:_

_<%1g.%s@test.nl>_