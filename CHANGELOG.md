# Changelog

All notable changes to `zzb` (the CLI formerly published as `zanzibarctl`) are
documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses
semantic versioning (published versions carry a `-public` suffix; git tags are the
`v`-prefixed semver, e.g. `v0.1.0`).

> **Renamed at 0.1.1:** the CLI is now `zzb` (was `zanzibarctl`). Historical entries
> below still refer to `zanzibarctl`; commands shown there are now spelled `zzb …`.

## [Unreleased]

_Nothing yet._

## [0.1.4] — 2026-09-03

### Changed — templates are now production starting points
- **All 10 templates rebuilt to a production, system-aware bar** and **8 new templates
  added (18 total).** Each ships a complete, layered model (org/tenancy → workspace/team
  → resource), a realistic `seed.json` (no `user:*` by default → audit-clean), an
  `assertions.json` proving the "must never" rules, and a **`README.md`** explaining the
  full data model, the authsetup-vs-zzb system boundary, and single-store-vs-per-tenant
  scaling. Every template validated live: assertions green + `zzb audit` gate PASS.
- New templates: `jira`, `helpdesk`, `reseller` (B2B2B), `healthcare` (break-glass),
  `lms`, `cicd` (prod step-up), `social` (symmetric friends + block), `external-share`.
- `drive` now has nested folders + an editor tier + an opt-in public link; `slack`,
  `github`, `saas-multitenant`, `marketplace` deepened to real multi-layer models.
- `zzb init` now also scaffolds the template's **`README.md`** alongside the JSON.

## [0.1.3] — 2026-09-03

### Added
- **REST API fallback pointer** in the top-level `zzb` help and README: if the CLI
  doesn't cover something, call the auth service's REST API directly
  (`https://auth.service.ab0t.com/openapi.json`).

## [0.1.2] — 2026-09-03

Docs + DX polish. No engine changes; the only binary change is richer help text.

### Added (CLI binary)
- **Richer top-level help.** The bare `zzb` screen now includes an **Examples** block
  (init → grant → check → list-users → diff → audit → access-review) and a **See also**
  footer (per-command `--help`, `zzb scenario list`, typo suggestions, docs/skills link).
  Per-verb `--help` already carried examples + a NEXT block.

### Docs & branding
- **New README** — benefit-led rewrite with a hero image (`assets/hero.png`). The prior
  reference README is preserved as `README1.md`.
- **Brand image-prompt specs** under `branding/` — `IMAGE_PROMPTS.md` (cinematic data-art)
  and `IMAGE_PROMPTS_v2.md` (cute-cartoon mascot) for repo + landing-page art.

## [0.1.1] — 2026-09-03

CLI + docs release. This changelog covers the **`zanzibarctl` binary and its bundled
skills** only. Several authorization-engine correctness fixes landed at the same time,
but those ship with the **auth service** (deployed separately) — updating the CLI does
NOT deliver them; see the "Requires server" note below.

### Renamed
- **The CLI binary is now `zzb`** (was `zanzibarctl`). The config dir is `~/.zzb/config.json`
  and the environment variables are `ZZB_URL` / `ZZB_TOKEN` / `ZZB_STORE` / `ZZB_INSTALL_BASE`.
  The feature entries below use the historical `zanzibarctl …` spelling; run them as `zzb …`.

### Added (CLI binary)
- **`init` — guided scaffold.** `zanzibarctl init` (interactive) or `init --template <docs|drive|
  notion|github|bank> [--publish]` writes `model.json` + `assertions.json` + `seed.json` from a
  built-in template and (with `--publish`) creates the model, seeds tuples, and runs assertions —
  zero-to-a-working-tested-model in one command. Never clobbers existing files; never hangs in CI.
- **Rich per-verb `--help` + smart suggestions.** Every verb now has `--help` with purpose,
  flags, copy-pasteable examples, and a NEXT block. Unknown command/verb → "did you mean …?";
  bare `zanzibarctl` surfaces the common commands.
- **`audit` — authorization risk linter.** `zanzibarctl audit` reads your model + tuples and
  prints ranked risks (wildcard/public over-grant + the domain trap, dark-by-intersection,
  unreachable/dangling permission, undeclared-type drift, expired grants, missing assertions,
  broad admin, near-depth-cap), each with the fix. `--json`, and `--max-severity` for a CI gate
  (non-zero exit). Read-only. See the new `zanzibarctl-audit` skill.
- **`access-review` — access certification / attestation.** `zzb access-review <object> <permission>`
  enumerates the LIVE effective access to a permission: a row per subject with the derived grant PATH
  (WHY — `direct:editor`, `via team:eng#member → editor`, or an inherited `via folder:root#parent →
  can_view`) and audit-style risk flags (`wildcard`, `expiring-soon`, `direct-bypass`, `broad-admin`).
  `--type T --permission P` sweeps every object of a type; `--subject user:x` runs the reverse review
  (everything a subject can reach); `--json` / `--csv` for a certification workflow; `--revoke-plan`
  emits commented `relationship delete` lines for a curated subset (never auto-deletes); `--flagged-only`
  and `--fail-on-flagged` (exit 3) gate CI. A read-only client-side lens over `expand` + `read` +
  `list-objects` — the periodic-certification companion to `audit`. See the `zzb-audit` skill.
- **OpenFGA `.fga` DSL** — `model create --dsl <file.fga>` and `model dsl-check` (author
  models in OpenFGA syntax; pure client-side transpile).
- **`purge` verb** — `purge --user <subject> [--dry-run]` removes every grant a subject
  holds, in one batch (offboarding).
- `read` now prints `expires_at` for time-bound tuples (when the server returns it).
- `assert run` exits non-zero when assertions fail — usable directly as a CI gate.
- `expand` sends no depth cap by default, so it resolves to the engine's full depth
  (was hard-capped at 5); `--max-depth N` still honored.
- `check wildcard` takes an optional `[resource]` to scope the org-wide check.
- Output polish: neutral column connectors in `list-users`/`list-objects`; flags accepted
  after positional args across `check`/`transact`/`team`/`relationship`.

### Docs (bundled skills)
- Authorization recipes A–E, including **Recipe E** (deep nested org hierarchy / B2B2B in
  one store) with the store-vs-arrow decision rule, and **Recipe D** (two-sided
  marketplace + escalation).
- Modeling patterns: information-barrier / Chinese wall (two-sided mutual exclusion),
  conditional intersection (compartment/clearance), nested teams (team-in-team), corrected
  recursion-depth note (25 hops).
- "Where truth lives" + the two-wildcards (`user:*` tuple vs. `check wildcard`)
  clarification; stale error-message docs corrected.

### Requires server (auth-service deploy — NOT delivered by updating the CLI)
The following are **engine** fixes that take effect when the auth service is upgraded;
they are listed here only so CLI users know the observable behavior changed at the service:
list-users/expand honor `-` exclusions and `& user:*` intersections; diamond-graph
false-DENY fixed; warm-cache honors `--expires`; recursion depth 25 hops with a clear
over-limit reason; `assert` 404s an unknown `model_id`; `model create` read-after-write
consistency; chained-`-` DENY reasons; `redirect_uris` cap 10→20.

## [0.1.0] — 2026-08-09

### Added
- Initial public release of `zanzibarctl` — a single static Go binary that runs multi-step
  user-journey tests against any HTTP service and returns one honest verdict per
  journey (`PASS` / `FAIL` / `VOID` / `SKIP` / `INCONCLUSIVE`).
- Authoring loop: `zanzibarctl new` (scaffold), `zanzibarctl explain` (plain-English story),
  `zanzibarctl lint` (authoring rules), `zanzibarctl validate`, `zanzibarctl schema` (JSON Schema for editor
  autocomplete).
- Run loop: `zanzibarctl run` (epics, one honest verdict each, resumable via
  `--run-id`/`--resume`), `--json`, `--strict`, JUnit/CTRF export, `zanzibarctl doctor`,
  `zanzibarctl history` (flake detection).
- Contract + load faces: `zanzibarctl contract` (OpenAPI completeness/parity/conformance/
  coverage) and `zanzibarctl load`.
- `zanzibarctl update` — checksum-verified, atomic self-update that keeps the prior binary
  as `.previous`.
- Prebuilt static binaries for linux (amd64, arm64), darwin (amd64, arm64), and
  windows (amd64), with `install.sh` (Linux/macOS) and `install.ps1` (Windows) —
  both HTTPS-only and sha256-verified.

[Unreleased]: https://github.com/ab0t-com/ab0t-zzb/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/ab0t-com/ab0t-zzb/releases/tag/v0.1.0
