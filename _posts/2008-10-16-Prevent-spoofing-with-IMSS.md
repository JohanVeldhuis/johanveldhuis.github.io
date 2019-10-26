---
id: 904
title: Prevent spoofing with IMSS
date: 2008-10-16T22:25:14+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=904
permalink: /Prevent-spoofing-with-IMSS/
categories:
  - Tutorials
---
It's time for a new tutorial but this time with another subject Trend Micro Interscan Messaging Security Suite, IMSS for short. IMSS is the antivirus/imss solution from Trend Micro which is available for Windows, Linux, Solaris and as appliance.</p>
<p>With policies we can define our own rules, we will create a rule which will prevend spoofing. To do this we need to login to the admin console of IMSS. This can be done by selecting the option <em>policy </em>and then select the option <em>policy list </em>in the left menu.</p>
<p>Next we will choose the option <em>new </em>and choose the option <em>other </em>from the drop-down menu. Standard the option is selected that this rule needs to be applied to <em>incoming </em>mails.</p>
<p>First we define the sender/recipient en exclusions.</p>
<p>First the recipient, this can be done by clicking on the link <em>recipient</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/recipient.jpg"><img class="alignnone size-thumbnail wp-image-905" title="recipient" src="https://myuclab.nl/wp-content/uploads/2008/10/recipient-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>As recipient we select all the users in the domain <em>trendmicro.dyndns.org</em></p>
<p>When you are responsible for multiple domains you can fill in all domains here. When all domains are added you can click on the <em>save </em>button. The next step is choosing the sender, this can be done by clicking on the link <em>sender. </em>Here we fill in the same domains as defined in the <em>recipient </em>option. When ready we will click on <em>save</em> again when all domains are added.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/sender.jpg"><img class="alignnone size-thumbnail wp-image-906" title="sender" src="https://myuclab.nl/wp-content/uploads/2008/10/sender-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The last option is to define the <em>exceptions, </em>this can be done when using a form on your website which uses an e-mail address which exists in your domain as the sender. In this case we choose the address <em><a href="mailto:info@trendmicro.dyndns.org">info@trendmicro.dyndns.org</a> </em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/exclude.jpg"><img class="alignnone size-thumbnail wp-image-907" title="Exclusions" src="https://myuclab.nl/wp-content/uploads/2008/10/exclude-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p><em></em>In this case we only allow from <a href="mailto:info@trendmicro.dyndns.org">info@trendmicro.dyndns.org</a> to <a href="mailto:info@trendmicro.dyndns.org">info@trendmicro.dyndns.org</a> but this can also be the complete domain.</p>
<p>When we have defined all three options it's time to define the <em>scanning conditions</em>. Here we only need to specify one thing. In this case we want to check every mail which is bigger then 1 Kb.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/size.jpg"><img class="alignnone size-thumbnail wp-image-908" title="Scanning conditions" src="https://myuclab.nl/wp-content/uploads/2008/10/size-150x68.jpg" alt="" width="150" height="68" /></a></p>
<p>When we are statisfied with the settings we click on <em>next </em>to continue and specify the <em>action.</em></p>
<p>Because we don't want the spoofing mails to arrive in the mailbox of users we select the option <em>delete entire message. </em>In case you want to first have a look what the result is you can choose the option <em>quarantine to</em> this will ensure that mail is placed in quarantine.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/action.jpg"><img class="alignnone size-thumbnail wp-image-909" title="action" src="https://myuclab.nl/wp-content/uploads/2008/10/action-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When the <em>action</em> is defined it's time for the last step, define the name and rulenumber. This last two fields can be defined with whatever you like. In our case we defined the name of the rule as <em>anti-spoofing </em>and placed it as the <em>8th </em>rule.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/rule.jpg"><img class="alignnone size-thumbnail wp-image-910" title="rule" src="https://myuclab.nl/wp-content/uploads/2008/10/rule-150x110.jpg" alt="" width="150" height="110" /></a></p>
<p>Were finished now with creating the anti-spoofing rule. Keep in mind that this wil also block mails from sites which let you forward articles and use your e-mail address as sender, inform your users about this.