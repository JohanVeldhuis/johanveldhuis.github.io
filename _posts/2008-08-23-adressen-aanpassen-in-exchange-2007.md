---
id: 740
title: Address rewriting in Exchange 2007
date: 2008-08-23T21:44:18+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=740
permalink: /adressen-aanpassen-in-exchange-2007/
categories:
  - Exchange
---
When you would like to use other addresses internal then external you may want to use the _New-AddressRewriteEntry _ Powershell command to let Exchange do this for you.

_New-AddressRewriteEntry -Name &#8220;Address rewrite for test.local&#8221; -InternalAddress test.local -ExternalAddress corporate.com_

With the code above Exchange will modify the address <piet@test.local> to <piet@corporate.com> when the user sends an e-mail to for example Hotmail.

To see all the entries you create execute the following Powershell command _get-AddressRewriteEntry_

If you don&#8217;t want to use the rule anymore you can simply delete the entry by executing the _remove-AddressRewriteEntry._ If you want to remove the entry that we just created execute the following code:

<div>
  <em>Remove-AddressRewriteEntry &#8220;Address rewrite for test.local&#8221;</em>
</div>

_ </p> 

</em>