$wc = New-Object System.Net.WebClient
$url = "http://go.microsoft.com/fwlink/?LinkId=209116"
$dest = "webdeploy2.msi"

$wc.DownloadFile($url, $dest)

msiexec.exe /i webdeploy2.msi /passive ADDLOCAL=ALL LISTENURL=http://+:8080/msdeploy2/
