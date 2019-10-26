---
id: 3368
title: SefaUtil GUI v2
date: 2015-09-07T21:26:48+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=3368
permalink: /sefautil-gui-v2/
categories:
  - Scripts
---
With pleasure I present you SefaUtil GUI v2. First thanks to all the beta tester which provided a lot of good feedback which has been incorporated in the tool.

[<img class="alignnone size-medium wp-image-3369" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2-300x161.png?resize=300%2C161" alt="SefaUtil v2" width="300" height="161" srcset="https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png?resize=300%2C161&ssl=1 300w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png?resize=1024%2C550&ssl=1 1024w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png?resize=900%2C483&ssl=1 900w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png?w=1525&ssl=1 1525w, https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png?w=1254&ssl=1 1254w" sizes="(max-width: 300px) 100vw, 300px" data-recalc-dims="1" />](https://i2.wp.com/myuclab.nl/wp-content/uploads/2015/09/SefaUtil_v2.png)

So know you probably want to know what has improved?

**SQL querying**

Well several things have been improved but most improved piece is retrieving the current settings. As you may know Sefautil signs in for every action which you executie: both query and change. Greig Sheridan (@greiginsydney) pointer me to the script of James Cussen which contained soms SQL to query certain databases for Lync. Based on that script I started the research on how I could user those scripts in SefaUtil GUI. It took soms time but in this version querying the setting for a user is performed by using SQL queries. This speeds up the process amazingly. Changing settings is still performed by invoking SefaUtil.exe

**Pool switching**

The GUI now contains an option to switch from pools. So if you have multiple pools you can now easily switch by using the GUI. This will safe you time because you now don&#8217;t have to reload the tool. In addition to this the user list now only contains the users homed on that pool. The delegates list still is the long list which contains all Enterprise Voice enabled users.

**Backup and recovery**

An option has been introduced to backup & recovery your SefaUtil settings.  Please test this functionality yourself before using it in production. As far as I have tested I it worked good for me but I strongly encourage you to test it in a lab environment prior to restoring settings in production.

**Skype for Business support**

Skype for Business is available for a while so I added support for this also. Keep in mind this will user a different version of SefaUtil.exe compared to the one for Lync 2013.

**Parameters**

Additional parameters have been added most on request:

  * SfB2015: Could be used to overwrite the default location of SefaUtil for Skype for Business Server 2015
  * Groupiddigits: Could be used to overwrite amount of digits used for team calls incl. # if used, default value is 3
  * Loaddata: Can be used to prevent to automatically load data

Besides this a lot of code optimization has been performed and several bugs have been fixed.

As with all software despite the heavy testing you might find an issue. If so please let me know so I can assist you with troubleshooting the issue and make code changes if necessary so other people can benefit from it.

SefaUtil GUI V2 van be downloaded via the link below:

<div class='w3eden'>
  <!-- WPDM Link Template: Default Template -->
  
  <div class="wpdm-link-tpl link-btn [color]" data-durl="https://myuclab.nl/?post_type=wpdmpro&p=3372&wpdmdl=3372" >
    <div class="media">
      <div class="pull-left">
        <img class="wpdm_icon" alt="Icon" src="https://myuclab.nl/wp-content/plugins/download-manager/assets/file-type-icons/ps1.svg" onError='this.src="https://myuclab.nl/wp-content/plugins/download-manager/assets/file-type-icons/unknown.svg";' />
      </div>
      
      <div class="media-body">
        <strong class="ptitle"><!--:en-->SefaUtil GUI V2
        
        <!--:-->
        
        <!--:nl-->SefaUtil GUI V2
        
        <!--:-->
        
        <span class="label label-default" style="font-weight: 400;">106.88 KB</span></strong> 
        
        <div>
          <strong><a class='wpdm-download-link btn btn-primary ' rel='nofollow' href='#' onclick="location.href='https://myuclab.nl/?post_type=wpdmpro&p=3372&wpdmdl=3372';return false;">Download</a></strong>
        </div>
      </div>
    </div>
  </div>
  
  <div style="clear: both">
  </div>
</div>