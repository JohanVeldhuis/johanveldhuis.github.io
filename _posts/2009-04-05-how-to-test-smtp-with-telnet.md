---
id: 1146
title: How to test smtp with telnet
date: 2009-04-05T21:18:06+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1146
permalink: /how-to-test-smtp-with-telnet/
categories:
  - Blog
---
When starting to troubleshoot smtp issues you can do this easily via telnet, below a hosrt description on how to perform the test:

First we will make connection to the mailserver on port 25.

_telnet mail.company.com 25_

You will receive the following answer when, for example, you connect to an Exchange server

_220 mail.company.com Microsoft ESMTP MAIL Service, Version: 6.0.3790.3959 ready at  Sun, 5 Apr 2009 21:36:57 +0200_

You will need to reply with a _helo_ followed by the domain you are sending from

_helo test.nl_

Next you will need to specify the sender of the mail

_mail from:_ [_test@test.nl_](mailto:test@test.nl)

When the sender has been accepted the mailserver will respond with a 250 &#8211; OK

_250 2.1.0 OK &#8211; Mail FROM <test@test.nl>_

Next thing you need to specify is the recipient of the mail

_rcpt to:_ [_user@company.com_](mailto:user@company.com)

When the recipient address has been excepted the mailserver again will respond with a 250 OK

_250 2.1.5 OK recipient <user@company.com>_

Now we have specified both the sender and recipient we can specify the mail, this will be done via the command _data_

_data_

When you have send the aboe command to the mailserver it will respond with the following command

_354 Send data. End with CRLF.CRLF_

The mailserver will tell you that you will need to end the mail with a _._

First we specify the subject of the mail, when you don&#8217;t do this the subject will be empty.

_subject: smtp test via telnet_

After the subject command has been specified you will need to press enter 2 times, you won&#8217;t receive feedback of this. The 2 times enter is needed according to  RFC-822 and RFC-2822.

Now we have specified the subject we can specify the text we would like to be in the mail

_This mail is send via telnet
  
_ _._

As mentioned earlier we end the mail with a ., the . needs to be placed on a new line. When the mail has been accepted by the mailserver for delivery it will respond with the following command

_250 2.6.0 <COMPANY5Kns1ZEqUz00000001@company.com> Queued mail for delivery_

To disconnect from the mailserver you will need to use the command _quit_

_Quit_

For further information of the RFC&#8217;s have a look at the sites below.

<a href="http://www.ietf.org/rfc/rfc0822.txt" target="_blank">RFC-822</a>
  
<a href="http://www.ietf.org/rfc/rfc2822.txt" target="_blank">RFC-2822</a>