# git hooks — secret scanning

This repo scans for secrets with **git hooks**, not a CI workflow. Enable them
once per clone (git does not activate tracked hooks automatically):

```sh
git config core.hooksPath .githooks
```

- `pre-commit` — scans staged changes; blocks a commit that adds a credential or
  internal reference. Uses [`gitleaks`](https://github.com/gitleaks/gitleaks) if
  installed, otherwise a regex backstop.
- `pre-push` — full-tree gitleaks scan before the (irreversible) publish.

Install gitleaks for the strongest scan; without it the hooks fall back to a
pattern match and still block the obvious cases. False positives go in
`.gitleaksignore`.
