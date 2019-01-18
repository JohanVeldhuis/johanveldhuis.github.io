---
id: 273
title: Create transport rules for Exchange 2007
date: 2008-04-10T09:30:11+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=273
permalink: /create-exchange-2007-transport-rules/
categories:
  - Exchange
---
A new feature in Exchange 2007 is <em>Transport rules</em> this rules can be added in two ways, via the <em>Exchange Management Console</em> or via the <em>Exchange Management Shell</em>.

The transport rules will be created on the <em>Hub transport</em> <em>server. </em>The transport rules will be executed as follows:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/schema.jpg"><img class="alignnone size-thumbnail wp-image-274" title="Transport rules schema" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/schema-150x150.jpg" alt="" width="150" height="150" /></a>

When you choose to create the rules via the <em>Exchange Management Shell</em> you will see you will pass those steps.

Besides the parameters you can assign a priority to each <em>Transport Rule</em>. The priority start with 0, this rule has the highest priority. When a mail matches multiple rules all the rules will be applied to the mail, the priority will be used to make the decision in which order they will be applied. When you have created a rule you can adjust it very easy.

First we are going to create a <em>Transport Rule</em> via the <em>Exchange Management Console</em>. You have to start the <em>Exchange Management Console</em>  for this, next click on <em>Organizational Configuration</em>, <em>Hub Transport</em> and select the tab <em>Transport Rules.</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_1.jpg"><img class="alignnone size-thumbnail wp-image-276" title="Exchange Management Console" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_1-150x150.jpg" alt="" width="150" height="150" /></a>

Now click somewhere in the white space in the center of the screen and choose the option <em>New Transport Rule</em>, you can also do this on the right side of the screen. You will get the following screen:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_2.jpg"><img class="alignnone size-thumbnail wp-image-277" title="New Transport Rule" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_2-150x150.jpg" alt="" width="150" height="150" /></a>

Fill in the fields that are displayed, <em>Name</em> is the name you want to give to the <em>Transport Rule, Description</em>  is a short description of the rules. The checkmark before <em>Enable Rule </em>is enabled by default, when you don't want to use the rule immediately uncheck it, click on <em>next.</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_3.jpg"><img class="alignnone size-thumbnail wp-image-278" title="Conditions" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_3-150x150.jpg" alt="" width="150" height="150" /></a>

First we will select the <em>Conditions</em>, this are the conditions that a message has to have. This can be for example: all mail to external users

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_4.jpg"><img class="alignnone size-thumbnail wp-image-279" title="Rules" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_4-150x150.jpg" alt="" width="150" height="150" /></a>

The next step will be the <em>Rules </em>that are applied to the mail. In this case we will add a disclaimer to the e-mail.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_5.jpg"><img class="alignnone size-thumbnail wp-image-280" title="Exceptions" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_5-150x150.jpg" alt="" width="150" height="150" /></a>

You can see in the flowchart that we only need the define the <em>Exceptions.</em> In this case we don't want to add <em>exceptions</em> and click on <em>next</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_6.jpg"><img class="alignnone size-thumbnail wp-image-281" title="Summary" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_6-150x150.jpg" alt="" width="150" height="150" /></a>

Before the rule is created you will get a small summary of the parameters we defined. Click on <em>New</em> to create the <em>Transport Rule.</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_7.jpg"><img class="alignnone size-thumbnail wp-image-282" title="Rule completed" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_rule_step_7-150x150.jpg" alt="" width="150" height="150" /></a>

When you get the same screen as above the rule is created successfully and a disclaimer is added to all messages send to external users.

Now we created a <em>Transport Rule</em> via the <em>Exchange Management Console</em> it's time to create one via Powershell.

We will create a rule which blocks e-mails with the word <em>Finance</em> in the body or subject except when the mail is send from <em>Klaas Vaak.</em>

Normally you get give the Powershell command directly, but with a <em>Transport Rule </em>this is not the case. First we will define the values for the <em>conditions, rules </em>and <em>exceptions</em>and will use them in the Powershell command.

Below the script what what creates the <em>Transport Rule:</em>

```PowerShell

$Condition = Get-TransportRulePredicate SubjectOrBodyContains
$Condition.Words = @("Finance")
$Exception = Get-TransportRulePredicate From
$Exception.Addresses = @((Get-Mailbox "Klaas.Vaak"))
$Action = Get-TransportRuleAction RejectMessage
$Action.RejectReason = "E-mail messages sent from departments except the Finance department are prohibited."

New-TransportRule -name "Block e-mail messages with the word Finance" -Condition @($Condition) -Exception @($Exception) -Action @($Action)
```

The same as with the wizard the script will be separated in logical steps.

With <em>$Condition </em>we define the conditions which a mail should meet. You can do this by specifying the command <em>Get-TransportRulePredicate</em> followed by , in this case <em>SubjectOrBodyContains</em>.

The next step we will do is assign a value for the condition, we can those this with the parameter <em>$Condition.Words</em>. We will give the value after the - sign.

The next step is to define the exception, this will be done by the parameters <em>$Exception and</em><em> $Exception.Addresses</em>. With this we will tell Exchange to use the command <em>Get-TransportRulePredicate From</em> to get the value from the from field and assign the value to <em>$Exception.Addresses</em>.

The last parameter we define is the action that needs to be executed when a mail matches all requirements.  This is done by the parameters <em>$Action </em>and <em>$Action.RejectReason</em>, in this case we will send a message back to the sender with the following text <em>E-mail messages sent from departments except the Finance department are prohibited</em>.

Now we defined all parameters we can use the <em>New-TransportRule </em>to create the rule. The only extra parameter we need is <em>name </em>which defines the name of the rule. When we don't want to rule to be active after creation we need to add the parameter <em>Enabled $false</em>. The new rules will be assigned the lowest priority, can you change this by assigning the <em>Priority </em>parameter a numeric value.

I saved the script myself and executed it, the screen below shows the result:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_ps.jpg"><img class="alignnone size-thumbnail wp-image-283" title="Transport Rule made via Powershell" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/tr_ps-150x150.jpg" alt="" width="150" height="150" /></a>

The links below will direct you to the pages on Technet about the two commands:

New-TransportRule <a href="http://technet.microsoft.com/en-us/library/bb125138(EXCHG.80).aspx" target="_blank">open</a>

Get-TransportRulePredicate <a href="http://technet.microsoft.com/en-us/library/aa995960(EXCHG.80).aspx" target="_blank">open</a>