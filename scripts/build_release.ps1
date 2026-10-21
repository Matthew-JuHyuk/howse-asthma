# Builds the release APK with client-safe keys only.
#   powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1
# Output: build/app/outputs/flutter-apk/app-release.apk
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)

node tool/make_client_env.mjs --release
if ($LASTEXITCODE -ne 0) { throw 'make_client_env failed' }

flutter build apk --release
if ($LASTEXITCODE -ne 0) { throw 'flutter build apk failed' }

$apk = 'build/app/outputs/flutter-apk/app-release.apk'
$size = [math]::Round((Get-Item $apk).Length / 1MB, 1)
Write-Output "APK: $apk ($size MB)"
