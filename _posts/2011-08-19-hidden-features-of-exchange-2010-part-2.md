---
id: 2302
title: 'Hidden features of Exchange 2010 &#8211; part II'
date: 2011-08-19T18:05:35+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=2302
permalink: /hidden-features-of-exchange-2010-part-2/
categories:
  - Exchange
---
&nbsp;

In the First blog we had a look at the _Set-OrganizationConfig_ cmdlet and specifically at the parameters for distribution groups. In this second blog we will have a look at the parameters for Mailtips and Exchange Recipient.

**Mailtips**

Using Mailtips it is possible to inform users before they will send a message. A few examples are:

  * the recipiënt has enabled Out-Of-Office;
  * the message send to the person has a large attachment;
  * the mailbox of the recipiënt is full;
  * the recipiënt is external;
  * the distributionlist contains external users;

To use Mailtips you will need to have Outlook 2010 or Outlook Web App (OWA) as client.

To configure the Mailtip functionality on organization level there are 5 parameters available:

  * MailTipAllTipsEnabled
  * MailTipsExternalRecipientsEnabled
  * MailTipsMailboxSourcedTipsEnabled
  * MailTipsGroupMetricsEnabled
  * MailTipsLargeAudienceTreshold

[<img class="alignnone size-medium wp-image-2303" title="Mailtips parameters" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2011/08/mailtips-300x36.jpg?resize=300%2C36" alt="" width="300" height="36" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/08/mailtips.jpg?resize=300%2C36&ssl=1 300w, https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/08/mailtips.jpg?w=527&ssl=1 527w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2011/08/mailtips.jpg)

The Mailtip functionality is enabled by default. If you would like to disable this option the parameter _MailTipsAllTipsEnabled_ will need to be set to _false_:

```PowerShell
Set-OrganizationConfig –MailTipsAllTipsEnabled $false
```

Mailtips won’t be enabled when a message is send to external contacts. In case this is a requirement of the company you will need to configure the _MailTipsExternalRecipientsTipsEnabled_ parameter and change the value to _true_:

```PowerShell
Set-OrganizationConfig –MailTipsExternalRecipientsTipsEnabled $true
```

The last two parameters _MailTipsGroupMetricsEnabled_ and _MailTipsLargeAudienceTreshold_ need to be used in combination.

On the server which generates the address book a process runs every night to count the amount of members in a Group. The results will be stored in a folder called _GroupMetrics._ In this folder three files will be created:

  * GroupMetrics-_date_T_time_.bin, contains the members of all distribution groups in the organization;
  * GroupMetrics_servername_.xml, contains the configuration information of the mailbox server which is responsible for generating the data;
  * ChangedGroups.txt, contains a list of groups which have changed since the last update;

The content of the folder will be distributed to the Client Access Servers through the _File Distribution Service_ of Exchange. Besides this the data will be distributed every 8 hours to all Mailbox servers which are enabled for generating Group Metric data.

When the _MailTipsGroupMetricsEnabled_ parameter has been configured with the value _true,_ which is the default value, __all Mailtips will use the Group Metric data. Depending on the value of the _MailTipsLargeAudienceTreshold_ a Mailtip will be displayed. The default value of this parameter is _25_. When a distributiongroup contains more than 25 members a Mailtip will be displayed.

```PowerShell
Set-OrganizationConfig –MailTipsLargeAudienceTreshold 50
```

By using the above parameter we will configure that a Mailtip will only be displayed when mail is sent to a distribution Group which contains more than 50 members.

**Microsoft Exchange Recipient**

The second parameter we will have a look are the _MicrosoftExchangeRecipient_ parameters. Exchange 2010 contains four parameters:

  * MicrosoftExchangeRecipientEmailAddresses
  * MicrosoftExchangeRecipientPrimarySmtpAddress
  * MicrosoftExchangeRecipientEmailAddressPolicyEnabled
  * MicrosoftExchangeRecipientReplyRecipient

As the name already tells you all these parameters are related to recipients from Exchange.

When having a look at the value of the _MicrosoftExchangeRecipientEmailAddresses_ parameter you will see it´s equal to the e-mail addresses which are applied by the _Default E-mail Address Policy_. All addresses are split by a “;” if an address is added here the _Default E-mail Address Policy_ will be updated.

But it’s not recommended by doing it this way. When having a look at the addresses you will see every address starts with _MicrosoftExchange329e7_.

Using the second parameter _MicrosoftExchangeRecipientPrimarySmtpAddress_ we can configure which address needs to be set as the SMTP address. This value can only be used when the parameter _MicrosoftExchangeRecipientEmailAddressPolicyEnabled_ is disabled. Otherwise the value will be ignored. If the value of this parameter will be changed to an address which does not exist in the _Default Recipient Policy_ it will be automatically added.

One important thing to keep in mind is that if the _Default E-mail Address Policy_ is disabled the  _MicrosoftExchangeRecipientPrimarySmtpAddress_ parameter must contain a value. Several services among them the Exchange UM service must have a valid e-mail address. If the _Default E-mail Address Policy_ is disabled and _MicrosoftExchangeRecipientPrimarySmtpAddress_ doesn’t have a value the service will not get an e-mail address. The result will be that Exchange will not accept messages from the service.

Using the last parameter _MicrosoftExchangeRecipientReplyRecipient_ you can configure if the _Microsoft Exchange recipiënt_ can receive e-mail. This account is used to send DSN messages to internal users. When you will allow users to reply to this mailbox make sure this mailbox will be monitored. You can configure the parameter as follows:

```PowerShell
Set-OrganizationConfig –MicrosoftExchangeRecipientReplyRecipient <dsn@domain.com>
```

Using the above cmdlet we have configured that if a user replies to a message of the Microsoft Exchange recipient mailbox this message will be delivered to the following e-mail address <dsn@domain.com>.

Here ends part two of the serie of hidden features of Exchange 2010. In  the next log we will have a look at the _Set-ExchangeAssistanceConfig_ cmdlet.

&nbsp;