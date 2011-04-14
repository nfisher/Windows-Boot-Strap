$wc = New-Object System.Net.WebClient
$url = "http://www.microsoft.com/downloads/info.aspx?na=41&SrcFamilyId=0A391ABD-25C1-4FC0-919F-B21F31AB88B7&SrcDisplayLang=en&u=http%3a%2f%2fdownload.microsoft.com%2fdownload%2f9%2f5%2fA%2f95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE%2fdotNetFx40_Full_x86_x64.exe"
$dest = "C:\temp\dotnet4.exe"

$wc.DownloadFile($url, $dest)

