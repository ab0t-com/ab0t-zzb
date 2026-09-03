# Security Policy

## Supported versions

`zzb` is pre-1.0; only the latest published release line receives fixes.

| Version | Supported |
|---------|-----------|
| 0.1.x   | yes       |
| < 0.1   | no        |

## Reporting a vulnerability

Please report suspected vulnerabilities **privately** — do NOT open a public issue.

- Preferred: open a private advisory via **GitHub → Security → "Report a
  vulnerability"** (Private Vulnerability Reporting is enabled on this repo), or
- Email **security@<ORG-DOMAIN>** _(the repo owner sets this address at publish
  time)_.

We aim to acknowledge within 72 hours and to coordinate disclosure (default 90
days). Please include: the version (`zzb --version`), platform, reproduction steps,
and impact.

## Verifying what you installed

Every release ships a `release/checksums.txt`. Verify your binary before trusting
it:

```sh
cd release && sha256sum -c checksums.txt      # each asset: OK
zzb --version                                  # matches release/VERSION
```

The installers (`install.sh`, `install.ps1`) and `zzb update` are HTTPS-only and
refuse to install a binary whose sha256 does not match the published checksum.

## Secret scanning (git hooks)

This repo scans for secrets and internal references with **git hooks**, not a CI
workflow. Enable them once per clone:

```sh
git config core.hooksPath .githooks
```

- `pre-commit` blocks a commit that adds a credential or an internal reference
  (uses `gitleaks` if installed, plus a regex backstop that always runs).
- `pre-push` re-scans the whole tree before the irreversible publish.

See `.githooks/README.md`. False positives go in `.gitleaksignore`.
