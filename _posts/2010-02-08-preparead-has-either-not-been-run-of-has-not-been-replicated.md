---
id: 1838
title: PrepareAD has either not been run or has not been replicated
date: 2010-02-08T22:14:51+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1838
permalink: /preparead-has-either-not-been-run-of-has-not-been-replicated/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
onswipe_thumb:
  - 'http://johanveldhuis.nl/wp-content/plugins/onswipe/thumb/thumb.php?src=http://johanveldhuis.nl/wp-content/plugins/sociable-zyblog-edition/images/digg.png&amp;w=600&amp;h=800&amp;zc=1&amp;q=75&amp;f=0'
categories:
  - Exchange 2007
---
Today I had a nice issue at a customer site who tried to install Exchange in a test environment. First I will give a short introduction. Let&#8217;s say you have an AD forest which contains a child domain where you want to host Exchange in. You first will need to do some things in the forest before you can install Exchange in the child domain. You will start with the schema upgrade followed by the forest prep. As last step you will prepare the child domain and you could start the Exchange setup to install Exchange.

Normally you will use the same media for all servers, but in Exchange 2007 this can be different. This because Exchange 2007 had a 32-bit version which could be used in test environments or to prepare the schema/forest on a 32-bit DC.

You may think aaahhh that happened ?? Everything was done via the correct steps but when starting the Exchange installation via the GUI the following errors were displayed in the log:

_\[2/7/2010 11:30:46 PM\] \[0\] Setup has chosen the local domain controller dc.ota.company.corp for initial queries
  
\[2/7/2010 11:30:46 PM\] \[0\] PrepareAD has either not been run or has not replicated to the domain controller used by Setup. Setup will attempt to use the Schema Master domain controller dc.company.corp
  
\[2/7/2010 11:30:46 PM\] \[0\] The schema master domain controller is available_

So first checked if the servers can connect to eachother which was no issue. After trying some things we decided to move the schema master to the child domain to look if that would help. But this was also a no go and gave the following warnings:

\[2/8/2010 3:32:34 PM\] \[1\] [ERROR] PrepareDomain for domain ota has partially completed. Because of your Active Directory site configuration, you must wait for forest-wide replication to occur, and then run PrepareDomain for ota again.
  
\[2/8/2010 3:32:34 PM\] \[1\] [ERROR] Active Directory operation failed on dc.ota.company.corp. This error is not retriable. Additional information: The specified group type is invalid.
  
Active directory response: 00002141: SvcErr: DSID-031A0FC0, problem 5003 (WILL\_NOT\_PERFORM), data 0

Waiting for 15 minutes didn&#8217;t fix the issue so we reversed all changes and I decided to start the Exchange setup via the GUI on the schema master. Then I saw the issue immidiatly the files used on the schema master were files for Exchange 2007 RTM and not for Exchange 2007 SP1. After using that files it worked without any issues.

It was a nice jigsaw after all.