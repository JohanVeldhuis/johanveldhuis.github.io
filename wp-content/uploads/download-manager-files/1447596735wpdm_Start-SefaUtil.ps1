<#
.SYNOPSIS
Start-SefaUtil.ps1 - GUI wrapper for Sefautil cmdline tool

.DESCRIPTION 
Provides the same functionality as Sefautil only via a GUI.

Before using the script verify the following rules in the variable section and change where necessary

lyncserver: fqdn of your Lync Front End
lync2010: location of Sefautil for Lync 2010
lync2013: location of Sefautil for Lync 2013
digits: the amount of digits used for team calls (incl. # if used)

.OUTPUTS
N.A.

.PARAMETER Pool
Could be used to define the pool name when running the cmdlet instead of hardcoding it in the script

.PARAMETER Lync2010
Could be used to overwrite the default location of Sefautil for Lync 2010

.PARAMETER Lync2013
Could be used to overwrite the default location of Sefautil for Lync 2013

.PARAMETER SfB2015
Could be used to overwrite the default location of Sefautil for Skype for Business Server 2015

.PARAMETER Groupiddigits
Could be used to overwrite amount of digits used for team calls incl. # if used, default value is 3

.PARAMETER Loaddata
Can be used to prevent to automatically load data

.EXAMPLE
.\Start-SefaUtil.ps1 -Pool fe01.domain.com
Stars Sefautil and uses fe01.domain.com to make the changes

.EXAMPLE
.\Start-SefaUtil.ps1 -Pool fe01.domain.com -Lync2013 'd:\Program Files\Microsoft Lync Server 2013\Reskit\SEFAUtil.exe'
Start Sefautil and uses fe01.domain.com to make the changes and uses Sefautil which is located in 
d:\Program Files\Microsoft Lync Server 2013\Reskit\

.EXAMPLE
.\Start-SefaUtil.ps1 -Pool fe01.domain.com -Groupiddigits 4
Stars Sefautil and uses fe01.domain.com to make the changes and set the amount of digits for team calls to 4

.LINK
SQL Queries based on James Cussens script: http://www.myskypelab.com/2013/10/lync-2013-call-pickup-group-manager.html

.NOTES
Written By: Johan Veldhuis
Website:    http://www.johanveldhuis.nl
Twitter:    http://twitter.com/jveldh

Change Log
v2.0 02/09/2015 - Replaced Sefautil queries by SQL queries, introduced backup and restore solution, added new parameter digits, 
                  added new button to suggest delelagates based on same manager. Added Skype for Business Server 2015 support.
                  Added button to switch pools and a lot of code optimization.
V1.0, 08/08/2013 - Initial version
#>
#requires -version 2

#...................................
# Variables
#...................................
[CmdletBinding(SupportsShouldProcess = $True)]
Param (
[parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
[ValidateNotNullOrEmpty()]
[string]$Pool = $NULL,
[parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
[string]$Lync2010 = 'c:\Program Files\Microsoft Lync Server 2010\Reskit\SEFAUtil.exe',
[parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
[string]$Lync2013 = 'c:\Program Files\Microsoft Lync Server 2013\Reskit\SEFAUtil.exe',
[parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
[string]$SfB2015 = 'c:\Program Files\Skype for Business Server 2015\Reskit\SEFAUtil.exe',
[parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
[string]$Groupiddigits = '3',
[bool]$Loaddata=$true
)

#...................................
# Initialize
#...................................
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module Lync -ErrorAction Stop

$dc = (Get-ADDomainController -discover -forcediscover -nextclosestsite).HostName[0]
$poolversion = (Get-CsService -PoolFqdn $pool -registrar).Version
$pools =@()
$pools = Get-CsService -registrar|select PoolFQDN,Version

if($poolversion -eq '5'){
	$script:SEFAUtilPath = $Lync2010
	$script:Version = '2010'
	Set-Alias SEFAUTIL $SEFAUtilPath -Scope global
	If (Test-Path $SEFAUtilPath`){
	$detected = $true
	}
	Else{
	Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	$detected = $false
	}
}
Elseif ($poolversion -eq '6'){
	$script:SEFAUtilPath = $Lync2013
	$script:Version = '2013'
	Set-Alias SEFAUTIL $SEFAUtilPath -Scope global
	If (Test-Path $SEFAUtilPath){
	$detected = $true
    $server=$pool
	}
	Else{
	Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	$detected = $false
	}
}
Elseif ($poolversion -eq '7'){
	$script:SEFAUtilPath = $SfB2015
	$script:Version = 'SfB2015'
	Set-Alias SEFAUTIL $SEFAUtilPath -Scope global
	If (Test-Path $SEFAUtilPath){
	$detected = $true
    $server=$pool
	}
	Else{
	Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	$detected = $false
	}
}
Else{
	$detected = $false
}

#...................................
# Script
#...................................

function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 7/29/2013 10:52 PM
# Generated By: j.veldhuis
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname('System.Windows.Forms') | Out-Null
[reflection.assembly]::loadwithpartialname('System.Drawing') | Out-Null
#endregion

#region Generated Form Objects
$form = New-Object System.Windows.Forms.Form
$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$tabControl1 = New-Object System.Windows.Forms.TabControl
$tabInfo = New-Object System.Windows.Forms.TabPage
$BTN_CLEAR_LOG = New-Object System.Windows.Forms.Button
$BTN_SAVE_LOG = New-Object System.Windows.Forms.Button
$LB_LAST_CMDLET = New-Object System.Windows.Forms.Label
$TB_LOG = New-Object System.Windows.Forms.TextBox
$TB_SEFAUtil_LOC = New-Object System.Windows.Forms.TextBox
$LB_SEFAUTIL_LOC = New-Object System.Windows.Forms.Label
$TB_LYNC_VER = New-Object System.Windows.Forms.TextBox
$LB_LYNC_VER = New-Object System.Windows.Forms.Label
$LB_DIAGNOSTIC = New-Object System.Windows.Forms.Label
$tabMain = New-Object System.Windows.Forms.TabPage
$CB_SIM_RING_DEST = New-Object System.Windows.Forms.ComboBox
$CB_POOLS = New-Object System.Windows.Forms.ComboBox
$LB_POOLS = New-Object System.Windows.Forms.Label
$BTN_CHG_POOLS = New-Object System.Windows.Forms.Button
$BTN_SEARCH_DEL = New-Object System.Windows.Forms.Button
$TB_FWD_DEST = New-Object System.Windows.Forms.TextBox
$LB_FWD_DEST = New-Object System.Windows.Forms.Label
$LB_TIME_FORMAT = New-Object System.Windows.Forms.Label
$BTN_REM_TEAM_M = New-Object System.Windows.Forms.Button
$LB_Options = New-Object System.Windows.Forms.Label
$LB_Delegates = New-Object System.Windows.Forms.Label
$LB_Users = New-Object System.Windows.Forms.Label
$TB_GRP_PICKUP_NR = New-Object System.Windows.Forms.TextBox
$LB_GRP_PICKUP = New-Object System.Windows.Forms.Label
$LB_SIM_RING = New-Object System.Windows.Forms.Label
$TB_SIM_RING_DEST = New-Object System.Windows.Forms.TextBox
$CB_GRP_PICKUP = New-Object System.Windows.Forms.CheckBox
$CB_SIM_RING = New-Object System.Windows.Forms.Radiobutton
$CB_SIM_RING_TEAM = New-Object System.Windows.Forms.Radiobutton
$BTN_REM_DEL = New-Object System.Windows.Forms.Button
$LB_SourceUsers = New-Object System.Windows.Forms.ListBox
$CB_SIM_RING_DEL = New-Object System.Windows.Forms.RadioButton
$LB_DelegateUsers = New-Object System.Windows.Forms.ListBox
$CB_FWD_TO_DEL = New-Object System.Windows.Forms.Radiobutton
$LB_User_Details = New-Object System.Windows.Forms.ListBox
$BTN_Apply = New-Object System.Windows.Forms.Button
$BTN_Refresh = New-Object System.Windows.Forms.Button
$BTN_Load = New-Object System.Windows.Forms.Button
$CB_FWD_Immediate = New-Object System.Windows.Forms.Radiobutton
$LB_User_ring_time = New-Object System.Windows.Forms.Label
$CB_FWD_NOANSWER = New-Object System.Windows.Forms.Radiobutton
$TB_User_Ringtime = New-Object System.Windows.Forms.TextBox
$TAB_BCK_REST = New-Object System.Windows.Forms.TabPage
$BTN_BACKUP_ALL = New-Object System.Windows.Forms.Button
$BTN_RESTORE_ALL = New-Object System.Windows.Forms.Button
$CB_DISABLE_ALL = New-Object System.Windows.Forms.Radiobutton
$statusBar = New-Object System.Windows.Forms.StatusBar
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.


$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 502
$System_Drawing_Size.Width = 1000
$form.ClientSize = $System_Drawing_Size
$form.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Name = 'form'
$form.Text = 'Sefautil Gui 2.0'
$form.add_Load({initialize})

$tabControl1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 0
$System_Drawing_Point.Y = -1
$tabControl1.Location = $System_Drawing_Point
$tabControl1.Name = 'tabControl1'
$tabControl1.SelectedIndex = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 475
$System_Drawing_Size.Width = 1000
$tabControl1.Size = $System_Drawing_Size
$tabControl1.TabIndex = 11

$form.Controls.Add($tabControl1)

$tabMain.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 4
$System_Drawing_Point.Y = 22
$tabMain.Location = $System_Drawing_Point
$tabMain.Name = 'tabMain'
$System_Windows_Forms_Padding = New-Object System.Windows.Forms.Padding
$System_Windows_Forms_Padding.All = 3
$System_Windows_Forms_Padding.Bottom = 3
$System_Windows_Forms_Padding.Left = 3
$System_Windows_Forms_Padding.Right = 3
$System_Windows_Forms_Padding.Top = 3
$tabMain.Padding = $System_Windows_Forms_Padding
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 449
$System_Drawing_Size.Width = 861
$tabMain.Size = $System_Drawing_Size
$tabMain.TabIndex = 0
$tabMain.Text = 'Main'
$tabMain.UseVisualStyleBackColor = $True

$tabControl1.Controls.Add($tabMain)

$CB_SIM_RING_DEST.DataBindings.DefaultDataSourceUpdateMode = 0
$CB_SIM_RING_DEST.Enabled = $False
$CB_SIM_RING_DEST.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 730
$System_Drawing_Point.Y = 176
$CB_SIM_RING_DEST.Location = $System_Drawing_Point
$CB_SIM_RING_DEST.Name = "CB_FWD_DEST"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 21
$System_Drawing_Size.Width = 183
$CB_SIM_RING_DEST.Size = $System_Drawing_Size
$CB_SIM_RING_DEST.TabIndex = 25
$CB_SIM_RING_DEST.add_Leave({SET_CHG_SIM_RING_DEST})
$tabMain.Controls.Add($CB_SIM_RING_DEST)

$CB_POOLS.DataBindings.DefaultDataSourceUpdateMode = 0
$CB_POOLS.Enabled = $True
$CB_POOLS.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 730
$System_Drawing_Point.Y = 200
$CB_POOLS.Location = $System_Drawing_Point
$CB_POOLS.Name = "CB_POOLS"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 183
$CB_POOLS.Size = $System_Drawing_Size
$CB_POOLS.TabIndex = 25
#$CB_POOLS.add_Leave({SET_CHG_POOLS})
$tabMain.Controls.Add($CB_POOLS)

$LB_POOLS.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 566
$System_Drawing_Point.Y = 200
$LB_POOLS.Location = $System_Drawing_Point
$LB_POOLS.Name = 'LB_SIM_RING'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 160
$LB_POOLS.Size = $System_Drawing_Size
$LB_POOLS.TabIndex = 16
$LB_POOLS.Text = 'Change pool'
$tabMain.Controls.Add($LB_POOLS)

$BTN_CHG_POOLS.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 920
$System_Drawing_Point.Y = 200
$BTN_CHG_POOLS.Location = $System_Drawing_Point
$BTN_CHG_POOLS.Name = 'BTN_CHG_POOLS'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 60
$BTN_CHG_POOLS.Size = $System_Drawing_Size
#$BTN_CHG_POOLS.TabIndex = 11
$BTN_CHG_POOLS.Text = 'Change'
$BTN_CHG_POOLS.UseVisualStyleBackColor = $True
$BTN_CHG_POOLS.add_Click({SET_CHG_POOLS})
$tabMain.Controls.Add($BTN_CHG_POOLS)

$tabInfo.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 4
$System_Drawing_Point.Y = 22
$tabInfo.Location = $System_Drawing_Point
$tabInfo.Name = 'tabInfo'
$System_Windows_Forms_Padding = New-Object System.Windows.Forms.Padding
$System_Windows_Forms_Padding.All = 3
$System_Windows_Forms_Padding.Bottom = 3
$System_Windows_Forms_Padding.Left = 3
$System_Windows_Forms_Padding.Right = 3
$System_Windows_Forms_Padding.Top = 3
$tabInfo.Padding = $System_Windows_Forms_Padding
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 396
$System_Drawing_Size.Width = 591
$tabInfo.Size = $System_Drawing_Size
$tabInfo.TabIndex = 2
$tabInfo.Text = 'Info'
$tabInfo.UseVisualStyleBackColor = $True

$tabControl1.Controls.Add($tabInfo)

$BTN_CLEAR_LOG.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 371
$System_Drawing_Point.Y = 417
$BTN_CLEAR_LOG.Location = $System_Drawing_Point
$BTN_CLEAR_LOG.Name = 'BTN_CLEAR_LOG'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 89
$BTN_CLEAR_LOG.Size = $System_Drawing_Size
$BTN_CLEAR_LOG.TabIndex = 7
$BTN_CLEAR_LOG.Text = 'Clear log'
$BTN_CLEAR_LOG.UseVisualStyleBackColor = $True
$BTN_CLEAR_LOG.add_Click({CLEAR_LOG})

$tabInfo.Controls.Add($BTN_CLEAR_LOG)

$BTN_SAVE_LOG.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 466
$System_Drawing_Point.Y = 417
$BTN_SAVE_LOG.Location = $System_Drawing_Point
$BTN_SAVE_LOG.Name = 'BTN_SAVE_LOG'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 120
$BTN_SAVE_LOG.Size = $System_Drawing_Size
$BTN_SAVE_LOG.TabIndex = 11
$BTN_SAVE_LOG.Text = 'Save log'
$BTN_SAVE_LOG.UseVisualStyleBackColor = $True
$BTN_SAVE_LOG.add_Click({SAVE_LOG})

$tabInfo.Controls.Add($BTN_SAVE_LOG)

$LB_LAST_CMDLET.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 120
$LB_LAST_CMDLET.Location = $System_Drawing_Point
$LB_LAST_CMDLET.Name = "LB_LAST_CMDLET"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 18
$System_Drawing_Size.Width = 130
$LB_LAST_CMDLET.Size = $System_Drawing_Size
$LB_LAST_CMDLET.TabIndex = 6
$LB_LAST_CMDLET.Text = "Last performed jobs:"

$tabInfo.Controls.Add($LB_LAST_CMDLET)

$TB_LOG.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 142
$TB_LOG.Location = $System_Drawing_Point
$TB_LOG.Multiline = $True
$TB_LOG.Name = "TB_LOG"
$TB_LOG.ReadOnly = $True
$TB_LOG.ScrollBars = 3
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 250
$System_Drawing_Size.Width = 849
$TB_LOG.Size = $System_Drawing_Size
$TB_LOG.TabIndex = 7

$tabInfo.Controls.Add($TB_LOG)

$TB_SEFAUtil_LOC.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 122
$System_Drawing_Point.Y = 64
$TB_SEFAUtil_LOC.Location = $System_Drawing_Point
$TB_SEFAUTIL_Loc.ReadOnly = $True
$TB_SEFAUtil_LOC.Name = "TB_SEFAUtil_Loc"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 360
$TB_SEFAUtil_LOC.Size = $System_Drawing_Size
$TB_SEFAUtil_LOC.TabIndex = 4

$tabInfo.Controls.Add($TB_SEFAUtil_LOC)

$LB_SEFAUTIL_LOC.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 67
$LB_SEFAUTIL_LOC.Location = $System_Drawing_Point
$LB_SEFAUTIL_LOC.Name = "LB_SEFAUTIL_LOC"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$LB_SEFAUTIL_LOC.Size = $System_Drawing_Size
$LB_SEFAUTIL_LOC.TabIndex = 1
$LB_SEFAUTIL_LOC.Text = "SEFAUtil location:"
$LB_SEFAUTIL_LOC.add_Click($handler_label8_Click)

$tabInfo.Controls.Add($LB_SEFAUTIL_LOC)

$TB_LYNC_VER.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 122
$System_Drawing_Point.Y = 43
$TB_LYNC_VER.Location = $System_Drawing_Point
$TB_LYNC_VER.MaxLength = 10
$TB_LYNC_VER.ReadOnly = $True
$TB_LYNC_VER.Name = "TB_LYNC_VER"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 50
$TB_LYNC_VER.Size = $System_Drawing_Size
$TB_LYNC_VER.TabIndex = 2

$tabInfo.Controls.Add($TB_LYNC_VER)

$LB_LYNC_VER.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 46
$LB_LYNC_VER.Location = $System_Drawing_Point
$LB_LYNC_VER.Name = "LB_LYNC_VER"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 17
$System_Drawing_Size.Width = 107
$LB_LYNC_VER.Size = $System_Drawing_Size
$LB_LYNC_VER.TabIndex = 1
$LB_LYNC_VER.Text = "Server version:"
$LB_LYNC_VER.add_Click($handler_LB_LYNC_VER_Click)

$tabInfo.Controls.Add($LB_LYNC_VER)

$LB_DIAGNOSTIC.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_DIAGNOSTIC.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8.25,1,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 19
$LB_DIAGNOSTIC.Location = $System_Drawing_Point
$LB_DIAGNOSTIC.Name = "LB_DIAGNOSTIC"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$LB_DIAGNOSTIC.Size = $System_Drawing_Size
$LB_DIAGNOSTIC.TabIndex = 0
$LB_DIAGNOSTIC.Text = "Diagnostic information"

$tabInfo.Controls.Add($LB_DIAGNOSTIC)

$TB_FWD_DEST.DataBindings.DefaultDataSourceUpdateMode = 0
$TB_FWD_DEST.Enabled = $False
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 730
$System_Drawing_Point.Y = 54
$TB_FWD_DEST.Location = $System_Drawing_Point
$TB_FWD_DEST.Name = "TB_FWD_DEST"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 183
$TB_FWD_DEST.Size = $System_Drawing_Size
$TB_FWD_DEST.TabIndex = 23
$tabMain.Controls.Add($TB_FWD_DEST)

$LB_FWD_DEST.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 566
$System_Drawing_Point.Y = 54
$LB_FWD_DEST.Location = $System_Drawing_Point
$LB_FWD_DEST.Name = "LB_FWD_DEST"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 108
$LB_FWD_DEST.Size = $System_Drawing_Size
$LB_FWD_DEST.TabIndex = 22
$LB_FWD_DEST.Text = "Forward Destination"

$tabMain.Controls.Add($LB_FWD_DEST)

$LB_TIME_FORMAT.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 780
$System_Drawing_Point.Y = 33
$LB_TIME_FORMAT.Location = $System_Drawing_Point
$LB_TIME_FORMAT.Name = "LB_TIME_FORMAT"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$LB_TIME_FORMAT.Size = $System_Drawing_Size
$LB_TIME_FORMAT.TabIndex = 21
$LB_TIME_FORMAT.Text = "(seconds)"

$tabMain.Controls.Add($LB_TIME_FORMAT)

$BTN_REM_TEAM_M.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 593
$System_Drawing_Point.Y = 417
$BTN_REM_TEAM_M.Location = $System_Drawing_Point
$BTN_REM_TEAM_M.Name = 'BTN_REM_TEAM_M'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 140
$BTN_REM_TEAM_M.Size = $System_Drawing_Size
$BTN_REM_TEAM_M.TabIndex = 19
$BTN_REM_TEAM_M.Text = 'Remove Team member'
$BTN_REM_TEAM_M.UseVisualStyleBackColor = $True
$BTN_REM_TEAM_M.add_Click({REMOVE_TEAM_M})
$BTN_REM_TEAM_M.Visible = $false

$tabMain.Controls.Add($BTN_REM_TEAM_M)

$TB_GRP_PICKUP_NR.DataBindings.DefaultDataSourceUpdateMode = 0
$TB_GRP_PICKUP_NR.Enabled = $False
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 730
$System_Drawing_Point.Y = 83
$TB_GRP_PICKUP_NR.Location = $System_Drawing_Point
$TB_GRP_PICKUP_NR.Name = 'TB_GRP_PICKUP_NR'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$TB_GRP_PICKUP_NR.Size = $System_Drawing_Size
$TB_GRP_PICKUP_NR.TabIndex = 18
$TB_GRP_PICKUP_NR.Visible = $false
$TB_GRP_PICKUP_NR.add_Leave({SET_GROUPID})

$tabMain.Controls.Add($TB_GRP_PICKUP_NR)

$LB_Options.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_Options.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8.25,1,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 15
$LB_Options.Location = $System_Drawing_Point
$LB_Options.Name = "LB_Options"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 15
$System_Drawing_Size.Width = 100
$LB_Options.Size = $System_Drawing_Size
$LB_Options.TabIndex = 19
$LB_Options.Text = "Options"

$tabMain.Controls.Add($LB_Options)

$LB_Delegates.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_Delegates.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8.25,1,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 191
$System_Drawing_Point.Y = 15
$LB_Delegates.Location = $System_Drawing_Point
$LB_Delegates.Name = "LB_Delegates"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 15
$System_Drawing_Size.Width = 100
$LB_Delegates.Size = $System_Drawing_Size
$LB_Delegates.TabIndex = 18
$LB_Delegates.Text = "Delegates"

$tabMain.Controls.Add($LB_Delegates)

$LB_Users.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_Users.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8.25,1,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 8
$System_Drawing_Point.Y = 15
$LB_Users.Location = $System_Drawing_Point
$LB_Users.Name = "LB_Users"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 15
$System_Drawing_Size.Width = 100
$LB_Users.Size = $System_Drawing_Size
$LB_Users.TabIndex = 17
$LB_Users.Text = "Users"

$tabMain.Controls.Add($LB_Users)

$LB_GRP_PICKUP.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 566
$System_Drawing_Point.Y = 88
$LB_GRP_PICKUP.Location = $System_Drawing_Point
$LB_GRP_PICKUP.Name = 'LB_GRP_PICKUP'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 183
$LB_GRP_PICKUP.Size = $System_Drawing_Size
$LB_GRP_PICKUP.TabIndex = 17
$LB_GRP_PICKUP.Text = 'Group Pickup Number'
$LB_GRP_PICKUP.Visible = $false

$tabMain.Controls.Add($LB_GRP_PICKUP)
$LB_SIM_RING.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 566
$System_Drawing_Point.Y = 176
$LB_SIM_RING.Location = $System_Drawing_Point
$LB_SIM_RING.Name = 'LB_SIM_RING'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 160
$LB_SIM_RING.Size = $System_Drawing_Size
$LB_SIM_RING.TabIndex = 16
$LB_SIM_RING.Text = 'Simultaneous Ring destination'

$tabMain.Controls.Add($LB_SIM_RING)

$CB_DISABLE_ALL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 207
$CB_DISABLE_ALL.Location = $System_Drawing_Point
$CB_DISABLE_ALL.Name = 'CB_DISABLE_ALL'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 104
$CB_DISABLE_ALL.Size = $System_Drawing_Size
#$CB_DISABLE_ALL.TabIndex = 14
$CB_DISABLE_ALL.Text = 'Disable all'
$CB_DISABLE_ALL.UseVisualStyleBackColor = $True

$tabMain.Controls.Add($CB_DISABLE_ALL)

$CB_GRP_PICKUP.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 250
$CB_GRP_PICKUP.Location = $System_Drawing_Point
$CB_GRP_PICKUP.Name = 'CB_GRP_PICKUP'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 104
$CB_GRP_PICKUP.Size = $System_Drawing_Size
$CB_GRP_PICKUP.TabIndex = 14
$CB_GRP_PICKUP.Text = 'Group Pickup'
$CB_GRP_PICKUP.UseVisualStyleBackColor = $True
$CB_GRP_PICKUP.Visible = $false
$CB_GRP_PICKUP.add_CheckStateChanged({SET_CHG_GRP_PICKUP})

$tabMain.Controls.Add($CB_GRP_PICKUP)

$CB_SIM_RING.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 176
$CB_SIM_RING.Location = $System_Drawing_Point
$CB_SIM_RING.Name = 'CB_SIM_RING'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 136
$CB_SIM_RING.Size = $System_Drawing_Size
$CB_SIM_RING.TabIndex = 13
$CB_SIM_RING.Text = 'Simultaneous Ring'
$CB_SIM_RING.UseVisualStyleBackColor = $True
$CB_SIM_RING.Visible = $false
$CB_SIM_RING.add_CheckedChanged({SET_CHG_SIM_RING})

$tabMain.Controls.Add($CB_SIM_RING)


$CB_SIM_RING_TEAM.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 145
$CB_SIM_RING_TEAM.Location = $System_Drawing_Point
$CB_SIM_RING_TEAM.Name = 'CB_SIM_RING_TEAM'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 165
$CB_SIM_RING_TEAM.Size = $System_Drawing_Size
$CB_SIM_RING_TEAM.TabIndex = 12
$CB_SIM_RING_TEAM.Text = 'Simultaneous Ring Team'
$CB_SIM_RING_TEAM.UseVisualStyleBackColor = $True
$CB_SIM_RING_TEAM.Visible = $false
$CB_SIM_RING_TEAM.add_CheckedChanged({SET_CHG_SIM_RING_TEAM})
$tabMain.Controls.Add($CB_SIM_RING_TEAM)


$BTN_REM_DEL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 466
$System_Drawing_Point.Y = 417
$BTN_REM_DEL.Location = $System_Drawing_Point
$BTN_REM_DEL.Name = 'BTN_REM_DEL'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 120
$BTN_REM_DEL.Size = $System_Drawing_Size
$BTN_REM_DEL.TabIndex = 11
$BTN_REM_DEL.Text = 'Remove Delegate'
$BTN_REM_DEL.UseVisualStyleBackColor = $True
$BTN_REM_DEL.add_Click({REMOVE_DELEGATE})

$tabMain.Controls.Add($BTN_REM_DEL)

$BTN_SEARCH_DEL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 340
$System_Drawing_Point.Y = 417
$BTN_SEARCH_DEL.Location = $System_Drawing_Point
$BTN_SEARCH_DEL.Name = "BTN_SEARCH_DEL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 120
$BTN_SEARCH_DEL.Size = $System_Drawing_Size
$BTN_SEARCH_DEL.TabIndex = 24
$BTN_SEARCH_DEL.Text = "Suggest Delegates"
$BTN_SEARCH_DEL.UseVisualStyleBackColor = $True
$BTN_SEARCH_DEL.add_Click({SEARCH_DEL})

$tabMain.Controls.Add($BTN_SEARCH_DEL)
$LB_SourceUsers.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_SourceUsers.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 8
$System_Drawing_Point.Y = 33
$LB_SourceUsers.Location = $System_Drawing_Point
$LB_SourceUsers.Name = 'LB_SourceUsers'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 225
$System_Drawing_Size.Width = 166
$LB_SourceUsers.Size = $System_Drawing_Size
$LB_SourceUsers.TabIndex = 0
$LB_SourceUsers.add_SelectedIndexChanged({getUserInfo})

$tabMain.Controls.Add($LB_SourceUsers)


$CB_SIM_RING_DEL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 114
$CB_SIM_RING_DEL.Location = $System_Drawing_Point
$CB_SIM_RING_DEL.Name = 'CB_SIM_RING_DEL'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 180
$CB_SIM_RING_DEL.Size = $System_Drawing_Size
$CB_SIM_RING_DEL.TabIndex = 9
$CB_SIM_RING_DEL.Text = 'Simultaneous Ring Delegates'
$CB_SIM_RING_DEL.UseVisualStyleBackColor = $True
$CB_SIM_RING_DEL.add_CheckedChanged({SET_CHG_SIM_RING_DEL})

$tabMain.Controls.Add($CB_SIM_RING_DEL)

$LB_DelegateUsers.Enabled = $False
$LB_DelegateUsers.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_DelegateUsers.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 191
$System_Drawing_Point.Y = 33
$LB_DelegateUsers.Location = $System_Drawing_Point
$LB_DelegateUsers.Name = 'LB_DelegateUsers'
$LB_DelegateUsers.SelectionMode = 2
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 225
$System_Drawing_Size.Width = 166
$LB_DelegateUsers.Size = $System_Drawing_Size
$LB_DelegateUsers.TabIndex = 10
$LB_DelegateUsers.add_SelectedIndexChanged({SET_DELEGATE})

$tabMain.Controls.Add($LB_DelegateUsers)


$CB_FWD_TO_DEL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 84
$CB_FWD_TO_DEL.Location = $System_Drawing_Point
$CB_FWD_TO_DEL.Name = 'CB_FWD_TO_DEL'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 138
$CB_FWD_TO_DEL.Size = $System_Drawing_Size
$CB_FWD_TO_DEL.TabIndex = 8
$CB_FWD_TO_DEL.Text = 'Forward to delegates'
$CB_FWD_TO_DEL.UseVisualStyleBackColor = $True
$CB_FWD_TO_DEL.add_CheckedChanged({SET_CHG_FWD_TO_DEL})

$tabMain.Controls.Add($CB_FWD_TO_DEL)

$LB_User_Details.DataBindings.DefaultDataSourceUpdateMode = 0
$LB_User_Details.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 8
$System_Drawing_Point.Y = 274
$LB_User_Details.Location = $System_Drawing_Point
$LB_User_Details.Name = "LB_User_Details"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 95
$System_Drawing_Size.Width = 845
$LB_User_Details.Size = $System_Drawing_Size
$LB_User_Details.TabIndex = 1

$tabMain.Controls.Add($LB_User_Details)


$BTN_Apply.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 150
$System_Drawing_Point.Y = 417
$BTN_Apply.Location = $System_Drawing_Point
$BTN_Apply.Name = 'BTN_Apply'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 89
$BTN_Apply.Size = $System_Drawing_Size
$BTN_Apply.TabIndex = 7
$BTN_Apply.Text = 'Apply'
$BTN_Apply.UseVisualStyleBackColor = $True
$BTN_Apply.add_Click({APPLY})

$tabMain.Controls.Add($BTN_Apply)

$BTN_Refresh.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 245
$System_Drawing_Point.Y = 417
$BTN_Refresh.Location = $System_Drawing_Point
$BTN_Refresh.Name = 'BTN_Refresh'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 89
$BTN_Refresh.Size = $System_Drawing_Size
$BTN_Refresh.TabIndex = 7
$BTN_Refresh.Text = 'Refresh'
$BTN_Refresh.UseVisualStyleBackColor = $True
$BTN_Refresh.add_Click({GetUserInfo})

$tabMain.Controls.Add($BTN_Refresh)

$BTN_Load.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 55
$System_Drawing_Point.Y = 417
$BTN_Load.Location = $System_Drawing_Point
$BTN_Load.Name = 'BTN_Load'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 89
$BTN_Load.Size = $System_Drawing_Size
$BTN_Load.TabIndex = 7
$BTN_Load.Text = 'Load'
$BTN_Load.UseVisualStyleBackColor = $True
$BTN_Load.Visible = $False
$BTN_Load.add_Click({loaddata})

$tabMain.Controls.Add($BTN_Load)

$CB_FWD_Immediate.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 54
$CB_FWD_Immediate.Location = $System_Drawing_Point
$CB_FWD_Immediate.Name = 'CB_FWD_Immediate'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 136
$CB_FWD_Immediate.Size = $System_Drawing_Size
$CB_FWD_Immediate.TabIndex = 2
$CB_FWD_Immediate.Text = 'Forward Immediate'
$CB_FWD_Immediate.UseVisualStyleBackColor = $True
$CB_FWD_Immediate.add_CheckedChanged({SET_CHG_FWD_IMMEDIATE})

$tabMain.Controls.Add($CB_FWD_Immediate)

$LB_User_ring_time.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 566
$System_Drawing_Point.Y = 33
$LB_User_ring_time.Location = $System_Drawing_Point
$LB_User_ring_time.Name = 'LB_User_ring_time'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 160
$LB_User_ring_time.Text = 'User Ringtime'
$LB_User_ring_time.Size = $System_Drawing_Size
$LB_User_ring_time.TabIndex = 6

$tabMain.Controls.Add($LB_User_ring_time)


$CB_FWD_NOANSWER.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 380
$System_Drawing_Point.Y = 27
$CB_FWD_NOANSWER.Location = $System_Drawing_Point
$CB_FWD_NOANSWER.Name = 'CB_FWD_NOANSWER'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 24
$System_Drawing_Size.Width = 136
$CB_FWD_NOANSWER.Size = $System_Drawing_Size
$CB_FWD_NOANSWER.TabIndex = 3
$CB_FWD_NOANSWER.Text = 'Forward No Answer'
$CB_FWD_NOANSWER.UseVisualStyleBackColor = $True
$CB_FWD_NOANSWER.add_CheckedChanged({SET_CHG_FWD_NO_ANSWER})

$tabMain.Controls.Add($CB_FWD_NOANSWER)

$TB_User_Ringtime.DataBindings.DefaultDataSourceUpdateMode = 0
$TB_User_RingTime.Enabled = $False
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 750
$System_Drawing_Point.Y = 29
$TB_User_Ringtime.Location = $System_Drawing_Point
$TB_User_Ringtime.Name = 'TB_User_Ringtime'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 25
$TB_User_Ringtime.Size = $System_Drawing_Size
$TB_User_Ringtime.TabIndex = 5
$TB_User_Ringtime.add_Leave({SET_CHG_USR_RING_TIME})

$tabMain.Controls.Add($TB_User_Ringtime)

$TAB_BCK_REST.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 4
$System_Drawing_Point.Y = 22
$TAB_BCK_REST.Location = $System_Drawing_Point
$TAB_BCK_REST.Name = "TAB_BCK_REST"
$System_Windows_Forms_Padding = New-Object System.Windows.Forms.Padding
$System_Windows_Forms_Padding.All = 3
$System_Windows_Forms_Padding.Bottom = 3
$System_Windows_Forms_Padding.Left = 3
$System_Windows_Forms_Padding.Right = 3
$System_Windows_Forms_Padding.Top = 3
$TAB_BCK_REST.Padding = $System_Windows_Forms_Padding
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 449
$System_Drawing_Size.Width = 861
$TAB_BCK_REST.Size = $System_Drawing_Size
$TAB_BCK_REST.TabIndex = 1
$TAB_BCK_REST.Text = "Backup/Restore"
$TAB_BCK_REST.UseVisualStyleBackColor = $True

$tabControl1.Controls.Add($TAB_BCK_REST)

$BTN_BACKUP_ALL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 30
$System_Drawing_Point.Y = 24
$BTN_BACKUP_ALL.Location = $System_Drawing_Point
$BTN_BACKUP_ALL.Name = "BTN_BACKUP_ALL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$BTN_BACKUP_ALL.Size = $System_Drawing_Size
$BTN_BACKUP_ALL.TabIndex = 2
$BTN_BACKUP_ALL.Text = "Backup all"
$BTN_BACKUP_ALL.UseVisualStyleBackColor = $True
$BTN_BACKUP_ALL.add_Click({BACKUP_ALL})

$TAB_BCK_REST.Controls.Add($BTN_BACKUP_ALL)

$BTN_RESTORE_ALL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 30
$System_Drawing_Point.Y = 50
$BTN_RESTORE_ALL.Location = $System_Drawing_Point
$BTN_RESTORE_ALL.Name = "BTN_RESTORE_ALL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$BTN_RESTORE_ALL.Size = $System_Drawing_Size
$BTN_RESTORE_ALL.TabIndex = 0
$BTN_RESTORE_ALL.Text = "Restore all"
$BTN_RESTORE_ALL.UseVisualStyleBackColor = $True
$BTN_RESTORE_ALL.add_Click({RESTORE_ALL})

$TAB_BCK_REST.Controls.Add($BTN_RESTORE_ALL)
$statusBar.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 0
$System_Drawing_Point.Y = 480
$statusBar.Location = $System_Drawing_Point
$statusBar.Name = 'statusBar'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 22
$System_Drawing_Size.Width = 869
$statusBar.Size = $System_Drawing_Size
$statusBar.TabIndex = 4
$statusBar.Text = 'status'

$form.Controls.Add($statusBar)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form.WindowState
#Init the OnLoad event to correct the initial state of the form
$form.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form.ShowDialog()| Out-Null

} #End Function

function initialize
{
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	if($Version -eq 'SfB2015'){
		$CB_SIM_RING.Visible = $True
		$CB_GRP_PICKUP.Visible = $True
		$CB_SIM_RING_TEAM.Visible = $True
		$BTN_REM_TEAM_M.Visible = $True
		$TB_GRP_PICKUP_NR.Visible = $true
		$LB_GRP_PICKUP.Visible = $true
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Skype for Business Server 2015 detected`r`n")	
		}
    elseif($Version -eq '2013'){
		$CB_SIM_RING.Visible = $True
		$CB_GRP_PICKUP.Visible = $True
		$CB_SIM_RING_TEAM.Visible = $True
		$BTN_REM_TEAM_M.Visible = $True
		$TB_GRP_PICKUP_NR.Visible = $true
		$LB_GRP_PICKUP.Visible = $true
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Lync 2013 detected`r`n")	
		}
	elseif($Version -eq '2010'){
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Lync 2010 detected`r`n")
		}
    
    foreach ($item in $pools)
	  {    
	      [void] $CB_Pools.Items.Add($item.PoolFQDN) 
	  }

    $CB_Pools.SelectedItem = $pool

	if ($detected -eq $true){
		$TB_SEFAUtil_LOC.text = $SEFAUtilPath
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.AppendText("SEFAUtil detected continue loading data`r`n")
		if($loaddata -eq $true){
			loadData
		}
		}
	if($loaddata -eq $false){
		$BTN_Load.Visible = $True
		}
	elseif ($detected -eq $false){
		$statusBar.text = "SEFAUtil is not detected"
		$TB_LOG.Appendtext("$time`t")
		$TB_LOG.AppendText("SEFAUtil was not found please verify that SEFAUtil is installed`r`n")
		
	}
}

function ConnectSQL
{
    #Find ResourceId for user'    param([string]$query)

    #Define connection string

    $server = $pool

    [string]$connstring = "server=$server\rtclocal;database=rtc;trusted_connection=true;"

    #Define SQL Command
    [object]$command = New-Object System.Data.SqlClient.SqlCommand 

    $command.CommandText = $query

    [object]$connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connstring
    try {
    $connection.Open()
    } catch [Exception] {
		    write-host ""
       	    write-host "SefaUtilGUI was unable to connect to database $server\rtclocal. Please check that the server is online. Also check that UDP 1434 and the Dynamic SQL TCP Port for the RTCLOCAL Named Instance are open in the Windows Firewall on $server." -foreground "red"
		    write-host ""
		    $StatusLabel.Text = "Error connecting to $server. Refer to Powershell window."
	    }
	
    $command.Connection = $connection
	
 
    [object]$sqladapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $sqladapter.SelectCommand = $command
 
    [object]$results = New-Object System.Data.Dataset
    try {
    $recordcount = $sqladapter.Fill($results)
    } catch [Exception] {
            write-host ""
		    write-host "Error running SQL on $server : $_" -foreground "red"
		    write-host ""
        }
    $connection.Close()
    $global:data = $Results.Tables[0]
}

#region Log related functions
function CLEAR_LOG
{
$TB_LOG.Text = $NULL
}

function SAVE_LOG
{
$EXPORT = $TB_LOG.Text
$date = Get-Date -format "dd-MM-yyyy"
$file = $date + '_log.txt'
$EXPORT|Out-File $file
}

function SRC_USER
{
    #Find ResourceId for user'    param([string]$userid)

    ConnectSQL -query "select ResourceId from Resource where UserAtHost = '$userid'"

    foreach ($Row in $data)
	    { 
	    [string]$script:ResourceId = $Setting = $Row[0]
    }
}

#endregion

#region Functions to check is features are enabled
function CHK_CALL_FWD_NO_ANSWER
{
    if($mode -eq "restore")
    {      
        if($Settings.Contains("<flags name=`"clientflags`" value=`"enablecf`">"))
	    {
            $xmlSplitStart = $Settings -split "<list name=`"forwardto`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "<//list>"
		    $splitList = $xmlSplitList[0]
	
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $start = $splitList.IndexOf("<target uri=`"sip:")
			    $end = $splitList.IndexOf("`">")
			    [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                $CB_FWD_NOANSWER.Checked = $true
                if($FWD_NR.Contains("+")){
                    $end = $FWD_NR.IndexOf("@")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                    $TB_FWD_DEST.text = $FWD_NR
                    }
                elseif($FWD_NR.Contains("user=phone")){
                    $end = $FWD_NR.IndexOf(";phone-context")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                    $TB_FWD_DEST.text = $FWD_NR
                    }

                else
                {     
                   $delegate = Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}
		           $LB_DelegateUsers.SelectedItem = $delegate.DisplayName
                }
		    }

	        $xmlSplitStart = $Settings -split "<wait name=`"total`" "
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</wait>"
		    $splitList = $xmlSplitList[0]

            if($Settings.Contains("<wait name="))
            {
                $start = $splitList.IndexOf("seconds=`"")
                $end = $splitList.IndexOf("`">")
                [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
                $TB_User_Ringtime.Text = $WAIT
		        $TB_User_Ringtime.BackColor = ''
            }
        }
    }
    else
    {   
    
        #Verify if user has set the option forward no answer

        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                        from PublishedStaticInstance,Resource `
	                        where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                        and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                        like '%<flags name=`"clientflags`" value=`"enablecf`">%'"

	
	    foreach ($Row in $data)
	    { 
	    [string]$Setting = $Row[1]
	
	    if($Setting.Contains("<list name=`"forwardto`">"))
	    {
		    $xmlSplitStart = $Setting -split "<list name=`"forwardto`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "<//list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $start = $splitList.IndexOf("<target uri=`"sip:")
			    $end = $splitList.IndexOf("`">")
			    [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			    $sipaddress = $Row[0]
                $CB_FWD_NOANSWER.Checked = $true
                if($FWD_NR.Contains("+")){
                    $end = $FWD_NR.IndexOf("@")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                    $TB_FWD_DEST.text = $FWD_NR
                    }
                elseif($FWD_NR.Contains("user=phone")){
                    $end = $FWD_NR.IndexOf(";phone-context")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                    $TB_FWD_DEST.text = $FWD_NR
                    }
                else{     
		            $LB_DelegateUsers.SelectedItem = $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}).DisplayName
                }
		    }

	     }
         if($Setting.Contains("<wait name="))
            {
                    $xmlSplitStart = $Setting -split "<wait name=`"total`" "
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</wait>"
		            $splitList = $xmlSplitList[0]

                    $start = $splitList.IndexOf("seconds=`"")
                    $end = $splitList.IndexOf("`">")
                    [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
                    $TB_User_Ringtime.Text = $WAIT
		            $TB_User_Ringtime.BackColor = ''
            }	
	     }
    }
}

function CHK_FWD_IM
{
    if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"enablecf forward_immediate`">"))
	    {
		            $xmlSplitStart = $Settings -split "<list name=`"forwardto`">"
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</list>"
		            $splitList = $xmlSplitList[0]

		
		            if($splitList.Contains("target uri=`"sip:"))
		            {
			            $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $CB_FWD_Immediate.Checked = $true
                        
                        if($FWD_NR.Contains("+")){
                            $end = $FWD_NR.IndexOf("@")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $TB_FWD_DEST.text = $FWD_NR
                            }
                        elseif($FWD_NR.Contains("user=phone")){
                            $end = $FWD_NR.IndexOf(";phone-context")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $TB_FWD_DEST.text = $FWD_NR
                            }
                        }
                else{     
		            $LB_DelegateUsers.SelectedItem = $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}).DisplayName
                }    
	  }
    }
    else
    {
        #Verify if user has set the option forward immediately
        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       from PublishedStaticInstance,Resource `
	                       where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                       and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       like '%<flags name=`"clientflags`" value=`"enablecf forward_immediate`">%'"

	        foreach ($Row in $data)
	        { 
	            [string]$Setting = $Row[1]
	
	            if($Setting.Contains("<list name=`"forwardto`">"))
	            {
		            $xmlSplitStart = $Setting -split "<list name=`"forwardto`">"
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</list>"
		            $splitList = $xmlSplitList[0]
		
		            if($splitList.Contains("target uri=`"sip:"))
		            {
			            $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
		                $CB_FWD_Immediate.Checked = $true

                        if($FWD_NR.Contains("+")){
                            $end = $FWD_NR.IndexOf("@")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $TB_FWD_DEST.text = $FWD_NR
                            }
                        elseif($FWD_NR.Contains("user=phone")){
                            $end = $FWD_NR.IndexOf(";phone-context")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $TB_FWD_DEST.text = $FWD_NR
                            }
                        else{     
		                    $LB_DelegateUsers.SelectedItem = $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}).DisplayName
                        }
		            }
	            }
	        }
    }	
}

function CHK_SIM_RING_DEL
{
    if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"delegate_ring forward_audio_app_invites`">"))
	    {
		    $xmlSplitStart = $Settings -split "<list name=`"delegates`">"
            $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1")
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_SIM_RING_DEL.Checked = $true
                $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates){
			        $LB_DelegateUsers.SelectedItem = $item
		        }
		    }
	      }
    }
    else
    {
	
    #Verify if user has set the option simultaneous ring to delegates


        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       from PublishedStaticInstance,Resource `
	                       where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                       and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       like '%<flags name=`"clientflags`" value=`"delegate_ring forward_audio_app_invites`">%'"
  
	    foreach ($Row in $data)
	    { 
	    [string]$Setting = $Row[1]
	
	    if($Setting.Contains("<list name=`"delegates`">"))
	    {
		    $xmlSplitStart = $Setting -split "<list name=`"delegates`">"
            $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1")
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_SIM_RING_DEL.Checked = $true
                $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates){
			        $LB_DelegateUsers.SelectedItem = $item
		        }
		    }
	      }
	    }
    }
}

function CHK_SIM_RING_TO
{
if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"simultaneous_ring`">"))
	    {
		    $xmlSplitStart = $Settings -split "<list name=`"simultaneous_ring`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $start = $splitList.IndexOf("<target uri=`"sip:")
			    $end = $splitList.IndexOf("`">")
			    [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			    $CB_SIM_RING.Checked = $true
                if($FWD_NR.Contains(";phone-context=user-default"))
                {
                    $end = $FWD_NR.IndexOf(";phone-context=user-default")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                    $CB_SIM_RING_DEST.text = $FWD_NR
                }
                elseif($FWD_NR.Contains("user=phone"))
                {
                    $end = $FWD_NR.IndexOf("@")
                    [string]$FWD_NR = $FWD_NR.Substring(0,$end)

                    $CB_SIM_RING_DEST.text = $FWD_NR
                }
                else
                {     
		            $LB_DelegateUsers.SelectedItem = $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}).DisplayName
                }
		    }
	     }
    }
    else
    {
        #Verify if user has set the option simultaneous ring


            ConnectSQL -query "select distinct UserAtHost, convert(varchar(4000),convert(varbinary(4000),Data)) `
	                          from PublishedStaticInstance,Resource `
	                          where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                          and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                          like '%<flags name=`"clientflags`" value=`"simultaneous_ring`">%'"
    
	        foreach ($Row in $data)
	        { 
                [string]$Setting = $Row[1]
                if($Setting.Contains("<list name=`"simultaneous_ring`">"))
	            {
		            $xmlSplitStart = $Setting -split "<list name=`"simultaneous_ring`">"
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</list>"
		            $splitList = $xmlSplitList[0]
		
		            if($splitList.Contains("target uri=`"sip:"))
		            {
			            $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $CB_SIM_RING.Checked = $true
                        if($FWD_NR.Contains(";phone-context=user-default")){
                            $end = $FWD_NR.IndexOf(";phone-context=user-default")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $CB_SIM_RING_DEST.text = $FWD_NR
  
                            foreach ($item in $getUserInfo)
	                        {    
	  	                        $CB_SIM_RING_DEST.Items.Clear()
	                            $SIM_RING_NUMBERS=@()
		                        $SIM_RING_NUMBERS = $item|select *Phone

		                        if ($SIM_RING_NUMBERS.homePhone)
		                        { 	
	    		                    [void] $CB_SIM_RING_DEST.Items.Add('Home')
                                    if($SIM_RING_NUMBERS.homePhone -eq $CB_SIM_RING_DEST.text)
                                    {
                                        $CB_SIM_RING_DEST.SelectedItem = "Home"
                                    } 
		                        }
		                        if ($SIM_RING_NUMBERS.ipPhone)
		                        {
	    		                    [void] $CB_SIM_RING_DEST.Items.Add('IP') 
                                    if($SIM_RING_NUMBERS.ipPhone -eq $CB_SIM_RING_DEST.text)
                                    {
                                        $CB_SIM_RING_DEST.SelectedItem = "IP"
                                    }
		                        }
		                        if ($SIM_RING_NUMBERS.ipPhone)
		                        {
	    		                    [void] $CB_SIM_RING_DEST.Items.Add('Mobile') 
                                    if($SIM_RING_NUMBERS.Mobile -eq $CB_SIM_RING_DEST.text)
                                    {
                                        $CB_SIM_RING_DEST.SelectedItem = "Mobile"
                                    }
		                        }
	                        }  		                    

                        }
                        elseif($FWD_NR.Contains("user=phone")){
                            $end = $FWD_NR.IndexOf("@")
                            [string]$FWD_NR = $FWD_NR.Substring(0,$end)
                            $CB_SIM_RING_DEST.text = $FWD_NR
                        }
                        else{     
		                    $LB_DelegateUsers.SelectedItem = $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq "sip:" + $FWD_NR}).DisplayName
                        }
		            }
	            }
	        }
    }
}

function CHK_FWD_DEL
{
    if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"delegate_ring forward_audio_app_invites skip_primary`">"))
	    {
            $xmlSplitStart = $Settings -split "<list name=`"delegates`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1" -and $charCount -eq "1")
                    {
                        $FWD_NR = ""
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = ""
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_FWD_TO_DEL.Checked = $true
                $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates)
                {
			        $LB_DelegateUsers.SelectedItem = $item
		        }
			
		    }
	     }
         if($Settings.Contains("<wait name="))
         {
            $xmlSplitStart = $Settings -split "<wait name=`"total`" "
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</wait>"
		    $splitList = $xmlSplitList[0]
            $start = $splitList.IndexOf("seconds=`"")
            $end = $splitList.IndexOf("`">")
            [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
            $TB_User_Ringtime.Text = $WAIT
            $TB_User_Ringtime.BackColor = ''
         }
	}
    else
    {    
        
        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       from PublishedStaticInstance,Resource `
	                       where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                       and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       like '%<flags name=`"clientflags`" value=`"delegate_ring forward_audio_app_invites skip_primary`">%'"
  
	    foreach ($Row in $data)
	    { 
	    [string]$Setting = $Row[1]
	    if($Setting.Contains("<list name=`"delegates`">"))
	    {
            $xmlSplitStart = $Setting -split "<list name=`"delegates`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1")
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_FWD_TO_DEL.Checked = $true
                $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates){
			        $LB_DelegateUsers.SelectedItem = $item
		        }
			
		    }
	    }
        if($Setting.Contains("<wait name="))
            {
                    $xmlSplitStart = $Setting -split "<wait name=`"total`" "
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</wait>"
		            $splitList = $xmlSplitList[0]

                    $start = $splitList.IndexOf("seconds=`"")
                    $end = $splitList.IndexOf("`">")
                    [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
                    $TB_User_Ringtime.Text = $WAIT
		            $TB_User_Ringtime.BackColor = ''
            }
	    }
    }
}
function CHK_GRP_PICKUP
{
    if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"`">"))
	    {
                $xmlSplitStart = $Settings -split "<list name=`"GroupPickupList`">"
		        $splitStart = $xmlSplitStart[1]
		        $xmlSplitList = $splitStart -split "</list>"
		        $splitList = $xmlSplitList[0]
		
		        if($splitList.Contains("target uri=`"sip:"))
		        {
			        $start = $splitList.IndexOf("<target uri=`"sip:")
			        $end = $splitList.IndexOf(";phone-context=user-default")
			        [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			        #$sipaddress = $Row[0]
                    $TB_GRP_PICKUP_NR.Text = $FWD_NR
		            $TB_GRP_PICKUP_NR.BackColor = ''
		            $CB_GRP_PICKUP.Checked = $true
	            }
        }
    }
    else
    {
        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       from PublishedStaticInstance,Resource `
	                       where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                       and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       like '%<flags name=`"clientflags`"%'"
	    foreach ($Row in $data)
	    { 
	        [string]$Setting = $Row[1]
	        if($Setting.Contains("<list name=`"GroupPickupList`">"))
	        {
                $xmlSplitStart = $Setting -split "<list name=`"GroupPickupList`">"
		        $splitStart = $xmlSplitStart[1]
		        $xmlSplitList = $splitStart -split "</list>"
		        $splitList = $xmlSplitList[0]
		
		        if($splitList.Contains("target uri=`"sip:"))
		        {
			        $start = $splitList.IndexOf("<target uri=`"sip:")
			        $end = $splitList.IndexOf(";phone-context=user-default")
			        [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			        $sipaddress = $Row[0]
                    $TB_GRP_PICKUP_NR.Text = $FWD_NR
		            $TB_GRP_PICKUP_NR.BackColor = ''
		            $CB_GRP_PICKUP.Checked = $true
			
		        }
	        }
	    }
    }
}

function CHK_TEAM_RING
{
    if($mode -eq "restore")
    {
             
        if($Settings.Contains("<flags name=`"clientflags`" value=`"team_ring`">"))
	    {
            $xmlSplitStart = $Settings -split "<list name=`"team`">"
		    $splitStart = $xmlSplitStart[1]
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1")
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_SIM_RING_TEAM.Checked = $true
		        $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates){
			        $LB_DelegateUsers.SelectedItem = $item
		        }
			
		    }
	    }
        if($Settings.Contains("<wait name="))
            {
                    $xmlSplitStart = $Settings -split "<wait name=`"team2`" "
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</wait>"
		            $splitList = $xmlSplitList[0]

                    $start = $splitList.IndexOf("seconds=`"")
                    $end = $splitList.IndexOf("`">")
                    [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
                    $TB_User_Ringtime.Text = $WAIT
		            $TB_User_Ringtime.BackColor = ''
            }
    }
    else
    {
        ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       from PublishedStaticInstance,Resource `
	                       where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'`
	                       and convert(varchar(4000),convert(varbinary(4000),Data)) `
	                       like '%<flags name=`"clientflags`" value=`"team_ring`">%'"

	    foreach ($Row in $data)
	    { 
	    [string]$Setting = $Row[1]
	    if($Setting.Contains("<list name=`"team`">"))
	    {
            $xmlSplitStart = $Setting -split "<list name=`"team`">"
		    $splitStart = $xmlSplitStart[1]
            #write-host $splitStart
		    $xmlSplitList = $splitStart -split "</list>"
		    $splitList = $xmlSplitList[0]
		
		    if($splitList.Contains("target uri=`"sip:"))
		    {
			    $charCount = ($splitList.ToCharArray() | Where-Object {$_ -eq "@"} | Measure-Object).Count
                for ($i=1; $i -le $charCount;)
                {
                    if ($i -eq "1")
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
			            $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $i++
                        $FWD = $FWD_NR
                    }
                    elseif($i -le $charCount)
                    {
                        $FWD_NR = $null
                        $start = $splitList.IndexOf("<target uri=`"sip:")
                        $end = $splitList.IndexOf("`">")
			            [string]$FWD_NR = $splitList.Substring($start+17,$end-$start-17)
			            $sipaddress = $Row[0]
                        $tmp = "<target uri=`"sip:" + $FWD_NR + "`"></target>"
                        $splitList = $splitList -replace $tmp, ""
                        $FWD = $FWD + ";" + $FWD_NR
                        $i++
                    }  
                }
                $CB_SIM_RING_TEAM.Checked = $true
		        $delegate = @()
                $delegate = $FWD.split(';')
		        $count = $delegate.count-1
                $selecteddelegates = @()
                $i = 0
		        do{
                    $selecteddelegates = $selecteddelegates + $(Get-CsUser -DomainController $dc|? {$_.SipAddress -eq ("sip:" + $delegate[$i])}).DisplayName
			        $i++
		        }
		        while ($i -le $count)
		        foreach ($item in $selecteddelegates){
			        $LB_DelegateUsers.SelectedItem = $item
		        }
			
		    }
	    }
        if($Setting.Contains("<wait name="))
            {
                    $xmlSplitStart = $Setting -split "<wait name=`"team2`" "
		            $splitStart = $xmlSplitStart[1]
		            $xmlSplitList = $splitStart -split "</wait>"
		            $splitList = $xmlSplitList[0]

                    $start = $splitList.IndexOf("seconds=`"")
                    $end = $splitList.IndexOf("`">")
                    [string]$WAIT = $splitList.Substring($start+9,$end-$start-9)
                    $TB_User_Ringtime.Text = $WAIT
		            $TB_User_Ringtime.BackColor = ''
            }
        }
	    }
}	
#endregion

#region Functions to set the changed value to true
function SET_CHG_FWD_NO_ANSWER
{
    $script:FWD_NO_ANSWER = 'changed'
		if ($CB_FWD_NOANSWER.Checked -eq $true){
			$CB_FWD_NOANSWER.Enabled = $true
            $selectedDelegate = $LB_DelegateUsers.SelectedItem
			$LB_User_ring_time.Text = 'User ring time'
			$TB_User_RingTime.Text = '20'
			$TB_User_RingTime.Enabled = $true
			$TB_FWD_DEST.Enabled = $true
			$LB_DelegateUsers.Enabled = $true
            $BTN_APPLY.Enabled = $true
		}
		elseif ($CB_FWD_NOANSWER.Checked -eq $false){
			$LB_DelegateUsers.Enabled = $false
			$TB_FWD_DEST.Enabled = $false
			$TB_User_RingTime.Enabled = $false
            $TB_User_RingTime.Text = ''
            $BTN_APPLY.Enabled = $true
		}
}

function SET_CHG_FWD_IMMEDIATE
{
	$script:FWD_IMMEDIATE = 'changed'
		if ($CB_FWD_Immediate.Checked -eq $true){
			$CB_FWD_Immediate.Enabled = $true
            $LB_DelegateUsers.Enabled = $true
            $TB_FWD_DEST.Enabled =$true
            $BTN_APPLY.Enabled = $true
		}
		elseif ($CB_FWD_Immediate.Checked -eq $false){
			$LB_DelegateUsers.Enabled = $false
            $TB_FWD_DEST.Enabled =  $false
            $BTN_APPLY.Enabled = $true
			}
		}

function SET_CHG_SIM_RING_DEL
{
	$script:SIMUL_RING_DEL = 'changed'
		
		if ($CB_SIM_RING_DEL.Checked -eq $true){
			$CB_SIM_RING_DEL.Enabled = $true
            $LB_DelegateUsers.Enabled = $true
            $TB_User_Ringtime.Enabled = $true
            $TB_User_RingTime.Text = '20'
			$LB_User_ring_time.Text = 'Delay before ringing delegates'
            $BTN_APPLY.Enabled = $true
            $BTN_REM_DEL.Enabled = $true
            $BTN_SEARCH_DEL.Enabled = $true
		}
		elseif ($CB_SIM_RING_DEL.Checked -eq $false){
				$LB_DelegateUsers.Enabled = $false
				$TB_User_Ringtime.Enabled = $false
                $TB_User_RingTime.Text = ''
                $BTN_APPLY.Enabled = $true
                $BTN_REM_DEL.Enabled = $false
                $BTN_SEARCH_DEL.Enabled = $false
		}
}

function SET_CHG_FWD_TO_DEL
{
	$script:FWD_TO_DEL = 'changed'
			if ($CB_FWD_TO_DEL.Checked -eq $true){
                    $CB_FWD_TO_DEL.Enabled = $true
					$LB_DelegateUsers.Enabled = $true
					#$TB_User_Ringtime.Enabled = $true
                    #$TB_User_RingTime.Text = '20'
					#$LB_User_ring_time.Text = 'Delay before ringing delegates'
                    $BTN_APPLY.Enabled = $true
                    $BTN_REM_DEL.Enabled = $true
                    $BTN_SEARCH_DEL.Enabled = $true
			}
			elseif ($CB_FWD_TO_DEL.Checked -eq $false){
					$LB_DelegateUsers.Enabled = $false
					#$TB_User_Ringtime.Enabled = $false
                    #$TB_User_RingTime.Text = ''
                    $BTN_APPLY.Enabled = $true
                    $BTN_REM_DEL.Enabled = $false
                    $BTN_SEARCH_DEL.Enabled = $false
			}
}

function SET_CHG_USR_RING_TIME
{
	$script:CHG_USER_RING_TIME = 'changed'
}

function SET_CHG_GRP_PICKUP
{
	$script:GRP_PICKUP = 'changed'
			if ($CB_GRP_PICKUP.Checked -eq $true){
				$CB_GRP_PICKUP.Enabled = $true
                $TB_GRP_PICKUP_NR.Enabled = $true
                $BTN_APPLY.Enabled = $true
				}
			elseif ($CB_GRP_PICKUP.Checked -eq $false){
				$TB_GRP_PICKUP_NR.Enabled = $false
                $BTN_APPLY.Enabled = $true
				}
}

function SET_CHG_SIM_RING_TEAM
{
	$script:SIM_RING_TEAM = 'changed'
		if ($CB_SIM_RING_TEAM.Checked -eq $true){
				$CB_SIM_RING_TEAM.Enabled = $true
                $LB_DelegateUsers.Enabled = $true
				$LB_User_ring_time.Text = 'Delay before ringing team'
				$TB_User_RingTime.Text = '20'
				$TB_User_RingTime.Enabled = $true
                $BTN_APPLY.Enabled = $true
                $BTN_REM_TEAM_M.Enabled = $true
		}
		elseif ($CB_SIM_RING_TEAM.Checked -eq $false){
				$LB_DelegateUsers.Enabled = $false
				$TB_User_RingTime.Enabled = $false
                $TB_User_RingTime.Text = ''
                $BTN_APPLY.Enabled = $true
                $BTN_REM_TEAM_M.Enabled = $false
		}
}

function SET_CHG_SIM_RING
{
	$script:SIM_RING = 'changed'
		if ($CB_SIM_RING.Checked -eq $true){
			$CB_SIM_RING.Enabled = $true
            $LB_DelegateUsers.Enabled = $true
			$CB_SIM_RING_DEST.Enabled = $true
            $BTN_APPLY.Enabled = $true
		}
		elseif ($CB_SIM_RING.Checked -eq $false){
			$LB_DelegateUsers.Enabled = $false
            $CB_SIM_RING_DEST.Enabled = $false
            $BTN_APPLY.Enabled = $true
		}
}

function SET_FWD_NO_ANSWER_DEST
{
	$script:SET_FWD_NO_ANSWER_DEST_CHANGED = 'changed'
	if($TB_FWD_DEST.BackColor -eq [System.Drawing.Color]::FromArgb(255,191,205,219)){
		$TB_FWD_DEST.BackColor = ''
	}
}

function SET_CHG_SIM_RING_DEST
{
	$script:SET_SIM_RING_DEST_CHANGED = 'changed'
	if($CB_SIM_RING_DEST.BackColor -eq [System.Drawing.Color]::FromArgb(255,191,205,219)){
		$CB_SIM_RING_DEST.BackColor = ''
	}
}

function SET_CHG_POOLS
{
    $script:pool = $CB_Pools.SelectedItem
    $poolversion = (Get-CsService -PoolFqdn $pool -registrar).Version
	resetVariables
    resetCheckboxes
	
    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
    $TB_LOG.Appendtext("Using domain controller: $dc `r`n")

    if($poolversion -eq '5'){
	    $script:SEFAUtilPath = $Lync2010
	    $script:Version = '2010'
	    remove-item alias:\SEFAUTIL
        Set-Alias SEFAUTIL $SEFAUtilPath -scope global
	    Set-Alias SEFAUTIL $SEFAUtilPath
	    If (Test-Path $SEFAUtilPath`){
	    $detected = $true
	    }
	    Else{
	    Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	    $detected = $false
	    }
    }
    Elseif ($poolversion -eq '6'){
	    $script:SEFAUtilPath = $Lync2013
	    $script:Version = '2013'
	    remove-item alias:\SEFAUTIL
        Set-Alias SEFAUTIL $SEFAUtilPath -scope global
	    Set-Alias SEFAUTIL $SEFAUtilPath
	    If (Test-Path $SEFAUtilPath){
	    $detected = $true
	    }
	    Else{
	    Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	    $detected = $false
	    }
    }
    Elseif ($poolversion -eq '7'){
	    $script:SEFAUtilPath = $SfB2015
	    $script:Version = 'SfB2015'
	    remove-item alias:\SEFAUTIL
        Set-Alias SEFAUTIL $SEFAUtilPath -scope global
	    If (Test-Path $SEFAUtilPath){
	    $detected = $true
	    }
	    Else{
	    Write-host "SEFAUtil.exe is not found, make sure it is installed and verify if the path exists"		
	    $detected = $false
	    }
    }
    Else{
	    $detected = $false
    }

	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	if($Version -eq 'SfB2015'){
		$CB_SIM_RING.Visible = $True
		$CB_GRP_PICKUP.Visible = $True
		$CB_SIM_RING_TEAM.Visible = $True
		$BTN_REM_TEAM_M.Visible = $True
		$TB_GRP_PICKUP_NR.Visible = $true
		$LB_GRP_PICKUP.Visible = $true
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Skype for Business Server 2015 detected`r`n")	
		}
    elseif($Version -eq '2013'){
		$CB_SIM_RING.Visible = $True
		$CB_GRP_PICKUP.Visible = $True
		$CB_SIM_RING_TEAM.Visible = $True
		$BTN_REM_TEAM_M.Visible = $True
		$TB_GRP_PICKUP_NR.Visible = $true
		$LB_GRP_PICKUP.Visible = $true
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Lync 2013 detected`r`n")	
		}
	elseif($Version -eq '2010'){
		$TB_LYNC_VER.text = $Version
		$TB_LOG.AppendText("Lync 2010 detected`r`n")
		}

    $CB_Pools.SelectedItem = $pool

    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
    $TB_LOG.AppendText("Trying to retrieve the status of all Lync/Skype for Business enabled users `r`n")
    $statusBar.text = 'Status: retrieving all Lync/Skype for Business enabled users'
    $script:users= Get-CsUser -DomainController $dc -resultsize unlimited|where {$_.RegistrarPool -like $pool}| sort DisplayName
    
    $LB_SourceUsers.Items.Clear()

    foreach ($user in $users)
    {    
      [void] $LB_SourceUsers.Items.Add($user.DisplayName)
    }
    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
    $TB_LOG.AppendText("Lync/Skype for Business enabled users added to listboxes `r`n")
    $statusBar.text = 'Status: retrieved all Lync/Skype for Business enabled users'

}
#endregion

function resetVariables
{
	$script:FWD_IMMEDIATE = $NULL
	$script:FWD_NO_ANSWER = $NULL
	$script:SIMUL_RING_DEL = $NULL
	$script:FWD_TO_DEL = $NULL
	$script:CHG_USER_RING_TIME = $NULL
	$script:DELEGATE_CHANGED = $NULL
	$script:REM_DEL = $NULL
	$script:CHG_USER_RING_TIME = $NULL
	$script:GRP_PICKUP = $NULL
	$script:SIM_RING_TEAM = $NULL
	$script:SIM_RING = $NULL
	$script:SET_SIM_RING_DEST_CHANGED = $NULL
	$script:SET_FWD_NOANSWER_DEST_CHANGED = $NULL
	$script:SET_DELEGATE = $NULL
	$script:REMOVE_DELEGATE = $NULL
	$script:GROUPID_CHANGED = $NULL
	$script:NO_OPTIONS = $NULL
	$getDelegateInfo = $NULL
}

function resetCheckBoxes
{
	if($FWD_IMMEDIATE -eq $NULL){
		$CB_FWD_Immediate.Checked = $false
	}
	elseif ($FWD_NO_ANSWER -eq $NULL){
		$CB_FWD_NOANSWER.Checked = $false
	}
	elseif ($SIMUL_RING_DEL -eq $NULL){
		$CB_SIM_RING_DEL.Checked = $false
	}
	elseif ($FWD_TO_DEL -eq $NULL){
		$CB_FWD_TO_DEL.Checked = $false
	}
	elseif ($GRP_PICKUP -eq $NULL){
		$CB_GRP_PICKUP.Checked = $false
	}
	elseif ($SIM_RING_TEAM -eq $NULL){
		$CB_SIM_RING_TEAM.Checked = $false
	}
	elseif ($SIM_RING -eq $NULL){
		$CB_SIM_RING.Checked = $false	
	}
}

function loadData
{
$CB_FWD_NOANSWER.Enabled = $false
$CB_FWD_Immediate.Enabled = $false
$CB_FWD_TO_DEL.Enabled = $false
$CB_SIM_RING_DEL.Enabled = $false
$CB_SIM_RING_TEAM.Enabled = $false
$CB_SIM_RING.Enabled = $false
$CB_DISABLE_ALL.Enabled = $false
$CB_GRP_PICKUP.Enabled = $false
$BTN_REM_DEL.Enabled = $false
$BTN_SEARCH_DEL.Enabled = $false
$BTN_APPLY.Enabled = $false
$BTN_REM_TEAM_M.Enabled = $false
$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
$TB_LOG.AppendText("Trying to retrieve the status of all Lync/Skype for Business enabled users `r`n")
$statusBar.text = 'Status: retrieving all Lync/Skype for Business enabled users'
$script:users= Get-CsUser -DomainController $dc -resultsize unlimited|where {$_.RegistrarPool -like $pool}| sort DisplayName
foreach ($user in $users)
  {    
      [void] $LB_SourceUsers.Items.Add($user.DisplayName)
  }
$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
$TB_LOG.AppendText("Lync/Skype for Business enabled users added to listboxes `r`n")
$script:users_delegates= Get-CsUser -DomainController $dc -resultsize unlimited| sort DisplayName
foreach ($delegate in $users_delegates)
  {    
	  [void] $LB_DelegateUsers.Items.Add($delegate.DisplayName)
  }
$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
$TB_LOG.AppendText("Lync/Skype for Business enabled delegates added to listboxes `r`n")
$statusBar.text = 'Status: users retrieved'  
}

function GetUserInfo
{
	$statusBar.text = 'status: Retrieving user info'
	$LB_User_Details.Items.Clear()
	$CB_FWD_Immediate.Checked = $false
	$CB_FWD_NOANSWER.Checked = $false
	$CB_SIM_RING_DEL.Checked = $false
	$CB_FWD_TO_DEL.Checked = $false
	$CB_SIM_RING_TEAM.Checked = $false
	$CB_SIM_RING.Checked = $false
	$CB_GRP_PICKUP.Checked = $false
	$LB_DelegateUsers.ClearSelected()
	$TB_FWD_DEST.Text = $NULL
	$TB_GRP_PICKUP_NR.Text = $NULL
	$CB_SIM_RING_DEST.Text = $NULL
	$TB_User_Ringtime.Text = $NULL
	$selecteduser = $LB_SourceUsers.SelectedItem
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.AppendText("Retrieving user info for $selecteduser `r`n")
	$getUserInfo= Get-CsAdUser -identity $selecteduser -DomainController $dc
	SRC_USER -userid $($getUserInfo.SipAddress.ToLower().Replace('sip:',''))
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.AppendText("User info retrieved updating GUI `r`n")
	foreach ($item in $settings)
	  {    
	      [void] $LB_User_Details.Items.Add($item) 
	  }
	foreach ($item in $getUserInfo)
	  {    
	  	$CB_SIM_RING_DEST.Items.Clear()
	    $SIM_RING_NUMBERS=@()
		$SIM_RING_NUMBERS = $item|select *Phone
		if ($SIM_RING_NUMBERS.homePhone)
		{ 	
	    		[void] $CB_SIM_RING_DEST.Items.Add('Home') 
		}
		if ($SIM_RING_NUMBERS.ipPhone)
		{
	    		[void] $CB_SIM_RING_DEST.Items.Add('IP') 
		}
		if ($SIM_RING_NUMBERS.ipPhone)
		{
	    		[void] $CB_SIM_RING_DEST.Items.Add('Mobile') 
		}
	  }  
	CHK_CALL_FWD_NO_ANSWER
	CHK_FWD_IM
	CHK_SIM_RING_DEL
	CHK_SIM_RING_TO
	CHK_FWD_DEL
	CHK_GRP_PICKUP
	CHK_TEAM_RING

    $CB_FWD_NOANSWER.Enabled = $true
    $CB_FWD_Immediate.Enabled = $true
    $CB_FWD_TO_DEL.Enabled = $true
    $CB_SIM_RING_DEL.Enabled = $true
    $CB_SIM_RING_TEAM.Enabled = $true
    $CB_SIM_RING.Enabled = $true
    $CB_DISABLE_ALL.Enabled = $true
    $CB_GRP_PICKUP.Enabled = $true 

    $BTN_APPLY.Enabled = $false

	resetVariables
	$statusBar.text = 'status: User info retrieved'
}

function SEARCH_DEL
{
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.AppendText("Searching for suggested delegates started `r`n")
	$statusBar.text = 'status: Searching for suggested delegates'
	$selecteduser = $LB_SourceUsers.SelectedItem
	$LB_DelegateUsers.ClearSelected()
	$userid = Get-CsUser -identity $selecteduser -DomainController $dc
	$searchstring = Get-AdUser $userid.SamAccountName -server $dc -Properties Manager|select SamAccountName,Manager
	if ($searchstring.Manager -ne $null){
		$found_del = @()
		foreach ($user in $users){
			$found_del = $found_del + $(Get-AdUser $user.SamAccountName -server $dc -Properties Manager|?{($_.Manager -like $searchstring.Manager) -and ($_.SamAccountName -ne $userid.SamAccountName)})
		}
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$founditems = $found_del.Count
		$TB_LOG.AppendText("$founditems suggested delegate(s) found `r`n")
		foreach ($delegate in $found_del){
				$LB_DelegateUsers.SelectedItem = $delegate.Name
		}
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.AppendText("Searching for suggested delegates completed `r`n")
		$statusBar.text = 'status: Searching for suggested delegates completed'
	}
	else{
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.AppendText("No suggested delegates found `r`n")
		$TB_LOG.Appendtext("$time`t")
		$TB_LOG.AppendText("Searching for suggested delegates completed `r`n")
		$statusBar.text = 'status: Searching for suggested delegates completed'
	}
}

function SET_GROUPID
{
	$script:GROUPID_CHANGED = 'changed'
	$TB_GRP_PICKUP_NR.BackColor = ''
}

function SET_DELEGATE
{
	$script:DELEGATE_CHANGED = 'changed'
	if($LB_DelegateUsers.BackColor -eq [System.Drawing.Color]::FromArgb(255,219,205,219)){
		$LB_DelegateUsers.BackColor = ''
	}
}

function REMOVE_DELEGATE
{
	$statusBar.Text = 'Removing delegate: ' + $LB_DelegateUsers.SelectedItem
    $output = SEFAUTIL /Server:$pool $((Get-CsUser -identity $($LB_SourceUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:','')) /removedelegate:$((Get-CsUser -identity $($LB_DelegateUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:',''))
	GetUserInfo
}

function ADD_TEAM_MEMBER
{
	$statusBar.Text = 'Removing team member: ' + $LB_DelegateUsers.SelectedItem
	$output = SEFAUTIL /Server:$pool $((Get-CsUser -identity $($LB_SourceUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:','')) /addteammember:$((Get-CsUser -identity $($LB_DelegateUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:',''))
	GetUserInfo
}

function REMOVE_TEAM_M
{
	$statusBar.Text = 'Removing team member: ' + $LB_DelegateUsers.SelectedItem
	$output = SEFAUTIL /Server:$pool $((Get-CsUser -identity $($LB_SourceUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:','')) /removeteammember:$((Get-CsUser -identity $($LB_DelegateUsers.SelectedItem)).SipAddress.ToLower().Replace('sip:',''))
	GetUserInfo
}

function APPLY
{
	
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.Appendtext("Applying changes `r`n")
	$statusBar.text = 'status: Applying new settings'
	$selecteduser = $LB_SourceUsers.SelectedItem
	$selectedDelegate = @()
	$selectedDelegate = $LB_DelegateUsers.SelectedItems
	$getUserInfo = Get-CsUser -identity $selecteduser -DomainController $dc
	
	
	if ($FWD_NO_ANSWER -eq 'changed'){
		If(($CB_FWD_NOANSWER.Checked -eq $true) -and $selecteddelegate -ne $null){
            foreach($selectedDel in $selecteddelegate){
			$getDelegateInfo = Get-CsUser -identity $selectedDel -DomainController $dc
            }
		}
		if ($getDelegateInfo){
			if ($CB_FWD_NOANSWER.Checked -eq $true){
				$statusBar.text = 'status: Enable forward no answer'	
				$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enabling forward no answer `r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablefwdnoanswer /setfwddestination:$($getDelegateInfo.SipAddress.ToLower().Replace('sip:','')) /callanswerwaittime:$($TB_User_Ringtime.text)
			    }
           }
        Elseif($CB_FWD_NOANSWER.Checked -eq $true){
            $statusBar.text = 'status: Enable forward no answer'	
			$time = Get-Date -format "dd-MM-yyyy HH:mm:ss"
			$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
			$TB_LOG.Appendtext("Enabling forward no answer `r`n")
            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablefwdnoanswer /setfwddestination:$($TB_FWD_DEST.text) /callanswerwaittime:$($TB_User_Ringtime.text)
			$SET_FWD_NOANSWER_DEST_CHANGED = $NULL
		 }
		Elseif($CB_FWD_NOANSWER.Checked -eq $false){
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Disable forward no answer `r`n")
				$statusBar.text = 'status: Disable forward no answer'
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /disablefwdnoanswer
		}
	}
	
	if ($FWD_IMMEDIATE -eq 'changed'){
        foreach($selectedDel in $selecteddelegate){
		$getDelegateInfo = Get-CsUser -identity $selectedDel
		}
		if ($getDelegateInfo -and $CB_FWD_Immediate.Checked -eq $true){
				$statusBar.text = 'status: Enable forward immediate'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enabling forward immediate `r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablefwdimmediate /setfwddestination:$($getDelegateInfo.SipAddress.ToLower().Replace('sip:',''))
        }
	    elseif ($CB_FWD_Immediate.Checked -eq $true){
                $statusBar.text = 'status: Enable forward immediate'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enabling forward immediate `r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablefwdimmediate /setfwddestination:$($TB_FWD_DEST.text)
			}	
        elseif ($CB_FWD_Immediate.Checked -eq $false){
                $statusBar.text = 'status: Disable forward immediate'
				$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Disable forward immediate `r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /disablefwdimmediate
			}
	}
	
	if ($SIMUL_RING_DEL -eq 'changed'){
			if ($CB_SIM_RING_DEL.Checked -eq $true){
				$statusBar.text = 'status: Enabling Simultaneous ring delegate'
				foreach ($selectedDel in $selectedDelegate){
					$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
					$TB_LOG.Appendtext("Enabling simultaneous ring delegates `r`n")
					$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /adddelegate:$((Get-CsUser -identity $($selectedDel)).SipAddress.ToLower().Replace('sip:','')) /simulringdelegates
				}
			}
		    Elseif ($CB_SIM_RING_DEL.Checked -eq $false){
				$statusBar.text = 'status: Disabling Simultaneous ring delegate'
				foreach ($selectedDel in $selectedDelegate){
					$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
					$TB_LOG.Appendtext("Disabling simultaneous ring delegates `r`n")
					$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /removedelegate:$((Get-CsUser -identity $($selectedDel)).SipAddress.ToLower().Replace('sip:',''))
				}
				}
			}	
	
	if ($FWD_TO_DEL -eq 'changed'){
			if ($CB_FWD_TO_DEL.Checked -eq $true){
				$statusBar.text = 'status: Enable forward to delegate'
				$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enabling forward to delegate `r`n")
				foreach ($selectedDel in $selectedDelegate){
					$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /adddelegate:$((Get-CsUser -identity $($selectedDel)).SipAddress.ToLower().Replace('sip:','')) /fwdtodelegates
				}
			}
		    else {
                $statusBar.text = 'status: Disable forward to delegate'
				$time = Get-Date -format "dd-MM-yyyy HH:mm:ss"
				$TB_LOG.Appendtext("$time`t")
				$TB_LOG.Appendtext("Disabling forward to delegate `r`n")
				foreach ($selectedDel in $selectedDelegate){
					$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /removedelegate:$((Get-CsUser -identity $($selectedDel)).SipAddress.ToLower().Replace('sip:',''))
		            }
                 }
     }

	if ($SIM_RING_TEAM -eq 'changed'){
			if ($CB_SIM_RING_TEAM.Checked -eq $true){
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enable simultaneous ring group `r`n")
				$statusBar.text = 'status: Enable simultaneous ring group'
				foreach ($selectedDel in $selectedDelegate){
					$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /addteammember:$((Get-CsUser -identity $($selectedDel)).SipAddress.ToLower().Replace('sip:','')) /simulringteam
				}
			}
			else{
				$statusBar.text = 'status: Disable simultaneous ring group'
				$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Disable simultaneous ring group `r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /disableteamcall
			}
		}
	else {
		}
	
	if ($SIM_RING -eq 'changed'){
			if ($CB_SIM_RING.Checked -eq $true){
				$statusBar.text = 'status: Enable simultaneous ring'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enable simultaneous ring`r`n")
                
                foreach($selectedDel in $selecteddelegate){
			        $getDelegateInfo = Get-CsUser -identity $selectedDel -DomainController $dc
                }

                if ($getDelegateInfo){
					if ($CB_SIM_RING.Checked -eq $true){
						$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$($getDelegateInfo.SipAddress.ToLower().Replace('sip:','')) /enablesimulring
						}
				}
				elseif($CB_SIM_RING_DEST.text -ne ""){
					if ($CB_SIM_RING.Checked -eq $true){
                        if ($CB_SIM_RING_DEST.SelectedItem -eq "Home"){                            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$((Get-CsAdUser -identity $getUserInfo.Identity).homePhone) /enablesimulring                        }                        elseif($CB_SIM_RING_DEST.SelectedItem -eq "IP"){                            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$((Get-CsAdUser -identity $getUserInfo.Identity).IPPhone) /enablesimulring                        }                        elseif($CB_SIM_RING_DEST.SelectedItem -eq "Mobile"){                            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$((Get-CsAdUser -identity $getUserInfo.Identity).MobilePhone) /enablesimulring                        }
                        else
                        {                        
                            $temp = $CB_SIM_RING_DEST.text
                            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$temp /enablesimulring

                        }
					}
				}
                $SET_SIM_RING_DEST_CHANGED = ""
			}
			if ($CB_SIM_RING.Checked -eq $false){
				$statusBar.text = 'status: Disable simultaneous ring'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Disable simultaneous ring`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /disablesimulring
			}

		}
	else {
		}

	if ($GRP_PICKUP -eq 'changed'){
			if ($CB_GRP_PICKUP.Checked -eq $true){
				$statusBar.text = 'status: Enable group pickup'
				$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Enable group pickup`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablegrouppickup:$($TB_GRP_PICKUP_NR.text)
				$GROUPID_CHANGED = $NULL
			}
			elseif ($CB_GRP_PICKUP.Checked -eq $false){
				$statusBar.text = 'status: Disable group pickup'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Disable group pickup`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /disablegrouppickup
				$GROUPID_CHANGED = $NULL
			}
		}
		else {
		}
	
	if ($GROUPID_CHANGED -eq 'changed'){
			if ($CB_GRP_PICKUP.Checked -eq $true){
				$statusBar.text = 'status: Changing group ID'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Changing group ID`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablegrouppickup:$($TB_GRP_PICKUP_NR.text)
			}
		}
		else {
		}
	
	if($SET_SIM_RING_DEST_CHANGED -eq 'changed'){
		if ($getDelegateInfo){
			if ($CB_SIM_RING.Checked -eq $true){
				$statusBar.text = 'status: Changing simultaneous ring destination'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Changing simultaneous ring destination`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$($getDelegateInfo.SipAddress.ToLower().Replace('sip:','')) /enablesimulring
						}
		}
		elseif($CB_SIM_RING_DEST -ne $NULL){
			if ($CB_SIM_RING.Checked -eq $true){
				$statusBar.text = 'status: Changing simultaneous ring destination'
			    $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
				$TB_LOG.Appendtext("Changing simultaneous ring destination`r`n")
				$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /setsimulringdestination:$($CB_SIM_RING_DEST.text) /enablesimulring
			}
		}
	}

	if($SET_FWD_NOANSWER_DEST_CHANGED -eq 'changed'){
		if ($CB_FWD_NOANSWER.Checked -eq $true){
			$statusBar.text = 'status: Changing forward no answer destination'
			$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
			$TB_LOG.Appendtext("Changing forward no answer destination`r`n")
			$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /enablefwdnoanswer /setfwddestination:$TB_FWD_DEST
		}
	}
	
    if ($CHG_USER_RING_TIME -eq 'changed'){
		if ($CB_FWD_Immediate.Checked -eq $true){
			$statusBar.text = 'status: Change call answer wait time'
			$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
			$TB_LOG.Appendtext("Changing call answer wait time `r`n")
			$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /callanswerwaittime:$($TB_User_Ringtime.text)
		}
		if ($CB_SIM_RING_DEL.Checked -eq $true){
			$statusBar.text = 'status: Change time before simultaneous ringing to delegates'
			$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
			$TB_LOG.Appendtext("Changing time before simultaneous ringing to delegates `r`n")
			$output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /delayringdelegates:$($TB_User_Ringtime.text)
		}
        if($CB_SIM_RING_TEAM.Checked -eq $true){
            $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
			$TB_LOG.Appendtext("Modify delay ring to team `r`n")
			$statusBar.text = 'status: Modifying delay ring to team'
            $output = SEFAUTIL /Server:$pool $($getUserInfo.SipAddress.ToLower().Replace('sip:','')) /delayringteam:$($TB_User_Ringtime.text)
        }
	}

	if($NO_OPTIONS -eq $true){
		$statusBar.text = 'status: No options configured for user'
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.Appendtext("No options configured for user`r`n")
	}
	
	if($restore -eq $true){
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		if($NO_OPTIONS -ne $true){
			$TB_LOG.AppendText("Following action was performed:")
			$TB_LOG.AppendText("$output `r`n")
			$TB_LOG.AppendText("`r`n")
		}
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.AppendText("Restore completed for user $user `r`n")
		$TB_LOG.AppendText("`r`n")
		resetVariables
	}
	Else{
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
		$TB_LOG.AppendText("Following action was performed:")
		$TB_LOG.AppendText("$output `r`n")
		$TB_LOG.AppendText("`r`n")
		resetVariables
	}
    GetUserInfo
}

function BACKUP_ALL
{
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.Appendtext("Backup all proces started `r`n")
	$statusBar.text = 'status: backup all proces started'
	foreach ($user in $users)
  	{    
	  $TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	  $TB_LOG.Appendtext("Creating a backup of settings for user $($user.DisplayName) `r`n")
      $statusBar.text = 'status: creating a backup of the settings for user ' + $user.DisplayName
	  
      SRC_USER -userid $($user.SipAddress.ToLower().Replace('sip:',''))
      ConnectSQL -query "select distinct UserAtHost,convert(varchar(4000),convert(varbinary(4000),Data)) `
	                    from PublishedStaticInstance,Resource `
	                    where PublisherId = '$ResourceId' and ResourceId = PublisherId and CategoryId = '8'"

	  foreach ($Row in $data)
	  { 
	    [string]$Setting = $Row[1]
        $filename = $user.DisplayName + '.xml'
        $Setting|Out-File $filename
  	  }
	  $statusBar.text = 'status: completed'
    }
}

function RESTORE_ALL
{
	$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	$TB_LOG.Appendtext("Restore all proces started `r`n")
	$statusBar.text = 'status: restore all proces started'
	$script:restore = $true
    $users= Get-CsUser -DomainController $dc -resultsize unlimited|sort DisplayName
	foreach ($user in $users)
	{    
		$TB_LOG.Appendtext("$(Get-Date -format "dd-MM-yyyy HH:mm:ss")`t")
	  	$TB_LOG.Appendtext("Reading setting from file `r`n")
	  	$statusBar.text = 'status: reading settings from file'
	  	$LB_SourceUsers.SelectedItem = $user.DisplayName
	  	$filename = $user.DisplayName + '.xml'
	  	$settings = Get-Content $filename
	  	$time = Get-Date -format "dd-MM-yyyy HH:mm:ss"
	  	$TB_LOG.Appendtext("$time`t")
	  	$TB_LOG.Appendtext("Restoring settings for user $user `r`n")
	  	$statusBar.text = 'status: restoring settings for user ' + $user.DisplayName
        $mode = "restore"

        CHK_CALL_FWD_NO_ANSWER
		CHK_FWD_IM
		CHK_SIM_RING_DEL
		CHK_SIM_RING_TO
		CHK_FWD_DEL
		CHK_GRP_PICKUP
		CHK_TEAM_RING
        APPLY
				
  	}
}
#Call the Function
GenerateForm