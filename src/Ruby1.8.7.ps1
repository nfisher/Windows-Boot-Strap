$wc = New-Object System.Net.WebClient
$url = "http://rubyforge.org/frs/download.php/75107/rubyinstaller-1.8.7-p352.exe"
$dest = "ruby1.8.7.exe"

$wc.DownloadFile($url, $dest)
.\ruby1.8.7.exe /q /norestart
