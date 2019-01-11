---
id: 1306
title: Moving logs of a CCR enabled storage group
date: 2009-08-19T22:29:30+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=1306
permalink: /logs-verplaatsen-van-een-ccr-storage-group/
categories:
  - Tutorials
---
Logs verplaatsen van een normale storage group is niet zo heel moeilijk, in het geval van een storage groep waarvoor CCR is ingeschakeld dien je een aantal dingen goed in de gaten te houden.

Het verplaatsen van de logs is vaak een eenmalige actie. De eerste storage group die aangemaakt wordt tijdens de installatie zet zowel de logs als de checkpoint file op dezelfde schijf als de database zelf. Dit laatste is niet echt aan te raden. Het is beter om de logs en de checkpoint file op een andere schijf te plaatsen. In het geval van een recovery zijn namelijk deze bestanden erg belangrijk.

[open](http://johanveldhuis.nl/?page_id=1292)