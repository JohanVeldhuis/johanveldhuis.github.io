---
id: 2285
title: New version of fix-alias.ps1
date: 2011-07-26T21:45:25+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2285
permalink: /nieuwe-versie-van-fix-alias-ps1/
categories:
  - Scripts
---
During a migration you may encounter the issue that incorrect aliasses are used, for exampe spaces or incorrect characters in the alias. Microsoft has published a nice script fix-alias.ps1. There are some limitations when using this script. Because of this I modified the script a bit and added the following features:

  * option to provide multiple search criteria;
  * option to provide a replacement per criteria;
  * option to check and fix the alias of Public Folders;

If you have additional whishes please let me know by leaving a comment or by contacting me via the contactform.

download <a href="http://gallery.technet.microsoft.com/scriptcenter/411aec4e-8c01-4594-b993-fbd968f15399" target="_blank">fix-alias.ps1</a> (original version)
  
download <a href="http://www.johanveldhuis.nl/tools/scripts/fix-aliasv20.ps1" target="_blank">fix-aliasv20.ps1</a>