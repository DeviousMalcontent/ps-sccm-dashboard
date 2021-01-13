# Script needs to be run as Administrator, 
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

# Get the IP address of our host computer so that it can be added to the httplistener
$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address

# listening url.
$url1 = 'http://' + $ipV4.IPAddressToString + ':80/'
$url2 = 'http://' + $env:computername + ':80/'
$url3 = 'http://localhost:80/'

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
table{border-collapse:collapse;width:100%}td,th{border:1px solid #ddd;text-align:left;padding:8px}tr:nth-child(even){background-color:#ddd}ol.carousel-indicators{position:absolute;top:0;margin:0;top:0;left:0;right:0;width:auto}ol.carousel-indicators li,ol.carousel-indicators li.active{float:left;width:25%;height:10px;margin:0;border-radius:0;border:0;background:0 0}ol.carousel-indicators li.active{background:#ff0}
</style>
</head>
<body>
<script>
var LIB="Name               : Library-PC19\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 4:07:07 AM\n\nName               : Library-PC20\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 9/08/2019 12:02:02 AM\n\nName               : Library-PC27\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 1:43:10 AM\n\nName               : Library-PC22\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:53:09 AM\n\nName               : Library-PC17\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:12:29 AM\n\nName               : Library-PC23\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 3:57:36 AM\n\nName               : Library-PC30\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:47:51 PM\n\nName               : Library-PC15\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:26:02 AM\n\nName               : Library-PC24\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 3:54:38 AM\n\nName               : Library-PC21\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:56:49 AM\n\nName               : Library-PC16\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 4:10:12 AM\n\nName               : Library-PC04\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:55:07 AM\n\nName               : Library-PC26\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 9/08/2019 2:18:44 AM\n\nName               : Library-PC38\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 6/08/2019 8:45:25 PM\n\nName               : Library-PC39\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 4:32:12 AM\n\nName               : Library-PC40\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 6/08/2019 8:56:07 PM\n\nName               : Library-PC41\nClientActiveStatus : 0\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.829\nLastPolicyRequest  : 27/06/2019 8:47:37 PM\n\nName               : Library-PC29\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 3:50:58 AM\n\nName               : Library-PC18\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 3:44:49 AM\n\nName               : Library-PC25\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 3:50:53 AM\n\nName               : Library-PC06\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 12:51:06 AM\n\nName               : Library-PC05\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:49:15 AM\n\nName               : Library-PC13\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 3:55:30 AM\n\nName               : Library-PC14\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:03:21 AM\n\nName               : Library-PC01\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 6/08/2019 8:59:30 PM\n\nName               : Library-PC07\nClientActiveStatus : 0\nClientVersion      : 5.00.8577.1108\nDeviceOSBuild      : 10.0.16299\nLastPolicyRequest  : 18/04/2018 12:30:18 AM\n\nName               : Library-PC08\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.885\nLastPolicyRequest  : 12/08/2019 3:30:33 AM\n\nName               : Library-PC09\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.885\nLastPolicyRequest  : 9/08/2019 2:56:17 AM\n\nName               : Library-PC10\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.885\nLastPolicyRequest  : 12/08/2019 4:09:07 AM\n\nName               : Library-PC11\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.885\nLastPolicyRequest  : 8/08/2019 6:46:51 AM\n\nName               : Library-PC12\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17134.885\nLastPolicyRequest  : 12/08/2019 3:57:33 AM\n\nName               : Library-PC02\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.379\nLastPolicyRequest  : 6/08/2019 8:50:47 PM\n\nName               : Library-PC37\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 5:01:22 AM";LIBarray=LIB.replace(/Name               : /gi,""),LIBarray=LIBarray.replace(/ClientActiveStatus : /gi,""),LIBarray=LIBarray.replace(/ClientVersion      : /gi,""),LIBarray=LIBarray.replace(/DeviceOSBuild      : /gi,""),LIBarray=LIBarray.replace(/LastPolicyRequest  : /gi,""),LIBarray=LIBarray.replace(/\n\n/gi,"^"),LIBarray=LIBarray.replace(/\n/g,"^ ").split("^");var LABA="Name               : Lab-A-PC01\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:38:46 PM\n\nName               : Lab-A-PC02\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:56:45 PM\n\nName               : Lab-A-PC03\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:59:41 PM\n\nName               : Lab-A-PC04\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:48:51 PM\n\nName               : Lab-A-PC05\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:54:53 PM\n\nName               : Lab-A-PC06\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:56:51 PM\n\nName               : Lab-A-PC07\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:39:48 PM\n\nName               : Lab-A-PC08\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:58:47 PM\n\nName               : Lab-A-PC09\nClientActiveStatus : 0\nClientVersion      : 5.00.8692.1008\nDeviceOSBuild      : 10.0.17134.112\nLastPolicyRequest  : 1/02/2019 5:34:30 AM\n\nName               : Lab-A-PC10\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:41:46 PM\n\nName               : Lab-A-PC11\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:37:51 PM\n\nName               : Lab-A-PC12\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:48:46 PM\n\nName               : Lab-A-PC13\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:44:42 PM\n\nName               : Lab-A-PC14\nClientActiveStatus : 0\nClientVersion      : 5.00.8692.1008\nDeviceOSBuild      : 10.0.17134.472\nLastPolicyRequest  : 29/05/2019 1:41:39 AM\n\nName               : Lab-A-PC15\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 7/08/2019 8:48:49 PM\n\nName               : Lab-A-PC16\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 9/08/2019 4:55:11 AM\n\nName               : Lab-A-PC17\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.379\nLastPolicyRequest  : 7/08/2019 8:50:10 PM\n\nName               : Lab-A-PC18\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 7/08/2019 8:42:47 PM";LABAarray=LABA.replace(/Name               : /gi,""),LABAarray=LABAarray.replace(/ClientActiveStatus : /gi,""),LABAarray=LABAarray.replace(/ClientVersion      : /gi,""),LABAarray=LABAarray.replace(/DeviceOSBuild      : /gi,""),LABAarray=LABAarray.replace(/LastPolicyRequest  : /gi,""),LABAarray=LABAarray.replace(/\n\n/gi,"^"),LABAarray=LABAarray.replace(/\n/g,"^ ").split("^");var LABB="Name               : Lab-B-PC13\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:50:54 AM\n\nName               : Lab-B-PC09\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:03:46 AM\n\nName               : Lab-B-PC11\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:59:01 AM\n\nName               : Lab-B-PC02\nClientActiveStatus : 0\nClientVersion      : 5.00.8740.1012\nDeviceOSBuild      : 10.0.17134.765\nLastPolicyRequest  : 4/06/2019 8:56:18 PM\n\nName               : Lab-B-PC17\nClientActiveStatus : 0\nClientVersion      : 5.00.8740.1012\nDeviceOSBuild      : 10.0.17134.706\nLastPolicyRequest  : 2/05/2019 8:40:15 PM\n\nName               : Lab-B-PC15\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:03:42 AM\n\nName               : Lab-B-PC03\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:56:52 AM\n\nName               : Lab-B-PC18\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:04:51 AM\n\nName               : Lab-B-PC16\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:03:18 AM\n\nName               : Lab-B-PC06\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 2:05:22 AM\n\nName               : Lab-B-PC19\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 2:01:40 AM\n\nName               : Lab-B-PC08\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 12/08/2019 1:53:11 AM\n\nName               : Lab-B-PC04\nClientActiveStatus : 0\nClientVersion      : 5.00.8740.1012\nDeviceOSBuild      : 10.0.17134.648\nLastPolicyRequest  : 16/05/2019 8:32:51 PM\n\nName               : Lab-B-PC07\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:57:03 AM\n\nName               : Lab-B-PC01\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 12/08/2019 1:52:06 AM";LABBarray=LABB.replace(/Name               : /gi,""),LABBarray=LABBarray.replace(/ClientActiveStatus : /gi,""),LABBarray=LABBarray.replace(/ClientVersion      : /gi,""),LABBarray=LABBarray.replace(/DeviceOSBuild      : /gi,""),LABBarray=LABBarray.replace(/LastPolicyRequest  : /gi,""),LABBarray=LABBarray.replace(/\n\n/gi,"^"),LABBarray=LABBarray.replace(/\n/g,"^ ").split("^");var LABC="Name               : Lab-C-PC11\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:46:59 PM\n\nName               : Lab-C-PC19\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:58:59 PM\n\nName               : Lab-C-PC07\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:51:09 PM\n\nName               : Lab-C-PC09\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:49:34 PM\n\nName               : Lab-C-PC08\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:56:54 PM\n\nName               : Lab-C-PC32\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 1:45:13 PM\n\nName               : Lab-C-PC01\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 10:25:29 PM\n\nName               : Lab-C-PC06\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:45:07 PM\n\nName               : Lab-C-PC03\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:58:47 PM\n\nName               : Lab-C-PC12\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:56:55 PM\n\nName               : Lab-C-PC17\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:47:50 PM\n\nName               : Lab-C-PC05\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:50:55 PM\n\nName               : Lab-C-PC24\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:53:43 PM\n\nName               : Lab-C-PC15\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:58:58 PM\n\nName               : Lab-C-PC26\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:59:38 PM\n\nName               : Lab-C-PC31\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:49:45 PM\n\nName               : Lab-C-PC10\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:47:46 PM\n\nName               : Lab-C-PC20\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:55:59 PM\n\nName               : Lab-C-PC23\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:56:34 PM\n\nName               : Lab-C-PC29\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:51:52 PM\n\nName               : Lab-C-PC21\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:36:56 PM\n\nName               : Lab-C-PC28\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:56:58 PM\n\nName               : Lab-C-PC22\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:49:44 PM\n\nName               : Lab-C-PC02\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 10:24:27 PM\n\nName               : Lab-C-PC33\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:47:39 PM\n\nName               : Lab-C-PC04\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:45:57 PM\n\nName               : Lab-C-PC30\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 10:25:52 PM\n\nName               : Lab-C-PC18\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.379\nLastPolicyRequest  : 8/08/2019 7:10:03 AM\n\nName               : Lab-C-PC25\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.652\nLastPolicyRequest  : 8/08/2019 8:53:42 PM\n\nName               : Lab-C-PC27\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:56:58 PM\n\nName               : Lab-C-PC16\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 10:24:13 PM\n\nName               : Lab-C-PC14\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:58:31 PM\n\nName               : Lab-C-PC13\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:56:49 PM\n\nName               : Lab-C-PC34\nClientActiveStatus : 1\nClientVersion      : 5.00.8790.1007\nDeviceOSBuild      : 10.0.17763.615\nLastPolicyRequest  : 8/08/2019 8:44:47 PM";LABCarray=LABC.replace(/Name               : /gi,""),LABCarray=LABCarray.replace(/ClientActiveStatus : /gi,""),LABCarray=LABCarray.replace(/ClientVersion      : /gi,""),LABCarray=LABCarray.replace(/DeviceOSBuild      : /gi,""),LABCarray=LABCarray.replace(/LastPolicyRequest  : /gi,""),LABCarray=LABCarray.replace(/\n\n/gi,"^"),LABCarray=LABCarray.replace(/\n/g,"^ ").split("^");
</script>
<div id="Carousel" class="carousel slide" data-ride="carousel" data-interval="20000" style="margin 10px;">
<!-- Indicators -->
<ol class="carousel-indicators">
	<li data-target="#Carousel" data-slide-to="0" class="active"></li>
	<li data-target="#Carousel" data-slide-to="1"></li>
	<li data-target="#Carousel" data-slide-to="2"></li>
	<li data-target="#Carousel" data-slide-to="3"></li>
</ol>
<!-- Wrapper for slides -->
<div class="carousel-inner" style="width:100%; height: 100%px;">
	<div class="item active">
	<h2>Student Workstations: LAB B</h2>
	<script>document.write("<table>");for(var j=0,i=0;i<LABBarray.length;i++)0==j&&document.write("<tr>"),document.write("<td>"+LABBarray[i]+"</td>"),5==++j&&(document.write("</tr>"),j=0);document.write("</table>");</script>
	</div>
	<div class="item">
	<h2>Student Workstations: LAB C</h2>
	<script>document.write("<table>");for(var j=0,i=0;i<LABCarray.length;i++)0==j&&document.write("<tr>"),document.write("<td>"+LABCarray[i]+"</td>"),5==++j&&(document.write("</tr>"),j=0);document.write("</table>");</script>
	</div>
	<div class="item">
	<h2>Student Workstations: LAB A</h2>
	<script>document.write("<table>");for(var j=0,i=0;i<LABAarray.length;i++)0==j&&document.write("<tr>"),document.write("<td>"+LABAarray[i]+"</td>"),5==++j&&(document.write("</tr>"),j=0);document.write("</table>");</script>
	</div>
	<div class="item">
	<h2>Workstations: Library Open Areas</h2>
	<script>document.write("<table>");for(var j=0,i=0;i<LIBarray.length;i++)0==j&&document.write("<tr>"),document.write("<td>"+LIBarray[i]+"</td>"),5==++j&&(document.write("</tr>"),j=0);document.write("</table>");</script>
	</div>
	</div>
	</div>
</body>
</html>
'@

# <div id="content">
# {page}
# </div>
$output = '<p>Username: ' +  $name + '<br/>EmployeeID: null<br/><br/><a href="/">Lookup Another User</a></p>'

# request actions.
$routes = @{
  '/index'  = { return (render $template) }
  'GET /'  = { return (render $template) }
  'POST /' = {
    # get post data.
    $data = extract $request

    # get the submitted name.
    $name = $data.item('person')
	
    # render snippet, passing the name.
	$output = '<p>Username: ' +  $name + '<br/>Employee ID: null <br/>Phone Number: null <br/>SessionInfo: null a href="/">Lookup Another User</a></p>'
	$page = render $output
	
    # embed the snippet into the template.
    return (render $template $page)
  }
}

# embed content into the default template.
function render($template, $content) {
  # shorthand for rendering the template.
  if ($content -is [string]) { $content = @{page = $content} }

  foreach ($key in $content.keys) {
    $template = $template -replace "{$key}", $content[$key]
  }

  return $template
}

# get post data from the input stream.
function extract($request) {
  $length = $request.contentlength64
  $buffer = new-object "byte[]" $length

  [void]$request.inputstream.read($buffer, 0, $length)
  $body = [system.text.encoding]::ascii.getstring($buffer)

  $data = @{}
  $body.split('&') | %{
    $part = $_.split('=')
    $data.add($part[0], $part[1])
  }

  return $data
}

# Strat httplistener
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