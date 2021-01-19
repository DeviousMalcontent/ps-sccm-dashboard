# Get the start-up directory of the PowerShell script so that we can load the settings file. 
Write-Host "Script start-up path: "
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Write-Host $PSScriptRoot
Write-Host ""

# Script needs to be run as Administrator, 
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

# Load the settings file
# Get-Content $PSScriptRoot\Settings.ini | Foreach-Object{ # - prod
Get-Content $PSScriptRoot\mySettings.ini | Foreach-Object{
   $var = $_.Split('=')
   New-Variable -Name $var[0] -Value $var[1]
}

# Debug
Write-Host "Loaded variables from settings file: "
Write-Host $siteCode
Write-Host $deviceCollectionsName
#Write-Host $deviceCollectionsAttributes
Write-Host $deviceCollectionsCompareAgainstReferenceSystem
#Write-Host $deviceCollectionsReferenceSystemHost
#Write-Host $carouselInterval
#Write-Host $dashboardRefreshRate


# Get the IP address of our host computer so that it can be added to the httplistener
$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address

# Listening url.
$url1 = 'http://' + $ipV4.IPAddressToString + ':80/'
$url2 = 'http://' + $env:computername + ':80/'
$url3 = 'http://localhost:80/'

# Html Template
$template = @'
<!DOCTYPE html>
<html lang="en">
<head>
<title>Student Workstations Dashboard</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
body{overflow-y:scroll}table{border-collapse:collapse;width:100%}td,th{border:1px solid #ddd;text-align:left;padding:8px}tr:nth-child(even){background-color:#ddd}ol.carousel-indicators{position:absolute;top:0;margin:0;top:0;left:0;right:0;width:auto}ol.carousel-indicators li,ol.carousel-indicators li.active{float:left;width:25%;height:10px;margin:0;border-radius:0;border:0;background:0 0}ol.carousel-indicators li.active{background:#ff0}.transition-timer-carousel-progress-bar{height:5px;background-color:#c40000;width:0%;margin:0;border:none;z-index:11;position:relative}
</style>
</head>
<body>
<script>
$(document).ready(function(){var n=0,r=$(".transition-timer-carousel-progress-bar"),e=$("#Carousel");function t(){r.css({width:n+"%"}),(n+=.5)>100&&(n=0)}e.carousel({interval:!1,pause:!0}).on("slid.bs.carousel",function(){});var a=setInterval(t,100);e.hover(function(){clearInterval(a)},function(){a=setInterval(t,100)})});
</script>
<hr class="transition-timer-carousel-progress-bar" />
<div id="Carousel" class="carousel slide" data-ride="carousel" data-interval="20000" style="margin 10px;">
<ol class="carousel-indicators">
<li data-target="#Carousel" data-slide-to="0" class="active"></li>
<li data-target="#Carousel" data-slide-to="1"></li>
<li data-target="#Carousel" data-slide-to="2"></li>
<li data-target="#Carousel" data-slide-to="3"></li>
</ol>
<div class="carousel-inner" style="width:100%; height: 100%px;">
{page}
</div>
</div>
</body>
</html>
'@

#<div class="item active">
#<h2>Student Workstations: LAB A</h2>
#{page}
#</div>

# SCCM console commands

#Reference: 
#Get started with Configuration Manager cmdlets
#https://docs.microsoft.com/en-us/powershell/sccm/overview?view=sccm-ps 

Set-Location $env:SMS_ADMIN_UI_PATH\..\
#Set-Location 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin'
#Set-Location 'C:\Program Files (x86)\Microsoft Endpoint Manager\AdminConsole\bin'

Import-Module .\ConfigurationManager.psd1
Set-Location $siteCode

$deviceCollectionArray = $deviceCollectionsName.Split(",")
Foreach ($deviceCollection in $deviceCollectionArray)
{
$deviceCollectionLookUp = $deviceCollection -replace '"'
$CollectionDataTemp = Get-CMDevice -CollectionName $deviceCollectionLookUp | select-object Name,ClientActiveStatus,ClientVersion,DeviceOSBuild,LastPolicyRequest | ConvertTo-Html -Property Name,ClientActiveStatus,ClientVersion,DeviceOSBuild,LastPolicyRequest | out-string

# Do this, or mess around with regex for the next 40 minutes...
$CollectionDataTemp = $CollectionDataTemp -replace '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '<html xmlns="http://www.w3.org/1999/xhtml">\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '<head>\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '<title>HTML TABLE</title>\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '</head><body>\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '<colgroup><col/><col/><col/><col/><col/></colgroup>\r\n'
$CollectionDataTemp = $CollectionDataTemp -replace '</body></html>\r\n'

$CollectionString = $CollectionString + '<div class="item active">'
$CollectionString = $CollectionString + '<h2>'
$CollectionString = $CollectionString + $deviceCollectionLookUp
$CollectionString = $CollectionString + '</h2>'
$CollectionString = $CollectionString + $CollectionDataTemp
$CollectionString = $CollectionString + '</div>'

Clear-Variable -Name "CollectionDataTemp"
}

# Debug
Write-Host "Collection entries: "
Write-Host $CollectionString

$output = ' ' +  $CollectionString + ' '

# HTTP routing for requests.
$routes = @{
    '/index'  = { 
      $page = render $output
    return (render $template $page) }
    'GET /'  = { 
      $page = render $output
    return (render $template $page) }
    'POST /' = {
      $page = render $output
    return (render $template $page)
  }
}

# Embed the collection entries into the HTML template.
function render($template, $content) {
  # Define the shorthand used for rendering the template.
  if ($content -is [string]) { $content = @{page = $content} }

  foreach ($key in $content.keys) {
    $template = $template -replace "{$key}", $content[$key]
  }

  return $template
}

# Start httplistener
$listener = new-object system.net.httplistener
$listener.prefixes.add($url3)
$listener.prefixes.add($url2)
$listener.prefixes.add($url1)
$listener.start()

# Debug
Write-Host "Listening on the following addresses: "
Write-Host $url1
Write-Host $url2
Write-Host $url3

#Httplistener loop 
while ($listener.islistening) {
  $context = $listener.getcontext()
  $request = $context.request
  $response = $context.response

  $pattern = "{0} {1}" -f $request.httpmethod, $request.url.localpath
  $route = $routes.get_item($pattern)

  if ($route -eq $null) {
    $response.statuscode = 404
	#$response.statuscode = 200
	render $template
  } else {
    $content = & $route
    $buffer = [system.text.encoding]::utf8.getbytes($content)
    $response.contentlength64 = $buffer.length
    $response.outputstream.write($buffer, 0, $buffer.length)
  }
  $response.close()
}