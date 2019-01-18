---
id: 1042
title: Use regular expressions in Exchange 2007
date: 2009-01-29T00:47:03+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1042
permalink: /use-regular-expressions-in-exchange-2007/
categories:
  - Exchange
---
In the transport rules from Exchange 2007 you can use regular expressions. This can let you block specific words. But what happens in some cases is that correct words are also blocked because they contain the blocked specified character pattern. You can prevent this by using one or more of the parameters below:

<table border="0">
  <tr>
    <td>
      <strong>parameter</strong>
    </td>
    
    <td>
      <strong>description</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\S</code>
    </td>
    
    <td>
      <code>\S</code> can be used to replace a single character which is not a space.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\s</code>
    </td>
    
    <td>
      <code>\s</code> can be used to replace a single white-space.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\D</code>
    </td>
    
    <td>
      <code>\D</code> can be used to match any non-numeric digit.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\d</code>
    </td>
    
    <td>
      <code>\d</code> can be used to match a single digit.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\w</code>
    </td>
    
    <td>
      <code>\w</code> can be used to search for a character which is a Unicode character from the category letter or number.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>|</code>
    </td>
    
    <td>
      The pipe ( <code>|</code> ) character can be used to create an OR function.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>*</code>
    </td>
    
    <td>
      The wildcard ( <code>*</code> ) character matches zero or more instances of the character before the parameter.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>( )</code>
    </td>
    
    <td>
      Characters between the () will be grouped, this makes it possible to search for a specific character pattern.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>\\</code>
    </td>
    
    <td>
      The 2 backslashes can be used to escape a specific character, for example \\d can be used to search for the pattern \d in an expression.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>^</code>
    </td>
    
    <td>
      <code>The </code><code>^</code> character can be used to match a pattern which starts with a specific pattern.
    </td>
  </tr>
  
  <tr>
    <td>
      <code>$</code>
    </td>
    
    <td>
      The $ character can be used to search for a pattern which ends with a specific character pattern.
    </td>
  </tr>
</table>

As you can see there are a lot of possibilities. It may cost a lot of time to figure out which filter works the best in your situation.

More info can be found on the Technet article below.

<a href="http://technet.microsoft.com/en-us/library/aa997187.aspx" target="_blank">Regular Expressions in Transport Rules</a>