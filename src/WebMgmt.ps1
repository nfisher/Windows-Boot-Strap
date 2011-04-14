# Web Deploy: Powershell script to set up delegated deployments with Web Deploy
# Copyright (C) Microsoft Corp. 2010
#
# Requirements: IIS 7, Windows Server 2008 (or higher)
#
# This script performs some common setup operations on the IIS 7 Web Management Service


$maxTracingLogFiles = "200"
# CHANGE THIS TO YOUR DEPLOYMENT SERVER DETAILS IN THE MANAGEMENT PROFILE
$restrictions = "/wEZAgAAAAEAAABoAgAAABkBAAAAAAAAABkDAAAAAQAAAC4EA20DzAN4AyICAAAALgQD/wP/A/8D/wMAAABn"

# stop wmsvc
Stop-Service wmsvc
write-host "Info" "Stopping Web Management Service..."

# set startup type of Web Management Service (wmsvc) to automatic
Set-Service -Name wmsvc -StartupType Automatic
write-host "Info" "Set Web Management Service to autostart"

# enable remote connections for wmsvc
if( (Get-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name EnableRemoteManagement -errorAction silentlycontinue ) -eq $null){
	New-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name EnableRemoteManagement -Value 1 -PropertyType "DWord"
}
else{
	Set-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name EnableRemoteManagement -Value 1
}
write-host "Info" "Enabled remote connections for Web Management Service"

# enable tracing for wmsvc
if( (Get-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name TracingEnabled -errorAction silentlycontinue) -eq $null){
	New-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name TracingEnabled -Value 1 -PropertyType "DWord"
}
else{
	Set-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name TracingEnabled -Value 1
}
write-host "Info" "Enabled tracing for Web Management Service"

# enable tracing for wmsvc
if( (Get-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name RemoteRestrictions -errorAction silentlycontinue) -eq $null){
	New-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name RemoteRestrictions -Value $restrictions -PropertyType "String"
}
else{
	Set-ItemProperty -path HKLM:\Software\Microsoft\WebManagement\Server -name RemoteRestrictions -Value $restrictions
}
write-host "Info" "Set Remote Restrictions for Web Management Service"


# increase number of tracing logs that are kept (default: 50, usually too small since even successful requests are logged)
[System.Diagnostics.Process]::Start(${env:windir} + "\system32\inetsrv\appcmd","set config `/section`:sites `-siteDefaults`.traceFailedRequestsLogging`.maxLogFiles`:$maxTracingLogFiles") | out-null
write-host "Info" "Set number of tracing log files retained for Web Management Service to $maxTracingLogFiles"

# start wmsvc
Start-Service wmsvc
write-host "Info" "Starting Web Management Service..."
