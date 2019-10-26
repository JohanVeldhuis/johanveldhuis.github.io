---
id: 873
title: Block backscatter mails with Exchange 2007
date: 2008-10-04T20:50:33+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=873
permalink: /block-backscatter-mails-with-exchange-2007/
categories:
  - Tutorials
---
Backscatters are still active NDR's who will be delivered to companies where after some investigation the mail is never send from. There are a few possibilities to prevent this, one of this is with SPF records.</p>
<p>I went for some further investigation on how to block those irritating mails. I found out that it could be done with <em>Transport Rules </em>in Exchange 2007.</p>
<p>In this tutorial I will explain how you can configure to get rid of the irritating backscatters.</p>
<p>First we will create a transport rule which adds a tag to the header of an e-mail. With this we can recognize e-mails which are send from our own server.</p>
<p>We can do this by opening the EMC and go to the <em>Hub Transport Server </em>via the <em>Organizational Configuration. </em>After that we can open the tab <em>Transport Rules.</em></p>
<p>Next step is selecting the option to create a new <em>Transport Rule </em>in the right menu.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_1.jpg"><img class="alignnone size-thumbnail wp-image-874" title="New Transport Rule" src="https://myuclab.nl/wp-content/uploads/2008/10/step_1-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In this case we choose the following name <em>Add tag to header </em>but this can be any name you like. When you've choosen the name you like you will click on <em>next</em></p>
<p>On the next page we will select which conditions the mail must met before we will apply the <em>transport rule</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_2.jpg"><img class="alignnone size-thumbnail wp-image-875" title="Conditions" src="https://myuclab.nl/wp-content/uploads/2008/10/step_2-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Here we define that we want to apply the rule on every mail that is send to outside via the Hub Transport server. When this has been defined we click on <em>next</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_3.jpg"><img class="alignnone size-thumbnail wp-image-876" title="Action" src="https://myuclab.nl/wp-content/uploads/2008/10/step_3-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Next step is the action that needs to be executed. As I said earlier we want to add something to the header of the mail. We can do this by selecting the option <em>set header with value. </em>This rule will be added to the lower part of the screen. The only thing we need to specify is the values we want to add.</p>
<p>First we will define the tag itself</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_3a.jpg"><img class="alignnone size-thumbnail wp-image-877" title="Tag name" src="https://myuclab.nl/wp-content/uploads/2008/10/step_3a-150x126.jpg" alt="" width="150" height="126" /></a></p>
<p>We will give the tag the name <em>anti-spf , </em>this is a name you can change if you like, remember it because we will need it later on. Next we need to specify the value that we want to give to the tag. The best option is to give it a random value. This makes it a little bit harder to hack, but it's still possible because it's a static value</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_3b.jpg"><img class="alignnone size-thumbnail wp-image-878" title="Tag value" src="https://myuclab.nl/wp-content/uploads/2008/10/step_3b-150x126.jpg" alt="" width="150" height="126" /></a></p>
<p>When both values are defined we will click on <em>next</em></p>
<p>We will get a short summary en we can click on <em>next </em>to continue. When the rule is created succesfully we will get the screen below</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_4.jpg"><img class="alignnone size-thumbnail wp-image-879" title="Transport rule created" src="https://myuclab.nl/wp-content/uploads/2008/10/step_4-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>Each mail who is send to the outside world will get an extra tag in the header <em>anti-spf: 7uTreth2</em></p>
<p>The next step is to create a <em>Transport Rule </em>who checks if the NDR mail contains the tag.</p>
<p>To do this we will select the option to create a new <em>Transport Rule </em>in the right menu</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_5.jpg"><img class="alignnone size-thumbnail wp-image-880" title="New Transport Rule" src="https://myuclab.nl/wp-content/uploads/2008/10/step_5-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>We will give it a name, in this case <em>NDR Check, </em>and click on <em>next</em></p>
<p><a href="https://myuclab.nl/wp-content/uploads/2009/01/knipsel.jpg"><img class="alignnone size-thumbnail wp-image-1037" title="Edit Transport rule action" src="https://myuclab.nl/wp-content/uploads/2009/01/knipsel-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>The next step is to define the conditions the mail must met before we will apply the <em>Transport Rule. </em>In this case we chec:</p>
<ul>
<li>if the mail is send to internal <em>(sent to users inside your organization)</em></li>
<li>if the subjected contains <em>Returned mail </em><em>(Subject field contains specific words)</em></li>
</ul>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_6a.jpg"><img class="alignnone size-thumbnail wp-image-882" title="Subject field values" src="https://myuclab.nl/wp-content/uploads/2008/10/step_6a-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When selecting the option <em>Subject field contains </em>don't forget to add the value <em>Returned mail </em>manually.</p>
<p>The next step is to define the <em>action</em> that needs to be executed</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_7.jpg"><img class="alignnone size-thumbnail wp-image-883" title="Transport Rule actions" src="https://myuclab.nl/wp-content/uploads/2008/10/step_7-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>In this case we define that</p>
<ul>
<li>an item should be logged in the event log with the text <em>NDR Check</em></li>
<li>the mail should not be delivered</li>
</ul>
<p>It can be that the action <em>drop the message </em>is OK for you, in this case you only need to select this one. When you are satisfied with the settings click on <em>next.</em></p>
<p>The last step is to define the <em>exceptions, </em>if we don't do it all mails to internal users with the text <em>Returned mail </em>will be dropped. This is not what we want because this would cause legal <em>NDR's</em> also to be dropped.</p>
<p>By checking the <em>body </em>of the mail for the text <em>anti-spf: 7uTreth2 </em>we can prevent that legal NDR's will be blocked.</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_8.jpg"><img class="alignnone size-thumbnail wp-image-884" title="Exceptions" src="https://myuclab.nl/wp-content/uploads/2008/10/step_8-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>When this is defined we click on <em>next </em>en the rule will be created. When the rule is created succesfully you will get the screen below</p>
<p><a href="https://myuclab.nl/wp-content/uploads/2008/10/step_9.jpg"><img class="alignnone size-thumbnail wp-image-885" title="Transport Rule created" src="https://myuclab.nl/wp-content/uploads/2008/10/step_9-150x150.jpg" alt="" width="150" height="150" /></a></p>
<p>I must admit that it will cost you some time to create the rules but it wil save you a lot of calls from users with questions about NDR's.