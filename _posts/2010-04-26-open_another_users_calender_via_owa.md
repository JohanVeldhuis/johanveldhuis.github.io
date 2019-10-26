---
id: 1900
title: Open another users calender via OWA
date: 2010-04-26T19:02:53+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1900
permalink: /open_another_users_calender_via_owa/
categories:
  - Exchange
---
Opening a calender from another user using OWA is not a very hard proces, when you have enough permissions you can easily open the other users calender. But what if you would like to do this via OWA?  This depends on the Exchange version you are using, let&#8217;s start with Exchange 2003:

<http://ex01.company.om/exchange/johan/calender>

In Exchange 2003 you can do this by specifying the url which is used to open but add the following part to the url _username/calender._ In this case we will open the calender of _johan._

For both Exchange 2007 and 2010 you will need to use another method. This is because both the OWA from 2007 and 2010 are using web-parts to build the OWA. In Exchange 2007 and 2010 you will have the option to open another users mailbox followed by the calender, backside from using this is that you will need full mailbox access, this is not what you want in all scenario&#8217;s. To open a calender directly use the following syntax:

<https://owa.company.com/owa/johan@domain.com/?cmd=contents&module=calendar>

Almost the same as 2003 only the last part has changed to [_username@domain.com/?cmd=contents&module=calender_](mailto:username@domain.com/?cmd=contents&module=calender)_._ Besides this way there are a few other options which you can use in Exchange 2007 and 2010 to display the calendar, below an overview:

[https://owa.domain.com/owa/johan@domain.com/?cmd=contents&f=calendar&view=dialy](https://mail.domain.com/owa/e2k7user@domain.com/?cmd=contents&f=calendar&view=weekly)

or

[https://owa.domain.com/owa/johan@domain.com/?cmd=contents&module=calendar&view=dialy](https://mail.domain.com/owa/e2k7user@domain.com/?cmd=contents&f=calendar&view=weekly)

The above command will open the calender folder by using the _f_ parameter which makes it possibly to open a specific folder in a mailbox.  As Michel mentioned in his comment you can also use the _module_ parameter instead of the _f_ parameter to perform the same action. Using the _view_ parameter we will specify how we want to display the calender, when you don&#8217;t specify this it will be opened using the _dialy_ view standard.The command above will do exactly the same, open the calender using the dialy view.

[https://owa.domain.com/owa/johan@domain.com/?cmd=contents&f=calendar&view=weekly](https://mail.domain.com/owa/e2k7user@domain.com/?cmd=contents&f=calendar&view=weekly)

This command will open the calender using the weekly view.

<https://owa.domain.com/owa/johan@domain.com/?cmd=contents&f=calendar&view=monthly>

And as last option this command will open the calender view using the monthly view. At least you may think this was the last one there is one other possibility:

<https://owa.domain.com/owa/johan@domain.com/?cmd=content&f=calendar&view=daily&d=10&m=26&y=2010>

This will open the calendar using the dialy view and will open it on the 26th of October 2010.