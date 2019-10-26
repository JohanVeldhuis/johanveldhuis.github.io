---
id: 1096
title: Redirect port 80 to 443 with IIS
date: 2009-02-18T08:39:45+00:00
author: Johan Veldhuis
layout: post
guid: http://myuclab.nl/?p=1096
permalink: /redirect-port-80-to-443-with-iis/
categories:
  - Tutorials
---
I think you may have needed it in the passed, you want to prevent that users can access a website on port 80 but also want to prevent they got an error displayed. The script below is the solution for this issue, it will redirect the user to the https version of the website.

The script can be placed in the root of the webserver in case of IIS this is wwwroot.

_redirect.htm (<a href="http://www.raoulpop.com/2007/automatic-redirect-from-http-to-https/" target="_blank">bron</a>)_

```HTML
_<script language=&#8221;JavaScript&#8221;>__function goElseWhere()_

<!&#8211; begin hide

{

var oldURL = window.location.hostname + window.location.pathname;

var newURL = &#8220;https://&#8221; + oldURL;

window.location = newURL;

}

goElseWhere();

_// end hide &#8211;>_

</script>
```

The last step is to configure IIS to display this page instead of the default error page.

First how to do this in IIS 6.

Start the _IIS Manager_ and get the properties of the _default website_. Select the tab called _Custom Errors _and search for _HTTP error 403.4_ .

[<img class="alignnone size-thumbnail wp-image-1097" title="IIS 6 Custom error" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis6-customer-error-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis6-customer-error.jpg?resize=150%2C150&ssl=1 150w, https://i2.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2009/02/iis6-customer-error.jpg?zoom=2&resize=150%2C150&ssl=1 300w, https://i2.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2009/02/iis6-customer-error.jpg?zoom=3&resize=150%2C150&ssl=1 450w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis6-customer-error.jpg)

When found select it and push the _edit_ button, this will open the following window.

[<img class="alignnone size-thumbnail wp-image-1098" title="IIS 6 edit custom error" src="https://i1.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-edit-custom-error-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-edit-custom-error.jpg?resize=150%2C150&ssl=1 150w, https://i0.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2009/02/iis-edit-custom-error.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-edit-custom-error.jpg)

Select _browse_ and search for the file redirect.htm which you have placed in the root of IIS. Click on _OK _to select the file and click on _OK_ again to close the window above. A warning will be displayed that this error is also used by other virtual directories/websites. Click on _JOK_ and restart IIS.

To change the custom error in IIS 7 you must follow the steps below.

Open the _IIS Manager _and select the _Default Website,_ in the right part of the manager several icons are displayed.

[<img class="alignnone size-thumbnail wp-image-1100" title="IIS 7 customer error" src="https://i2.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error-150x110.jpg?resize=150%2C110" alt="" width="150" height="110" srcset="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error.jpg?resize=150%2C110&ssl=1 150w, https://i0.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2009/02/iis-7-custom-error.jpg?zoom=2&resize=150%2C110&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error.jpg)

Select the icon _Error Pages,_ an overview of default error pages will be displayed. Right click somewhere on the white space en select _add._ The following window will be displayed.

[<img class="alignnone size-thumbnail wp-image-1101" title="IIS 7 and define customer error" src="https://i0.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error-2-150x150.jpg?resize=150%2C150" alt="" width="150" height="150" srcset="https://i1.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error-2.jpg?resize=150%2C150&ssl=1 150w, https://i1.wp.com/myuclab.nl/wp-content/uploads//customers/myuclab.nl/myuclab.nl/httpd.www/wp-content/uploads/2009/02/iis-7-custom-error-2.jpg?zoom=2&resize=150%2C150&ssl=1 300w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](https://i1.wp.com/myuclab.nl/wp-content/uploads/2009/02/iis-7-custom-error-2.jpg)

Fill in the fields as specified below:

  * _status code:_ 403.4
  * _file path:_ %systemroot%\Inetpub\wwwroot\redirect.htm

Clickon _OK _and restart _IIS._

When visiting the site [http://webmail.domein.nl](http://webmail.domein.nl/) you will get redirected to [https://webmail.domein.nl](https://webmail.domein.nl/).