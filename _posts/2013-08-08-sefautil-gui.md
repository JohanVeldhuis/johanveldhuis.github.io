---
id: 3241
title: SefaUtil GUI
date: 2013-08-08T22:04:39+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=3241
permalink: /sefautil-gui/
ratings_users:
  - "0"
ratings_score:
  - "0"
ratings_average:
  - "0"
categories:
  - Scripts
---
If you have worked with Lync Enterprise voice then you have probably used Sefautil (secondary extension feature activation). A cmdline tool which allows you to configure several settings related to enterprise voice for example:

  * call forward
  * simultaneous ringing
  * call pickup (only Lync 2013)

A cmdline works OK but because you forget the parameters which you can use it maybe hard sometimes. To make this a lot easier I developed a wrapper around the tool: SefaUtil GUI.

[<img src="https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2013/08/SefaUtil-GUI-300x159.png?resize=300%2C159" alt="SefaUtil GUI" width="300" height="159" data-recalc-dims="1" />](https://i2.wp.com/johanveldhuis.nl/wp-content/uploads/2013/08/SefaUtil-GUI.png)

The tool is based on a Powershell script and allows you to configure the same functionalities as the cmdline tool does only then via a GUI. The tool contains two tabs. The first tab _Main_ contains all the functions. On the second tab _Info_ you can find some diagnostic info such as the Lync Server version, the directory where Sefautil is located and logging information. The logging which is created can be exported by pressing a button so you can review what has changed.

**Installation**

The script needs to be placed on a machine where the Sefautil tool is installed. A detailed description of how to install Sefautil can be found on this page: [Deploy the SEFAUtil tool](http://technet.microsoft.com/en-us/library/jj945659.aspx).

Besides the tool you will need to install the Lync Core components.

In some cases it is necessary to change the executionpolicy for the script, more info can be found on this page: <a href="http://technet.microsoft.com/en-us/library/ee176961.aspx" target="_blank">Using the Set-ExecutionPolicy Cmdlet</a>.

You can start the tool like this: _start-sefautil -pool poolfqdn_

**Download**

<div class='w3eden'>
  <!-- WPDM Link Template: Default Template -->
  
  <div class="wpdm-link-tpl link-btn [color]" data-durl="https://johanveldhuis.nl/?post_type=wpdmpro&p=3361&wpdmdl=3361" >
    <div class="media">
      <div class="pull-left">
        <img class="wpdm_icon" alt="Icon" src="https://johanveldhuis.nl/wp-content/plugins/download-manager/assets/file-type-icons/zip.svg" onError='this.src="https://johanveldhuis.nl/wp-content/plugins/download-manager/assets/file-type-icons/unknown.svg";' />
      </div>
      
      <div class="media-body">
        <strong class="ptitle"><!--:en-->SefaUtil GUI
        
        <!--:-->
        
        <!--:nl-->SefaUtil GUI
        
        <!--:-->
        
        <span class="label label-default" style="font-weight: 400;">7.54 KB</span></strong> 
        
        <div>
          <strong><a class='wpdm-download-link btn btn-primary ' rel='nofollow' href='#' onclick="location.href='https://johanveldhuis.nl/?post_type=wpdmpro&p=3361&wpdmdl=3361';return false;">SefaUtil Gui v1.0</a></strong>
        </div>
      </div>
    </div>
  </div>
  
  <div style="clear: both">
  </div>
</div>