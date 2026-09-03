# zzb skills — start here (router)

These skills teach an agent (or a person) to use `zzb` to manage
authorization on the **ab0t auth service** (`https://auth.service.ab0t.com`). This
page routes you to the right skill — and the right *section* of it — and tells you
when the CLI is **not** the tool.

## The 7 skills

| Skill | What it's for |
|---|---|
| **`zzb`** | Install + the command reference (auth, write, check, read, model, assert, transact, changes). |
| **`zzb-auth-as-code`** | START HERE for a NEW app/tenant: the 4-system picture + the whole slice — provision (authsetup) + model (zzb) + runtime read/write (SDK), via `init --with-tenancy --with-sdk go`, `auth.yaml`, and `plan`/`apply`. |
| **`zzb-modeling`** | The model file + the permission language (`+ & - ->`) and every schema **pattern**. Starts with a "which pattern do I need?" index. |
| **`zzb-authorization-recipes`** | Whole setups by customer **size** (A–E) + a "**I'm building X**" product-shapes map. |
| **`zzb-lifecycle`** | Manage authz over time: config-as-code, CI, versioning, migration, day-2 ops. |
| **`zzb-audit`** | Audit your own store for over-grants, public exposure, dark-by-intersection, drift. |

Order for a full picture: `zzb` → `zzb-auth-as-code` → `zzb-modeling` →
`zzb-authorization-recipes` → `zzb-lifecycle` → `zzb-audit`.
Jump straight to one if you know what you need. **New to authorization and
starting from nothing? Read `zzb-auth-as-code` first.**

## "I want to model X" → where to go

Find your **product** or **problem**, land on the pattern. Sections marked §N are
inline in `zzb-modeling`; `references/…` are its deep-dive files.

| I'm building / I want to model… | Read |
|---|---|
| **Google Drive / file-sharing** (docs inherit folders, share links) | recipes Recipe A/B + modeling §3 (folder arrow), §1 (roles), §4 (public) |
| **Notion / a workspace app** (private / shared-to-org / public-link, "anyone on our domain") | modeling §6 (visibility modes + **domain trap**) + recipes Recipe B |
| **GitHub-style repos + branches** (protected branches need a stronger role) | modeling §1 (role inheritance) + references/conditional-gates.md §4 (**step-up**) |
| **Slack** (channels, teams, nested teams, public channels) | modeling §2 (group/team usersets + nested teams), §4 (wildcard) |
| **A two-sided marketplace** (buyer + seller on one order, dispute mediator) | recipes Recipe D |
| **A reseller / B2B2B platform** (vendor→reseller→customer, admin cascades down) | recipes Recipe E (nested hierarchy) + modeling §3 (arrows) |
| **A bank / Chinese wall** (deal team vs trading desk mutually exclusive) | references/conditional-gates.md §5 (**information barrier**) + §6 (dual-control) |
| **A data warehouse / classification** (PII columns, purpose, clearance) | references/conditional-gates.md §3 (**ABAC**) + references/ordered-levels.md |
| **Classified / compartments** (clearance ≥ classification, need-to-know, NOFORN) | references/ordered-levels.md + references/conditional-gates.md §1–§2 |
| **A role that implies a lesser one** (editor ⇒ viewer) | modeling §1 (role inheritance) |
| **Two-way friends / connections** | references/mutual-symmetric.md |
| **N distinct approvers must sign** (dual-control / SoD) | references/conditional-gates.md §6 |
| **Independent tenants, hard isolation** | recipes Recipe C (per-tenant store) |
| **Ordered clearance levels** (Confidential < Secret < Top-Secret) | references/ordered-levels.md |

## "I want to operate / ship it" → where to go

| I want to… | Read |
|---|---|
| Install the CLI, learn the commands + tuple notation | **`zzb`** |
| **Go from NOTHING to a working, safe slice** (provision + model + runtime read/write), `init --with-tenancy --with-sdk go`, `auth.yaml`, `plan`/`apply`, `auth login --from-authsetup` | **`zzb-auth-as-code`** |
| Publish the model in CI, version + roll back, migrate from RBAC/SpiceDB/OpenFGA | **`zzb-lifecycle`** |
| Decide CLI vs SDK vs REST API (runtime vs change-time) | **`zzb-lifecycle`** (CLI vs SDK vs REST) |
| Bulk-load / backfill grants, dual-run during cutover | **`zzb-lifecycle`** (migration) |
| Day-2: audit with `read`, CDC with `changes`, time-bound grants, break-glass, offboarding `purge` | **`zzb-lifecycle`** (day-2 ops) |
| **Audit for risk** before/after go-live (over-grant, public exposure, dark resources, drift) | **`zzb-audit`** (`zzb audit` + manual spot-checks) |

## Is it CLI-only? Is there a language? Does it use files?

All three, deliberately:

- **A schema language, in files.** Your authorization model is a declarative
  **JSON file** (`model.json`) — versioned and immutable on the server. Inside it,
  computed permissions use a compact algebra: `+` (or), `&` (and), `-` (except),
  and `relation->permission` (inherit through a relation). See **`zzb-modeling`**.
- **Imperative commands for data.** Individual relationship tuples are written
  with commands (`relationship write`, atomic `transact`); bulk work uses JSON
  files (`check bulk --file`, `assert … --file`).
- **Not CLI-only for runtime.** In production your **application** makes
  authorization decisions and writes relationships at request time through the
  **SDK/API** — the CLI is for schema management, migration, bulk ops, CI, audit,
  and debugging.

## Which TOOL do I use? (the CLI is one of three surfaces)

| Job | Use |
|---|---|
| Runtime `check`/writes inside your app (per request, as users act) | the **SDK** (`auth-sdk-go` for Go) or the **REST API** directly |
| Author/version the schema; run assertions in CI; migrate; bulk-load; audit; debug | **`zzb`** (this CLI) |
| A quick call from a shell script or a non-Go service | the **REST API** (`/zanzibar/stores/{store}/*`) or the CLI with `--json` |

Rule of thumb: **schema + ops → CLI; runtime authorization → SDK/API.** See
**`zzb-lifecycle`** for the full split.

## The 30-second mental model

- A **store** is one organization (`store_id == org_id`) — your isolation boundary.
- Everything is a **relationship tuple** `object#relation@subject`
  (`document:q3-report#viewer@user:alice`).
- **Relations** are written facts; **permissions** are computed from relations by
  the model's expressions.
- `check <subject> <permission> <object>` is the money question; `expand`,
  `list-objects`, `list-users` explore the graph; `read`/`changes` audit it.
