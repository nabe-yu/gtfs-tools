# Combine-StopsToCsv.ps1
# 全事業者のstops.txtを結合して1つのCSVにするスクリプト

$outputDir = "data/processed/csv"
$outputFile = Join-Path $outputDir "combined_stops.csv"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# stops.txtファイルをすべて取得
$files = Get-ChildItem -Path "data/raw/extracted/*/stops.txt" -File

# 1つ目のファイルのヘッダーを書き出し
Get-Content $files[0].FullName | Select-Object -First 1 | Out-File -Encoding UTF8 $outputFile

# すべてのファイルのデータ部分を追記
foreach ($file in $files) {
    Get-Content $file.FullName | Select-Object -Skip 1 | Add-Content -Encoding UTF8 $outputFile
}

Write-Host "全stops.txtを結合したCSVを $outputFile に出力しました。" 