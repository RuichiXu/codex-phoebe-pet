[CmdletBinding()]
param(
    [string]$InstallRoot = (Join-Path $env:USERPROFILE ".codex\pets")
)

$ErrorActionPreference = "Stop"

$petId = "phoebe-chibi"
$repository = "https://raw.githubusercontent.com/RuichiXu/codex-phoebe-pet/main"
$destination = Join-Path $InstallRoot $petId
$temporaryDirectory = Join-Path ([System.IO.Path]::GetTempPath()) ("codex-phoebe-pet-" + [guid]::NewGuid().ToString("N"))
$sourceDirectory = $null

try {
    $scriptPath = $MyInvocation.MyCommand.Path
    if ($scriptPath) {
        $repositoryRoot = Split-Path -Parent $scriptPath
        $candidate = Join-Path $repositoryRoot "pet\$petId"
        if ((Test-Path -LiteralPath (Join-Path $candidate "pet.json")) -and
            (Test-Path -LiteralPath (Join-Path $candidate "spritesheet.webp"))) {
            $sourceDirectory = $candidate
        }
    }

    if (-not $sourceDirectory) {
        New-Item -ItemType Directory -Path $temporaryDirectory -Force | Out-Null
        Invoke-WebRequest "$repository/pet/$petId/pet.json" -OutFile (Join-Path $temporaryDirectory "pet.json")
        Invoke-WebRequest "$repository/pet/$petId/spritesheet.webp" -OutFile (Join-Path $temporaryDirectory "spritesheet.webp")
        $sourceDirectory = $temporaryDirectory
    }

    $manifestPath = Join-Path $sourceDirectory "pet.json"
    $spritesheetPath = Join-Path $sourceDirectory "spritesheet.webp"
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json

    if ($manifest.id -ne $petId) {
        throw "The downloaded manifest has an unexpected pet id."
    }
    if ($manifest.spriteVersionNumber -ne 2) {
        throw "This package is not a Codex v2 pet."
    }
    if ((Get-Item -LiteralPath $spritesheetPath).Length -lt 100000) {
        throw "The downloaded spritesheet is incomplete."
    }

    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -LiteralPath $manifestPath -Destination (Join-Path $destination "pet.json") -Force
    Copy-Item -LiteralPath $spritesheetPath -Destination (Join-Path $destination "spritesheet.webp") -Force

    Write-Host ""
    Write-Host "Phoebe Chibi was installed successfully." -ForegroundColor Green
    Write-Host "Location: $destination"
    Write-Host "Restart Codex to load the pet."
}
finally {
    if (Test-Path -LiteralPath $temporaryDirectory) {
        Remove-Item -LiteralPath $temporaryDirectory -Recurse -Force
    }
}
