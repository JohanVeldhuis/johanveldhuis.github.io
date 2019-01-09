---
id: 618
title: 'Virtual PC won&#8217;t show console anymore'
date: 2008-08-08T23:00:45+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=618
permalink: /virtual-pc-laat-console-niet-meer-zien/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Blog
---
[<img class="alignnone size-thumbnail wp-image-617" title="Virtual -C" src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2008/08/virtual-pc-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" srcset="https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/08/virtual-pc.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/johanveldhuis.nl/wp-content/uploads//customers/johanveldhuis.nl/johanveldhuis.nl/httpd.www/wp-content/uploads/2008/08/virtual-pc.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2008/08/virtual-pc.jpg)

Since yesterday I had a nice issue with Virtual PC, the console wouldn&#8217;t open anymore. The icon was visible in the taskbar so I could start a VM from there. After some searching on the internet I found out that I was nog the only one who had this issue, below 3 solutions I found that you could try:

  * Close Virtual PC and delete the following file <span style="color: #000080; font-family: Courier New;">%appdata%\Microsoft\Virtual PC\Options.xml</span>.  Warning!, all you gloab configuration settings will be lost.
  * Use this <a href="http://blogs.msdn.com/virtual_pc_guy/archive/2006/05/16/599615.aspx" target="_blank">page</a> as an example to edit the Options.xml, change the values of left\_position and top\_position to a smaller value.
  * Start Virtual PC and press _ALT, Left Arrow, Down Arrow, m, Left Arrow_ and move the mouse, you should be able to see the console again.

If this tips won&#8217;t work then the only solution is to reinstall Virtual PC, in my case this was the solution 😉