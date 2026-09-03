# zzb — usage

A task-oriented cookbook. For the one-line command list run `zzb --help`.
For worked, sized customer setups see `skills/zzb-authorization-recipes/`.

## Mental model

`zzb` is a thin HTTPS client for the **ab0t auth service**'s
authorization API. A **store** is an organization (`store_id == org_id`).
Everything is a **relationship tuple** `object#relation@subject` (e.g.
`document:q3-report#viewer@user:alice`); permissions are computed over that graph
by the service's Check engine.

Environments: prod `https://auth.service.ab0t.com` · dev
`https://auth.dev.ab0t.com` · local `http://localhost:8001`.

## Install & confirm

```sh
# Linux/macOS
curl -fsSL https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.sh | sh
# Windows
irm https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.ps1 | iex

zzb --version          # confirm
zzb update --check      # is a newer release out?
zzb update              # take it (checksum-verified, atomic, keeps .previous)
```

## Configure (once)

Config resolves **flags → env → `~/.zzb/config.json`**. `auth login`
persists the URL, bearer token, and default store.

```sh
zzb auth login --url https://auth.service.ab0t.com \
  --org <your-org-slug> --email you@example.com --password ****

# per-invocation overrides:
zzb --url https://auth.dev.ab0t.com --token "$TOK" --store <org_id> \
  check user:alice viewer document:x

# env (ideal for CI / agents — no interactive login):
export ZZB_URL=https://auth.service.ab0t.com
export ZZB_TOKEN="$TOKEN"
export ZZB_STORE="$ORG_ID"
```

## The core loop (with real output)

```
$ zzb model create --file acme_model.json
✓ published authorization model 01M1FYVR1D0BSYQS19W0D8P3C7

$ zzb relationship write document:q3-report owner user:alice
+ document:q3-report#owner@user:alice  (token: eyJvcCI6…)

$ zzb transact --write document:q3-report#viewer@user:bob \
                       --write document:q3-report#editor@user:carol
✓ committed atomically: 2 written, 0 deleted  (token: eyJvcCI6…)

$ zzb check user:bob viewer document:q3-report
ALLOW  user:bob can viewer document:q3-report
  reason: Direct viewer relationship
  time:   6.54ms

$ zzb check user:dave viewer document:q3-report
DENY  user:dave can viewer document:q3-report
  reason: No viewer relationship found

$ zzb read --object document:q3-report
document:q3-report#editor@user:carol
document:q3-report#owner@user:alice
document:q3-report#viewer@user:bob

$ zzb list-users document:q3-report viewer
1 subject(s) can viewer document:q3-report:
  - user:bob

$ zzb changes --limit 5
2026-…Z  relationship_created document:q3-report#owner@user:alice
2026-…Z  relationship_created document:q3-report#viewer@user:bob
2026-…Z  relationship_created document:q3-report#editor@user:carol
resume with:  --cursor eyJidWNrZXQiOi…
```

## Verb reference

| Group | Verbs |
|---|---|
| `auth` | `register`, `login` |
| `whoami` | decode current token (subject, org, expiry); no network call |
| `org` / `config` | `create`/`delete`; inspect/clear the saved config |
| `namespace` | `create --file`, `get <name>`, `list` |
| `relationship` | `write`, `delete`, `read` |
| `transact` | `--write o#r@s` / `--delete o#r@s` (repeatable; atomic) |
| `read` | `--object` / `--user` / `--relation` / `--page-size` / `--cursor` |
| `check` | `<subject> <permission> <object>`, `bulk --file`, `wildcard` |
| `expand` | `<permission> <object> [--max-depth N]` |
| `list-objects` / `list-users` | reverse-index queries |
| `permission` | `grant` / `revoke` (wildcard grants) |
| `team` / `hierarchy` | membership; parent-org/workspace containment |
| `model` | `create --file`, `list`, `get <id>` |
| `assert` | `put <id> --file`, `get <id>`, `run <id>` |
| `changes` | `--cursor` / `--limit` (durable resumable watch) |
| `migrate` / `visualize` / `scenario` | migration helpers; graphs; demo data |
| `update` / `version` | self-update; print version |

## Honest usage / gotchas

- **A relation-only `read` is rejected** (no `--object` and no `--user`). Always
  scope reads by object or user (a relation-only scan would hit the org-wide hot
  partition).
- **`transact` writes are create-only** — writing a tuple that already exists
  aborts the whole batch (HTTP 409) and persists nothing. Delete-then-write to replace.
- **Slugs are normalized** server-side on `org create`; log in with the slug
  printed in its "Next:" hint.
- **`--json`** makes every command emit raw JSON; exit code is non-zero on any API error.

## CI / agent tips

- Set `ZZB_URL` / `ZZB_TOKEN` / `ZZB_STORE` instead of an
  interactive `auth login`.
- Pipe `--json` into `jq`; branch on exit code.
- Pin the binary version in CI; bump deliberately with `zzb update`.
