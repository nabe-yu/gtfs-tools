param(
    [string]$FeedListFile = "../data/gtfs_feeds.json",
    [string]$DownloadDir = "../data/raw/feeds",
    [string]$ExtractDir = "../data/raw/extracted"
)

if (!(Test-Path $DownloadDir)) { New-Item -ItemType Directory -Path $DownloadDir | Out-Null }
if (!(Test-Path $ExtractDir)) { New-Item -ItemType Directory -Path $ExtractDir | Out-Null }

$feeds = Get-Content $FeedListFile | ConvertFrom-Json

$feeds | ForEach-Object {
    $name = $_.name
    $url = $_.url
    $uriObj = [System.Uri]$url
    $fileName = [System.IO.Path]::GetFileName($uriObj.AbsolutePath)
    $zipPath = Join-Path $DownloadDir $fileName
    Write-Host "[INFO] Downloading $name ($url) ..."
    Invoke-WebRequest -Uri $url -OutFile $zipPath
    Write-Host "[INFO] Extracting $zipPath ..."
    $extractSubDir = Join-Path $ExtractDir $name
    if (!(Test-Path $extractSubDir)) { New-Item -ItemType Directory -Path $extractSubDir | Out-Null }
    Expand-Archive -Path $zipPath -DestinationPath $extractSubDir -Force
    Remove-Item $zipPath -Force
}

Write-Host "[DONE] All GTFS feeds downloaded, extracted, and ZIPs removed." 