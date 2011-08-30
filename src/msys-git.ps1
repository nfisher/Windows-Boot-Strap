$wc = New-Object System.Net.WebClient
$url = "http://msysgit.googlecode.com/files/Git-1.7.6-preview20110708.exe"
$dest = "msys-git.exe"

$wc.DownloadFile($url, $dest)

.\msys-git.exe /sp- /silent /norestart