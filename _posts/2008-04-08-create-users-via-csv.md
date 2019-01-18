---
id: 273
title: Create users via CSV
date: 2008-04-08T20:16:42+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=273
permalink: /create-users-via-csv/
categories:
  - Exchange
---
As you may now you can do many things with Powershell to get things done in Exchange. Somethings can only be done via Powershell.

One of those things is creating users via a CSV file, it's really usefull when you need to create a lot of users in one time. You can make it as nice as you want if you have the information available in the CSV file.

We could type in the command each time to read the CSV file and then create the users, but why shouldn't we do it via a Powershell script ?

A Powershell script can be made with <em>Notepad</em>, the only thing you need to do is save the file with an <em>.ps1</em> extension.

Below the script that we are gone use:

```PowerShell
Param(
[string] $MailboxTemplate,
[string] $CSVFile
)

$Temp = ConvertTo-SecureString P@ssw0rd -asPlainText -Force

$Template = Get-Mailbox "$MailboxTemplate"

Import-CSV $CSVFile | ForEach-Object -Process {New-Mailbox -Name $_.Name -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UPN -OrganizationalUnit $_.OU -Database "First Storage Group\Mailbox Database" -Password $Temp -TemplateInstance $Template}
```

<em></em>First we arrange that we can give some parameters while executing the file, this parameters we need to execute the script, in this script we have 2 parameters:
<ul>
	<li><em>$MailboxTemplate</em>, the name of the template-mailbox (string)</li>
	<li><em>$CSVFile</em>, the name of the csv file (string)</li>
</ul>
All parameters should be supplied as a string format, except the password. It isn't possible to use a password in a script without modifying it first. To prepare the password for using it in the script we need to put in the following piece in the script:

<em>$Temp = ConvertTo-SecureString P@ssw0rd -asPlainText -Force</em>

We will set the $Temp to be equal against the <em>protected string </em>that is generated from <em>P@ssword</em>

<em>$Template = Get-Mailbox "$MailboxTemplate"</em>

The next step is to arrange that <em>$Template</em> gets the value of the output of the command. The command will get the mailbox name containing the name that was specified with the <em>%MailTemplate </em>parameter. This is a mailbox that we will create before we execute the script as a template for all new mailboxes.

When all parameters are specified we can run the command. To import a CSV file we use the <em>CSV-import</em>  command.

```PowerShell
Import-CSV $CSVFile | ForEach-Object -Process {New-Mailbox -Name $_.Name -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UPN -OrganizationalUnit $_.OU -Database "First Storage Group\Mailbox Database" -Password $Temp -TemplateInstance $Template}
```

This rule can be cut in to pieces:
<ul>
	<li><em>Import-CSV $CSVFile</em>, with this piece we will arrange that the file being specified as the parameter <em>$CSVFile </em>will be imported.</li>
	<li><em>ForEach-Object -Process</em>, this command will tell the script to run every following command between the acolades will need to be run when a new line is read from the CSV fil</li>
	<li><em>{New-Mailbox -Name $_.Name </em><em>-FirstName $_.FirstName</em><em> -LastName $_.LastName</em><em>-UserPrincipalName $_.UPN -OrganizationalUnit $_.OU -Database "First Storage Group\Mailbox Database" -Password $Temp -TemplateInstance $Template}</em>, in the last pieve we will replace all parameters with values from the CSV file. In this case the mailbox will be created in the <em>First Storage Group </em>in the <em>Mailbox Database </em>database</li>
</ul>
The script needs to be saved in the script directory. This directory can be found in the install directory of Exchange 2007.

Before executing the script we need to do two things:
<ul>
	<li>create the template</li>
	<li>create the CSV file</li>
</ul>
The template is really easy, it's the same as creating a default user only we will use it as a template.

We will create the template via the<em>Exchange Management Console</em>, I guess you have used it a few times and start with the <em>wizard.</em>

[<img class="alignnone size-thumbnail wp-image-265" title="Add new user" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_1-150x150.jpg" alt="" width="150" height="150" srcset="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_1-150x150.jpg 150w" sizes="(max-width: 150px) 100vw, 150px" data-recalc-dims="1" />](http://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_1.jpg)


We will try to complete all fields, choose a name that you can easily recognize, for example <em>_template</em>

When finished click next <em>next</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_2.jpg"><img class="alignnone size-thumbnail wp-image-266" title="New Mailbox" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_2-150x150.jpg" alt="" width="150" height="150" /></a>

In the screen above it's important to choose the correct <em>Mailbox Server</em>, this will be used for all users who are created via this template. The <em>Storage Group</em>will be hardcoded in the script.

When the user is created you can get the <em>properties</em> of the user and go to the tabs <em>Address and Phone</em>and <em>Organization </em>and fill in the fields that are generic for each user. This is optional and you can choose to do this also via the script, for this you need to add some extra fields to the csv and extra code to the script to import these fields.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_3.jpg"><img class="alignnone size-thumbnail wp-image-267" title="Address and Phone" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_3-150x150.jpg" alt="" width="150" height="150" /></a>

Some values will be automaticly assigned to new users: <em>City</em>and <em>Country/Region</em>, this will ensure that it doesn't cost you a lot of time to fill it in manually. Some values are not being parsed, fields such as <em>Zip-Code</em> and<em> Street Address </em>are examples of this.

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_4.jpg"><img class="alignnone size-thumbnail wp-image-268" title="Organization" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_4-150x150.jpg" alt="" width="150" height="150" /></a>

If you want to create users in different departments, it may be easier to create multiple templates. This because I haven't found out how you can specify using the <em>new-mailbox </em>command.

Now that we have created the <em>template mailbox </em>we only need to create the CSV file, this can be done via Notepad or <em>Excel. </em>I created a CSV myself in <em>Notepad.</em>

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_5.jpg"><img class="alignnone size-thumbnail wp-image-269" title="Users.csv file" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_5-150x150.jpg" alt="" width="150" height="150" /></a>

Now that we have done all preparations it's just a matter of running the script. You need to execute the script via the <em>Exchange Management Shell</em>:

```PowerShell
CreateNewUser.ps1 -MailboxTemplate "_Template_Rotterdam" -CSVFile "c:\users.csv"
```

When the script is completed you will have the following result:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_6.jpg"><img class="alignnone size-thumbnail wp-image-270" title="Users created by Powershell" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_6-150x150.jpg" alt="" width="150" height="150" /></a>

After a <em>refresh, </em>when the <em>Exchange Management Console</em>open is left open, you can see the users there too.

As promissed a the extra piece of script that will arrange that the fiels from the <em>Address and Phone </em>en <em>Organization </em>tab will be used:

```PowerShell
|Set-User -Department $_.Department -Office $_.Office -Phone $_.Telephone -StreetAddress $_.Street -City $_.city -PostalCode $_.PostalCode -CountryOrRegion $_.CountryOrRegion
```

The piece between the accolades now looks like this:

```PowerShell
{New-Mailbox -Name $_.Name -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UPN -OrganizationalUnit $_.OU -Database "First Storage Group\Mailbox Database" -Password $Temp -TemplateInstance $Template |Set-User -Department $_.Department -Office $_.Office -Phone $_.Telephone -StreetAddress $_.Street -City $_.city -PostalCode $_.PostalCode -CountryOrRegion $_.CountryOrRegion}
```

The CSV file needs to be extended with the values of the fields:

<em>Name,FirstName,LastName,UPN,OU,Department,Office,Telephone,Street,PostalCode,City</em>

A user will now look like this:

<em>Pietje Puk,Pietje,Puk,Pietje.Puk@test.local,test.local/Rotterdam,IT,Rotterdam,010-1234567,Coolsingel 111,2332 ZZ,Rotterdam</em>

Executing the script goes the same:

```PowerShell
CreateNewUser.ps1 -MailboxTemplate "_Template_Rotterdam" -CSVFile "c:\users.csv"
```

In the <em>Exchange Management Shell </em>you don't really get a good output, therefor we need to look in the <em>Exchange Management Console</em>:

<a href="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_7.jpg"><img class="alignnone size-thumbnail wp-image-271" title="Organization properties of user" src="https://johanveldhuis.nl/wp-content/uploads/2008/04/bulk_user_7-150x150.jpg" alt="" width="150" height="150" /></a>

This is the end of this tutorial, it's quite a long one I think, but it's very useful when you need to create multiple users in Exchange 2007.