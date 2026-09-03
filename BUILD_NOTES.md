# About this distribution

This repo is the **public, client-facing distribution** of `zzb` — the
command-line client for the **ab0t auth service**'s authorization API
(`https://auth.service.ab0t.com`). It ships prebuilt binaries and installers; the
source lives in a separate private repository.

## Install (both OSes)

```sh
# Linux/macOS
curl -fsSL https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.sh | sh
# Windows (PowerShell)
irm https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.ps1 | iex
```

## Update in place

```sh
zzb update           # checksum-verified, atomic, keeps zzb.previous
zzb update --check    # report only
```

## Verify your binary

Every release publishes `release/checksums.txt`. To verify a manual download:

```sh
cd release && sha256sum -c checksums.txt      # (shasum -a 256 -c on macOS)
```

The installers do this automatically and refuse to install on a mismatch.

## The one owner knob

Installers point their raw-content base URL at the published home,
`github.com/ab0t-com/ab0t-zzb` (a forker replaces the org/repo). End users can
point at a mirror/fork with the `ZZB_INSTALL_BASE` environment variable.

## Maintainers

The build, release, and git-ops procedure lives in the **private** source repo
(`RELEASE_SOP.md` / `GIT_OPS_SOP.md`), not here.
