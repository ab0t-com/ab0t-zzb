<#
.SYNOPSIS
  zzb installer for Windows (PowerShell).

.DESCRIPTION
  Downloads the matching prebuilt zzb.exe from this repo's raw content, verifies
  its sha256 against the published checksums.txt, and installs it onto the user's
  PATH. Mirrors install.sh (Linux/macOS): HTTPS-only, checksum-mandatory, atomic,
  keeps the previous binary as zzb.exe.previous for rollback, idempotent.

  What it does:
    1. Detects arch (amd64 / arm64) from PROCESSOR_ARCHITECTURE.
    2. Downloads release/checksums.txt, then release/zzb-windows-<arch>.exe (HTTPS, TLS 1.2+).
    3. Verifies the binary against the published sha256 — MANDATORY.
    4. Installs to $env:LOCALAPPDATA\Programs\zzb\zzb.exe (override with -InstallDir),
       keeping the prior binary as zzb.exe.previous.
    5. Adds the install dir to the USER PATH if missing, and confirms `zzb --version`.

  SOURCE: $RepoRaw below is set to the published home (github.com/ab0t-com/ab0t-zzb);
  a forker replaces the org/repo. End users can override with $env:ZZB_INSTALL_BASE.

.EXAMPLE
  irm https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.ps1 | iex

.EXAMPLE
  $env:ZZB_INSTALL_BASE="https://mirror.example.com/zzb"; irm .../install.ps1 | iex
#>
[CmdletBinding()]
param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\zzb"
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# --- source (published home; a forker edits the org/repo; end user can override via env) ---
$RepoRaw  = 'https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main'
$BaseUrl  = if ($env:ZZB_INSTALL_BASE) { $env:ZZB_INSTALL_BASE } else { $RepoRaw }
$BaseUrl  = $BaseUrl.TrimEnd('/')

function Info($m){ Write-Host "-> $m" }
function Ok($m){   Write-Host "[ok] $m" -ForegroundColor Green }
function Fail($m){ Write-Host "[x] $m" -ForegroundColor Red; exit 1 }

if ($BaseUrl -notlike 'https://*') {
    Fail "refusing a non-HTTPS source '$BaseUrl' (TLS is mandatory)."
}

# --- detect arch -------------------------------------------------------------
$archRaw = $env:PROCESSOR_ARCHITECTURE
switch ($archRaw) {
    'AMD64' { $arch = 'amd64' }
    'ARM64' { $arch = 'arm64' }
    default { Fail "unsupported architecture: $archRaw" }
}
$asset = "zzb-windows-$arch.exe"
Info "Source:   $BaseUrl"
Info "Platform: windows-$arch  (asset: $asset)"

# --- resolve published version (best-effort) ---------------------------------
try {
    $published = (Invoke-WebRequest -UseBasicParsing -Uri "$BaseUrl/release/VERSION").Content.Trim()
    Info "Published version: $published"
} catch { $published = $null }

$dest = Join-Path $InstallDir 'zzb.exe'
$prev = "$dest.previous"

# --- short-circuit if already at published version ---------------------------
if ($published -and (Test-Path $dest)) {
    try {
        $current = ((& $dest --version) -split '\s+')[-1].Trim()
        if ($current -eq $published) { Ok "zzb $published already installed at $dest — nothing to do."; exit 0 }
        Info "Currently installed: $current -> updating to $published"
    } catch {}
}

# --- download checksums first (never install unverified) ---------------------
$work = Join-Path ([IO.Path]::GetTempPath()) ("zzb-install-" + [Guid]::NewGuid())
New-Item -ItemType Directory -Path $work -Force | Out-Null
try {
    $sumsPath = Join-Path $work 'checksums.txt'
    Info "Fetching release/checksums.txt"
    Invoke-WebRequest -UseBasicParsing -Uri "$BaseUrl/release/checksums.txt" -OutFile $sumsPath
    $expected = $null
    foreach ($line in Get-Content $sumsPath) {
        $f = ($line -split '\s+') | Where-Object { $_ -ne '' }
        if ($f.Count -ge 2 -and ($f[1].TrimStart('*') -eq $asset)) { $expected = $f[0].ToLower(); break }
    }
    if (-not $expected) { Fail "no checksum entry for $asset in checksums.txt (is this platform published?)" }
    if ($expected -notmatch '^[0-9a-f]{64}$') { Fail "checksum entry for $asset is malformed" }

    # --- download the binary + verify (mandatory) ----------------------------
    $binTmp = Join-Path $work 'zzb.exe'
    Info "Downloading $BaseUrl/release/$asset"
    Invoke-WebRequest -UseBasicParsing -Uri "$BaseUrl/release/$asset" -OutFile $binTmp
    $actual = (Get-FileHash -Algorithm SHA256 -Path $binTmp).Hash.ToLower()
    if ($actual -ne $expected) { Fail "checksum mismatch — expected $expected, got $actual. Aborting (no install performed)." }
    Ok "Checksum verified"

    # --- install (atomic-ish, with rollback) ---------------------------------
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    if (Test-Path $dest) {
        Info "Saving current binary as $prev"
        Move-Item -Force -Path $dest -Destination $prev
    }
    Move-Item -Force -Path $binTmp -Destination $dest
    Ok "Installed: $dest"
} finally {
    Remove-Item -Recurse -Force -Path $work -ErrorAction SilentlyContinue
}

# --- ensure install dir is on the USER PATH ----------------------------------
$userPath = [Environment]::GetEnvironmentVariable('Path','User')
if (($userPath -split ';') -notcontains $InstallDir) {
    [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ';' + $InstallDir), 'User')
    $env:Path = $env:Path + ';' + $InstallDir
    Info "Added $InstallDir to your user PATH (open a new terminal to pick it up)."
}

# --- confirm -----------------------------------------------------------------
try { Ok ("Installed: " + (& $dest --version)) }
catch { Write-Host "[!] installed binary did not respond to --version; roll back: Move-Item -Force '$prev' '$dest'" -ForegroundColor Yellow }

Write-Host ""
Write-Host "Done. Run 'zzb --help' for the command list, or 'zzb update' to self-update later."
