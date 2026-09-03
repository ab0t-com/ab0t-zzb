# zzb

**The command-line client for ab0t authorization** — relationship-based access
control (ReBAC) from your terminal, in the spirit of SpiceDB's `zed` and the
Auth0 CLI.

`zzb` is a single static Go binary. It talks to the **ab0t auth
service**'s authorization API (`https://auth.service.ab0t.com`) and turns
relationship tuples and permission checks into a pleasant terminal workflow. It
is a *client* — the authorization engine runs in the service.

```
  you ──▶ zzb ──HTTPS──▶ auth.service.ab0t.com  /zanzibar/stores/{store}/*
             │                             │
      ~/.zzb/config.json     relationship graph
     (url + token + default store)   (Check / Expand / ListObjects / …)
```

A **store** is your organization (`store_id == org_id`). Everything is a
relationship tuple `object#relation@subject`
(e.g. `document:q3-report#viewer@user:alice`); permissions are computed over that
graph.

## Install

**Linux / macOS:**
```sh
curl -fsSL https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.sh | sh
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.ps1 | iex
```

HTTPS-only, sha256-verified, atomic install with a `.previous` rollback,
idempotent. Binaries are published under the `ab0t-com` GitHub org. Point at a
mirror with `ZZB_INSTALL_BASE=… curl -fsSL …/install.sh | sh`.

**Update:**
```sh
zzb update           # download + verify + swap the latest release
zzb update --check    # only report whether a newer release exists
```

## Quickstart

```sh
# 1. point at the service and sign in (writes ~/.zzb/config.json)
zzb auth login --url https://auth.service.ab0t.com \
  --org <your-org-slug> --email you@example.com --password ****

# 2. share a document, then ask the money question
zzb relationship write document:q3-report owner  user:alice
zzb transact --write document:q3-report#viewer@user:bob \
                     --write document:q3-report#editor@user:carol   # atomic
zzb check user:bob viewer document:q3-report                 # -> ALLOW

# 3. audit
zzb read --object document:q3-report
zzb list-users document:q3-report viewer
```

Environments: prod `https://auth.service.ab0t.com` · dev `https://auth.dev.ab0t.com`
· local `http://localhost:8001`.

## Feature tour

- **relationship / transact** — write, delete, and atomically batch tuples
  (`object#relation@subject`); a batch commits together or not at all.
- **check / expand** — the allow/deny decision, and the whole userset tree behind it.
- **list-objects / list-users** — what a subject can access, and who can access an object.
- **read** — query tuples by object and/or user, cursor-paginated.
- **model** — publish, list, and fetch versioned, immutable authorization models.
- **assert** — store model tests and run each through the live Check engine.
- **changes** — read the durable relationship changelog (resumable watch).
- **namespace / permission / team / hierarchy / migrate / visualize / scenario** —
  schema, wildcard grants, team membership, org hierarchy, migration helpers, demos.
- **`--json`** on any command for machine-readable output; **`--url/--token/--store`**
  to override the saved config per-invocation.

Run `zzb --help` for the full command tree, or `zzb <command>`
with no args for a group's subcommands.

## Agent skills

`skills/` bundles ready-to-load agent skills. **Start with `skills/README.md`** —
it routes you to the right one and explains when to use the CLI vs the SDK vs the
REST API.

- **`skills/zzb/`** — drive the CLI end-to-end (install → auth → model →
  check → script in CI/agents).
- **`skills/zzb-modeling/`** — the schema file + the computed-permission
  language (`+` or, `&` and, `-` except, `relation->permission` inherit).
- **`skills/zzb-authorization-recipes/`** — real customer setups by size
  (small SaaS, multi-team org, multi-tenant platform), copy-paste.
- **`skills/zzb-lifecycle/`** — manage schema + permissions over time:
  config-as-code, CI, migration, and integrating an existing app.

## Repository layout

```
install.sh  install.ps1     HTTPS + sha256-verified installers
release/                    prebuilt binaries + checksums.txt + VERSION
docs/USAGE.md               task-oriented cookbook
skills/                     bundled agent skills
llms.txt                    agent bootstrap
CHANGELOG.md  SECURITY.md   release notes + disclosure policy
LICENSE                     MIT
```

## License

MIT — see [LICENSE](LICENSE).
