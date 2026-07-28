[CmdletBinding()]
param(
    [string]$InstallRoot = (Join-Path $env:USERPROFILE ".codex\pets")
)

$ErrorActionPreference = "Stop"

$petId = "phoebe-chibi"
$destination = Join-Path $InstallRoot $petId
$manifestPath = Join-Path $destination "pet.json"

if (-not (Test-Path -LiteralPath $destination)) {
    Write-Host "Phoebe Chibi is not installed."
    exit 0
}

if (-not (Test-Path -LiteralPath $manifestPath)) {
    throw "Refusing to remove a directory that does not contain the Phoebe Chibi manifest: $destination"
}

$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
if ($manifest.id -ne $petId) {
    throw "Refusing to remove a directory whose manifest belongs to another pet."
}

Remove-Item -LiteralPath $destination -Recurse -Force
Write-Host "Phoebe Chibi was removed from $destination" -ForegroundColor Green
Write-Host "Restart Codex to refresh the pet list."
