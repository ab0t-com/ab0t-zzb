<p align="center">
  <img src="assets/hero.png" alt="zzb — a friendly teal node-orb mascot waving, wired by glowing light-edges to a happy little graph of face-nodes: relationship-based authorization, made friendly" width="880">
</p>

<h1 align="center">zzb</h1>

<p align="center"><em>Get authorization right — and prove it — from your terminal.</em></p>

---

If you've ever shipped a feature and then lost an afternoon to *"wait, who can actually see this?"*, zzb is for you. It's a single, fast binary that puts your whole permission model — who can do what, and why — one command away. No dashboard spelunking, no guessing, no re-reading your own policy code at 2am.

zzb speaks **relationship-based access control (ReBAC)**: instead of scattering `if user.role == "admin"` across your codebase, you model access as relationships — *alice owns the doc, the doc lives in the eng workspace, eng members can view* — and let the engine compute the rest. Google uses this pattern (Zanzibar) to guard Docs, Drive, and YouTube. zzb gives you the same model with a CLI that's genuinely pleasant to use.

```sh
curl -fsSL https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.sh | sh
```
*(Windows: `irm https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.ps1 | iex`)*

---

## Why teams reach for zzb

**🚀 From zero to a working model in one command.** `zzb init --template drive --publish` scaffolds a real, tested authorization model — documents, folders, sharing, roles — and publishes it. Eighteen production templates cover the shapes you're probably building (SaaS multi-tenant, GitHub-style repos, Jira, a bank, Slack, healthcare, a data warehouse, B2B2B reseller…). Start from one instead of a blank file.

**🔍 Answer "who can access this?" instantly.** `zzb list-users doc:q3 can_view` tells you exactly who — and `zzb check user:alice can_edit doc:q3` gives you the allow/deny in milliseconds. When someone asks during an incident, you have the answer, not a theory.

**🛡️ Catch the dangerous mistakes before they ship.** `zzb audit` lints your model the way a linter catches bugs — accidental public grants, permissions nobody can actually reach, a "two people must approve" gate that one person can secretly satisfy alone, stale access that should've expired. Nobody else's CLI does this. Run it in CI and stop over-grants at the PR.

**📋 Run access reviews without a spreadsheet.** `zzb access-review doc:q3 can_edit` shows who has access, *why* they have it (direct grant vs. inherited through a team), and which grants look risky — then hands you a ready-to-edit revocation plan. Compliance season stops being a fire drill.

**🧪 See the blast radius before you change anything.** `zzb diff --write doc:q3#editor@user:bob --checks` previews exactly who *gains* and *loses* access **before** you apply the change. No more "let's grant it and see what breaks."

**⏱️ Grants that clean up after themselves.** Break-glass access with `--expires` so temporary really means temporary. Offboard someone completely with `zzb purge --user`. Batch changes commit all-or-nothing.

---

## Templates — start from a real shape, not a blank file

`zzb init --template <name> [--publish]` scaffolds a **production starting point** —
not a toy. Each ships a complete, layered model (org/tenancy → workspace/team →
resource), a `seed.json`, an `assertions.json` proving the "must never" rules, and a
`README.md` explaining the whole data model and how it scales. Eighteen templates:

| Template | What it models |
|---|---|
| `docs` | org → workspace → folder/doc with owner/editor/viewer + team sharing |
| `drive` | nested folders → docs, editor tier, team share, opt-in public link |
| `notion` | connected workspaces → teamspaces → arbitrarily nested pages |
| `github` | enterprise → org → team → repo roles + protected-branch step-up |
| `slack` | workspace → public/private channels + nested teams |
| `jira` | project roles → board → issue (assignee/reporter/watcher) |
| `helpdesk` | queue-based agent access, customer sees only their ticket, escalation |
| `saas-multitenant` | tenant org (+ sub-tenants) → workspace → resource, strict isolation |
| `marketplace` | two-sided buyer/seller + private payout lane + dispute escalation |
| `reseller` | B2B2B: vendor → reseller → customer → workspace, delegated admin |
| `healthcare` | patient records + care teams + time-boxed break-glass (HIPAA) |
| `lms` | school → course → section → enrollment, student isolation |
| `cicd` | org → project → environment → resource, protected-prod step-up |
| `social` | symmetric friends + block override, posts visible to friends only |
| `external-share` | internal folder tree + time-boxed external guest links (no leak) |
| `bank` | Chinese-wall two-sided exclusion, compliance oversight exempt |
| `warehouse` | ABAC: dataset gated by clearance **and** purpose (an `&` intersection) |
| `classified` | ordered clearance levels + need-to-know compartment + NOFORN exclusion |

The regulated/complex set (`bank`, `warehouse`, `classified`, `reseller`,
`marketplace`) shows zzb handling the hard stuff — mutual exclusion, ABAC
intersections, ordered levels, B2B2B delegation, multi-party separation — so
**highly complex apps are first-class, not an afterthought**.

> **Templates cover the authorization graph, not your accounts.** Creating the real
> orgs, users, workspaces, and hosted login is the auth service's onboarding layer
> (the `authsetup` CLI) — complementary to zzb. Each template's `README.md` spells out
> the boundary and the single-store-vs-per-tenant scaling decision.

Run `zzb init --list` to see them all.

## 60 seconds to your first win

```sh
# 1. sign in (saves url + token + store to ~/.zzb/config.json)
zzb auth login --url https://auth.service.ab0t.com --org <your-org> --email you@example.com

# 2. grant access, then ask the money question
zzb relationship write document:q3-report editor user:alice
zzb check user:alice can_edit document:q3-report        # -> ALLOW

# 3. see who else can get in — and whether anything's risky
zzb list-users document:q3-report can_view
zzb audit
```

Prefer to poke around first? `zzb scenario list` seeds a full demo company you can explore, and `skills/../playground/` is an offline visual explorer with a natural-language assistant — ask it "who can approve a wire over $10k?" in plain English.

Every command has real, copy-pasteable help: `zzb <command> --help` shows examples and a suggested next step. Add `--json` to anything for scripts and dashboards.

---

## Where it fits

zzb is the **CLI** for your authorization: model the schema, load and query relationships, audit, review, migrate, debug. Your **application** calls the same auth service at runtime via the SDK/API for live permission checks. Think of zzb as the control plane you and your platform team live in; the SDK is what your app calls a million times a second.

> **CLI doesn't have what you need?** Everything zzb does is the auth service's REST API underneath — call it directly. Full spec: **https://auth.service.ab0t.com/openapi.json**

- **New to ReBAC or modeling?** → `skills/zzb-modeling/` — the permission language, and the traps to avoid.
- **Building a specific product?** → `skills/zzb-authorization-recipes/` — real setups by size and shape, copy-paste ready.
- **Wiring it into an existing app / CI?** → `skills/zzb-lifecycle/` — schema-as-code, migration, day-2 ops.
- **Doing a security or access review?** → `skills/zzb-audit/` — audit yourself, on a cadence.
- **Just want the command reference?** → `skills/zzb/` and `docs/USAGE.md`.

Start at **`skills/README.md`** — it points you to the right one.

---

## Good to know

- **One static binary.** No runtime, no dependencies. Installs to `~/.local/bin`, HTTPS-only, sha256-verified, atomic with a `.previous` rollback. Update anytime with `zzb update`.
- **A store is your org** (`store_id == org_id`); everything is a tuple `object#relation@subject`.
- **Environments:** prod `https://auth.service.ab0t.com` · dev `https://auth.dev.ab0t.com` · local `http://localhost:8001`.
- **Security:** see [SECURITY.md](SECURITY.md) for reporting and verifying your install. Contributing? Enable the secret-scan git hooks: `git config core.hooksPath .githooks`.
- **Reference README** (architecture, full feature list, repo layout): [README1.md](README1.md).

## The ab0t auth family

zzb is the CLI. If you're wiring authorization into an app, you probably also want:

- **[auth-sdk-go](https://github.com/ab0t-com/auth-sdk-go)** — the Go SDK for runtime
  permission checks from your service (what your app calls at request time).
- **client setup CLI** (`ab0t-setup-go`) — bootstraps a client/org against the auth
  service. Find it in the [ab0t-com](https://github.com/ab0t-com) org.
- **REST API** — everything zzb and the SDK do, directly:
  `https://auth.service.ab0t.com/openapi.json`.

---

MIT licensed — see [LICENSE](LICENSE).
