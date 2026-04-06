param(
  [Parameter(Mandatory = $true)]
  [ValidateSet('saa', 'sap', 'ispm')]
  [string]$Bank,

  [string]$VersionTag = '0.2.3'
)

$ErrorActionPreference = 'Stop'

$root = Resolve-Path (Join-Path $PSScriptRoot '..')
Push-Location $root

try {
  & (Join-Path $PSScriptRoot 'select_question_bank.ps1') -Bank $Bank

  flutter pub get
  if ($LASTEXITCODE -ne 0) {
    throw "flutter pub get failed"
  }

  flutter build windows --release
  if ($LASTEXITCODE -ne 0) {
    throw "flutter build windows failed"
  }

  $releaseDir = Join-Path $root 'build/windows/x64/runner/Release'
  $defaultExe = Join-Path $releaseDir 'aws_saa_trainer.exe'
  if (-not (Test-Path $defaultExe)) {
    throw "Built executable not found: $defaultExe"
  }

  $exeName = switch ($Bank) {
    'saa' { 'aws_saa_trainer.exe' }
    'sap' { 'aws_sap_trainer.exe' }
    'ispm' { 'ispm_trainer.exe' }
  }

  $packageDir = Join-Path $root "release/windows-$Bank"
  if (Test-Path $packageDir) {
    Remove-Item -Recurse -Force $packageDir
  }
  New-Item -ItemType Directory -Force -Path $packageDir | Out-Null

  Copy-Item -Path (Join-Path $releaseDir '*') -Destination $packageDir -Recurse -Force

  $copiedDefaultExe = Join-Path $packageDir 'aws_saa_trainer.exe'
  if (-not (Test-Path $copiedDefaultExe)) {
    throw "Packaged executable not found: $copiedDefaultExe"
  }
  if ($exeName -ne 'aws_saa_trainer.exe') {
    Rename-Item -Path $copiedDefaultExe -NewName $exeName -Force
  }

  $outDir = Join-Path $root 'release/banks'
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
  $zipPath = Join-Path $outDir "app-$VersionTag-$Bank-windows-x64.zip"
  if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
  }
  Compress-Archive -Path (Join-Path $packageDir '*') -DestinationPath $zipPath -CompressionLevel Optimal

  Write-Host "Built Windows variant zip: $zipPath"
}
finally {
  Pop-Location
}
