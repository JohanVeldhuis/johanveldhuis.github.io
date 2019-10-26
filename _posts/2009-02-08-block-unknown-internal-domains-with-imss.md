---
id: 1068
title: Block unknown internal domains with Trend Micro IMSS
date: 2009-02-08T00:10:00+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1068
permalink: /block-unknown-internal-domains-with-imss/
categories:
  - Tutorials
---
Maybe you have seen it mails from unknown domains will be relayed via the internal mailserver or mailserver that is placed in the DMZ. Normally when configuring the mailservers correctly it's not possibly to send mail from a domain which is not hosted on the internal mailserver. But it can also be that a virus is active on a mailserver which is allowed to relay.</p>
<p>In this tutorial I will explain how you can create a policy in Trend Micro IMSS to prevent this. The way of configuring is not really the way you think you have to do it, but the endresult will work.</p>
<p>First we will create a rule which matches incoming messages.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-1.jpg"><img class="alignnone size-thumbnail wp-image-1050" title="Create new policy" src="https://myuclab.nl/wp-content/uploads/2009/02/step-1-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Select the button <em>add </em>and choose the option <em>other.</em></p>
<p>Ensure that the <em>this rule will apply to </em>option is set to <em>incoming </em>, we wil change this later to <em>both incoming and outgoing</em> <em>messages. </em>We could not do this right now because the policy will not be created correctly then.</p>
<a href="http://myuclab.nl/wp-content/uploads/2009/02/step-2.jpg"><img class="alignnone size-thumbnail wp-image-1052" title="Add incoming policy" src="http://myuclab.nl/wp-content/uploads/2009/02/step-2-150x150.jpg" alt="" width="150" height="150" /></a>
<p>Next select on the link <em>recipients </em>a new window will be opened.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-3.jpg"><img class="alignnone size-thumbnail wp-image-1051" title="Specify recipients" src="https://myuclab.nl/wp-content/uploads/2009/02/step-3-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Select the option <em>anyone </em>and select <em>save, </em>the window will close. Next click on <em>senders </em>a new windows will be opened again.</p>
<a href="https://myuclab.nl/wp-content/uploads/2009/02/step-4.jpg"><img class="alignnone size-thumbnail wp-image-1053" title="Specify senders" src="https://myuclab.nl/wp-content/uploads/2009/02/step-4-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Select the option <em>anyone </em>and select <em>save, </em>the last parameter we need to define in this step is the <em>exceptions.</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-5.jpg"><img class="alignnone size-thumbnail wp-image-1054" title="Specify exceptions" src="https://myuclab.nl/wp-content/uploads/2009/02/step-5-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Add the following <em>exception</em>:</p>
<ul>
<li><em>from (sender) </em>*@*</li>
<li><em>to (recipient)</em> <a href="mailto:*@trendmicro.dyndns.org">*@trendmicro.dyndns.org</a></li>
</ul>
<p>Repeat this for each domain.</p>
<p>When ready click on <em>save </em>to <em>save </em>the changes, you will get the following overview after this.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-6.jpg"><img class="alignnone size-thumbnail wp-image-1055" title="Step 1 completed" src="https://myuclab.nl/wp-content/uploads/2009/02/step-6-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Click on the <em>next </em>button to continue. In this step we will define the conditions when a mail must be scanned by this policy.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-7.jpg"><img class="alignnone size-thumbnail wp-image-1056" title="Scanning conditions" src="https://myuclab.nl/wp-content/uploads/2009/02/step-7-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In this case we want to scan all messages so we don't select anything en click on the <em>next </em>button.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-8.jpg"><img class="alignnone size-thumbnail wp-image-1057" title="Warning" src="https://myuclab.nl/wp-content/uploads/2009/02/step-8-150x116.jpg" alt="" width="150" height="116" /></a></p>
<p>You will get a warning that all messages will be scanned if not choosing any condition. Confirm this by clicking on the <em>OK </em>button.</p>
<p>The next step is the action that needs to be executed when a mail meets the conditions. In this case we will delete all messages which meet the conditions. You could choose to quarantine the messages, if you would like to do this change the action.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-9.jpg"><img class="alignnone size-thumbnail wp-image-1058" title="Specify action" src="https://myuclab.nl/wp-content/uploads/2009/02/step-9-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Next we will define the name and number of the policy. Keep in mind that the policy always needs to be created below the <em>Global Antivirus Rule </em>and <em>Default Spam Rule</em>. You may choose to not activate the policy right now but activate it after the steps below.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-10.jpg"><img class="alignnone size-thumbnail wp-image-1059" title="Specify policy name and number" src="https://myuclab.nl/wp-content/uploads/2009/02/step-10-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When you return to the policy overview you can see that the policy is added.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-11.jpg"><img class="alignnone size-thumbnail wp-image-1060" title="Policy overview" src="https://myuclab.nl/wp-content/uploads/2009/02/step-11-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Now we have added the policy we need to change it. This because it's not possible to add *@* as sender/recipient in this policy when choosing the option to apply this policy on <em>both incoming and outgoing messages. </em></p>
<p>Click on the policy to view the details</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-12.jpg"><img class="alignnone size-thumbnail wp-image-1061" title="Edit policy" src="https://myuclab.nl/wp-content/uploads/2009/02/step-12-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Click on <em>if recipient and senders are</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-13.jpg"><img class="alignnone size-thumbnail wp-image-1062" title="This rule will apply to" src="https://myuclab.nl/wp-content/uploads/2009/02/step-13-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Change the option <em>this rule will apply to </em>to <em>both incoming and outgoing messages. </em>Next we will change the <em>exceptions</em>. This can be done by clicking the link <em>Senders and Recipients</em> after the option <em>exceptions</em>.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/02/step-14.jpg"><img class="alignnone size-thumbnail wp-image-1063" title="Specify exceptions" src="https://myuclab.nl/wp-content/uploads/2009/02/step-14-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Add the following exception:</p>
<ul>
<li><em>from (sender) </em><a href="mailto:*@trendmico.dyndns.org">*@trendmico.dyndns.org</a></li>
<li><em>to (recipient) </em>*@*</li>
</ul>
<p>Add the exception for each domain, when ready click <em>save </em>4 times to return to the policy overview. If you have not activated the policy activate it.