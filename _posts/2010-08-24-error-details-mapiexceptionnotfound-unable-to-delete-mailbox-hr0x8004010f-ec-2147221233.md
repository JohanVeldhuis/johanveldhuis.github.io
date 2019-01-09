---
id: 1997
title: 'Error details: MapiExceptionNotFound: Unable to delete mailbox. (hr=0x8004010f, ec=-2147221233)'
date: 2010-08-24T19:52:41+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1997
permalink: /error-details-mapiexceptionnotfound-unable-to-delete-mailbox-hr0x8004010f-ec-2147221233/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2010
---
I am currently working on an Exchange 2003 to Exchange 2010 migration. During the migration I had an issue which caused that the old mailboxes were not cleaned up correctly and the user was not converted to a mail user. The first issue can happen even if everything is configured correctly. The only solution at this moment is to run the _cleanup agent_ which can be found in the _Exchange System Manager__._

In this case the problem was caused by something else. During the move request a log will be generated and when looking the the log I found the following error:

_Warning: Unable to update AD information for the source mailbox at the end of the move.  Error details: An error occurred while updating a user object after the move operation. &#8211;> The LdapRecipientFilter &#8220;(&(&(&(& (mailnickname=\*) (| (&(objectCategory=person)(objectClass=user)(!(homeMDB=\*))(!(msExchHomeServerName=\*)))(&(objectCategory=person)(objectClass=user)(|(homeMDB=\*)(msExchHomeServerName=*)))(&(objectCategory=person)(objectClass=contact))(objectCategory=group)(objectCategory=publicFolder)(objectCategory=msExchDynamicDistributionList) )))(objectCategory=user)(vasco-Locked<=sdfasdfsdfasdfasdfasdf)))&#8221; on Address List or Email Address Policy &#8220;domain.com&#8221; is invalid. Additional information: The decimal number &#8216;sdfasdfsdfasdfasdfasdf&#8217; is invalid or out-of-range. &#8211;> The decimal number &#8216;sdfasdfsdfasdfasdfasdf&#8217; is invalid or out-of-range.</p> 

Failed to cleanup the source mailbox after the move.

Error details: MapiExceptionNotFound: Unable to delete mailbox. (hr=0x8004010f, ec=-2147221233)</em>

As you can see it has some problems updating the AD information for a specific user and to be more specific the problem is caused by the _Email Address Policy_ which has the name _domain.com._ As the error already tells you there is an issue caused by an invalid value which is configured in the policy.  This policy was created quickly by one of the admins before the migration which was planned in the weekend. Because he don&#8217;t want the policy to be applied to the users he provided an invalid value so there would be no match on any user.

So ensure before starting the migration that the Email Address Policies are working correctly and don&#8217;t make changes before the migration unless really necessary. In this case we needed to perform two actions to solve the issue:

  * remove the mailbox from the specific user
  * user must be mail enabled with the correct mail-addresses so it still works in thge co-existence fase

Besides this the policy needs to be corrected or it will need to be removed if it is not necessary anymore.