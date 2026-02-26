# PowerShell script to build and package QBank Trainer for Windows

# Requirements:
#  - Python 3.11+ and virtualenv
#  - pyinstaller installed in the virtualenv
#
# Usage:
#   cd qbank_trainer
#   & .\build_release.ps1

param(
    [string]$Version = "1.0"
)

# change working directory to script location (qbank_trainer folder)
Set-Location $PSScriptRoot

# ensure python is available
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Error "Python not found in PATH. Activate your virtual environment before running this script."
    exit 1
}

Write-Host "Building QBank Trainer v$Version... (working dir: $PWD)"

# install requirements just in case
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install pyinstaller

# run pyinstaller
python -m PyInstaller --onefile --windowed quiz_app.py --name qbank_trainer

# compute release folder under project root
$projectRoot = (Get-Item "..").FullName
$releaseDir = Join-Path $projectRoot "release"
New-Item -ItemType Directory -Force -Path $releaseDir | Out-Null

# copy necessary files
Copy-Item -Path dist\qbank_trainer.exe -Destination $releaseDir -Force
if (Test-Path data.db) {
    Copy-Item -Path data.db -Destination $releaseDir -Force
}

# zip bundle
$zipPath = Join-Path $releaseDir "qbank_trainer-v$Version.zip"
if (Test-Path $zipPath) { Remove-Item $zipPath }
Compress-Archive -Path (Join-Path $releaseDir "*") -DestinationPath $zipPath

Write-Host "Release package created at $zipPath"