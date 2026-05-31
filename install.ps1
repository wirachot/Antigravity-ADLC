# install.ps1 — One-time Antigravity ADLC setup (Windows PowerShell)
#
# Writes ~/.gemini/GEMINI.md with the correct absolute path to this toolkit.
# After this runs, you can use /init in any new project without any further
# global configuration. Once /init has run in a project, that project carries
# its own .gemini/GEMINI.md and no longer depends on this global file.
#
# Usage (from the adlc-toolkit root):
#   .\install.ps1

$ErrorActionPreference = "Stop"

$ToolkitPath = $PSScriptRoot
$GeminiDir   = Join-Path $HOME ".gemini"
$GeminiFile  = Join-Path $GeminiDir "GEMINI.md"
$Template    = Join-Path $ToolkitPath "templates\gemini-rules-template.md"

Write-Host "Antigravity ADLC — Global Setup"
Write-Host "Toolkit path: $ToolkitPath"
Write-Host ""

# Validate template exists
if (-not (Test-Path $Template)) {
    Write-Error "Template not found at $Template`nMake sure you are running this script from the adlc-toolkit root."
    exit 1
}

# Create ~/.gemini/ if it doesn't exist
if (-not (Test-Path $GeminiDir)) {
    New-Item -ItemType Directory -Path $GeminiDir | Out-Null
}

# Warn if file already exists
if (Test-Path $GeminiFile) {
    Write-Host "WARNING: $GeminiFile already exists."
    $confirm = Read-Host "Overwrite? (y/N)"
    if ($confirm -notmatch "^[Yy]$") {
        Write-Host "Aborted — existing file preserved."
        exit 0
    }
}

# Write rules with actual toolkit path substituted
(Get-Content $Template -Raw) -replace 'ADLC_TOOLKIT_PATH', $ToolkitPath |
    Set-Content -Path $GeminiFile -Encoding UTF8

Write-Host ""
Write-Host "Done! Created: $GeminiFile"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open any project in Antigravity and type /init to bootstrap ADLC"
Write-Host "  2. After /init, the project carries its own .gemini/GEMINI.md"
Write-Host "     — no global setup needed for that project going forward"
