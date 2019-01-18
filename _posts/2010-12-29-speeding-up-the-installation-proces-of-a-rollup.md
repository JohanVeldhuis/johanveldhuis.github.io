---
id: 2070
title: Speeding up the installation proces of a rollup
date: 2010-12-29T15:09:08+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2070
permalink: /speeding-up-the-installation-proces-of-a-rollup/
categories:
  - Exchange
---
The process of installing a rollup for Exchange 2010 can take a lot of time when you have a bad/no internet connection. One of the causes for this is the validation process of the digital signature of the .NET Framework components. When having a bad/no internet connection this can slow down the process, this because of the default time-out of 15000 miliseconds for a single CRL check up to 20000 miliseconds for checking all CRL&#8217;s.

A while ago the Microsoft Exchange team posted a <a href="http://msexchangeteam.com/archive/2010/05/14/454877.aspx" target="_blank">blog</a> what you can do to increase this time. This can be done by making changes in the registry which will, for example, increase the default time-out.

Starting from Exchange 2010 SP1 rollup 2 a new feature is introduced. The setup will check if CRL checking is enabled and if so it will prompt you with a warning:

[<img title="Exchange 2010 SP1 Rollup setup" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/warning-300x129.jpg?resize=300%2C129" alt="" width="300" height="129" data-recalc-dims="1" />](https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/warning.jpg)

To solve this issue you might decide to turn off CRL checking temporarily, this can be done by performing the following steps:

  * start Internet Explorer
  * go to _Tools_
  * select _Internet Options_
  * select the tab_ Advanced_
  * search for the _Security_ item
  * disable the following option: _Check for publisher&#8217;s certificate revocation_

[<img title="Internet Explorer: advanced settings" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/ie-settings-300x81.jpg?resize=300%2C81" alt="" width="300" height="81" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/ie-settings.jpg)

Restart the setup and you won&#8217;t get the warning again. Disabling this option is not a best practice of  course because the digital signature isn&#8217;t checked. So disable this option only if you have no or a very bad internet connection.

Don&#8217;t forget to enable the option once finished installing the rollup.