#!/usr/bin/env sh
# =============================================================================
# zzb installer  (public GitHub release)
# =============================================================================
#
# zzb is a single static Go binary — the command-line client for the
# ab0t auth service's authorization API (https://auth.service.ab0t.com):
# relationships, transact, read, check, expand, list, authorization-models,
# assertions, durable watch — in the spirit of SpiceDB's `zed` and the Auth0 CLI.
#
# This script downloads the matching prebuilt `zzb` binary from the public
# GitHub repo's raw content, verifies its sha256 against the published
# checksums.txt, and installs it onto your PATH.
#
# What it does, in order:
#   1. Detects host OS + arch (linux/darwin, amd64/arm64) via `uname`.
#   2. Fetches release/checksums.txt over HTTPS, then release/zzb-<os>-<arch>.
#   3. Verifies the binary against the published sha256 — MANDATORY.
#   4. Picks an install dir: $HOME/.local/bin when it's on PATH or writable,
#      else /usr/local/bin (with a sudo fallback).
#   5. Installs atomically, keeping the prior binary as `<binary>.previous`
#      for one-step rollback.
#   6. Confirms with `zzb --version`.
#
# Properties (compliance):
#   - POSIX sh; runs under /bin/sh on Linux / macOS / busybox.
#   - HTTPS only — TLS verification is ALWAYS on (`-k` / `--insecure` NEVER used).
#   - sha256 verification is mandatory; refuses to install on a mismatch or a
#     missing/empty checksums.txt.
#   - No destructive operations: never `rm -rf` of user data; only writes the
#     install dir + a temp dir it creates and cleans up itself.
#   - Atomic install via `install`/`mv` of a fully-verified tempfile.
#   - Idempotent: re-running upgrades/downgrades; same version = no-op exit 0.
#   - Rollback: keeps one `.previous`. No telemetry, no analytics.
#
# ── SOURCE ───────────────────────────────────────────────────────────────────
#   REPO_RAW below points at the public GitHub RAW base for this repo. It is set
#   to the published home, github.com/ab0t-com/ab0t-zzb. A forker would replace
#   the org/repo with their own; end users never edit it. It can also be
#   overridden at run time with ZZB_INSTALL_BASE=... (e.g. a private mirror).
# -----------------------------------------------------------------------------
#
# Usage (end user):
#   curl -fsSL https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main/install.sh | sh
#
# Pin a git ref, override the source, or force an install dir:
#   REF=v0.1.0 curl -fsSL .../install.sh | sh
#   ZZB_INSTALL_BASE=https://mirror.example.com/zzb curl -fsSL .../install.sh | sh
#   INSTALL_DIR=$HOME/bin curl -fsSL .../install.sh | sh
#
# Exit codes: 0 installed / up-to-date · 1 user error · 2 internal error.
# =============================================================================

set -eu

# ----- knobs ----------------------------------------------------------------
NAME="zzb"

# The public GitHub raw base the one-liner is served from and where the binary
# is fetched. A forker replaces the <org>/<repo> with their own published repo.
REPO_RAW="https://raw.githubusercontent.com/ab0t-com/ab0t-zzb/main"

# REF lets a user pin a tag/branch/sha of the raw content (only meaningful when
# REPO_RAW is left at its default githubusercontent form).
REF="${REF:-main}"
case "$REPO_RAW" in
    https://raw.githubusercontent.com/*/*/*)
        # normalise the trailing ref segment to $REF (…/<org>/<repo>/<ref>)
        REPO_RAW="$(printf '%s' "$REPO_RAW" | sed "s@\(https://raw.githubusercontent.com/[^/]*/[^/]*\)/.*@\1/${REF}@")"
        ;;
esac

# ZZB_INSTALL_BASE overrides the whole base URL (mirror / dev server / a fork).
BASE_URL="${ZZB_INSTALL_BASE:-$REPO_RAW}"

# ----- pretty print ---------------------------------------------------------
RED=""; GREEN=""; YELLOW=""; BOLD=""; RESET=""
if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
    if [ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]; then
        RED="$(tput setaf 1)"; GREEN="$(tput setaf 2)"; YELLOW="$(tput setaf 3)"
        BOLD="$(tput bold)"; RESET="$(tput sgr0)"
    fi
fi
info() { printf "%s->%s %s\n" "$BOLD" "$RESET" "$*"; }
ok()   { printf "%s[ok]%s %s\n" "$GREEN" "$RESET" "$*"; }
warn() { printf "%s[!]%s %s\n" "$YELLOW" "$RESET" "$*" >&2; }
fail() { printf "%s[x]%s %s\n" "$RED"   "$RESET" "$*" >&2; exit 1; }

# ----- prerequisites --------------------------------------------------------
need() { command -v "$1" >/dev/null 2>&1 || fail "required tool missing: $1"; }
need uname
need curl
need mktemp
if   command -v sha256sum >/dev/null 2>&1; then SHA256_CMD="sha256sum"
elif command -v shasum    >/dev/null 2>&1; then SHA256_CMD="shasum -a 256"
elif command -v openssl   >/dev/null 2>&1; then SHA256_CMD="openssl_sha256"
else fail "no sha256 tool found (need one of: sha256sum, shasum, openssl)"
fi
sha256_of() {
    case "$SHA256_CMD" in
        openssl_sha256) openssl dgst -sha256 "$1" | awk '{print $NF}' ;;
        *)              $SHA256_CMD "$1" | awk '{print $1}' ;;
    esac
}

# ----- detect OS + arch -----------------------------------------------------
case "$(uname -s)" in
    Linux*)  OS="linux"  ;;
    Darwin*) OS="darwin" ;;
    MINGW*|MSYS*|CYGWIN*|Windows*)
        fail "this is Windows — use the PowerShell installer instead:
      irm ${BASE_URL}/install.ps1 | iex
    (or download release/zzb-windows-amd64.exe and verify it against release/checksums.txt)" ;;
    *) fail "unsupported OS: $(uname -s) — supported: Linux, macOS, Windows (amd64/arm64)" ;;
esac
case "$(uname -m)" in
    x86_64|amd64)  ARCH="amd64" ;;
    arm64|aarch64) ARCH="arm64" ;;
    *) fail "unsupported architecture: $(uname -m)" ;;
esac
PLATFORM="${OS}-${ARCH}"
ASSET="zzb-${PLATFORM}"

info "Source:       ${BOLD}${BASE_URL}${RESET}"
info "Platform:     ${BOLD}${PLATFORM}${RESET}  (asset: ${ASSET})"

# ----- resolve published version --------------------------------------------
PUBLISHED="$(curl --proto '=https' --tlsv1.2 -fsSL --max-time 15 \
    "${BASE_URL}/release/VERSION" 2>/dev/null | tr -d '\r\n[:space:]' || true)"
[ -n "$PUBLISHED" ] && info "Published version: ${BOLD}${PUBLISHED}${RESET}"

# ----- choose install dir ---------------------------------------------------
# Preference: an explicit INSTALL_DIR > $HOME/.local/bin (if on PATH or we can
# make it writable) > /usr/local/bin (needs sudo). This keeps the common case
# sudo-free.
choose_dir() {
    if [ -n "${INSTALL_DIR:-}" ]; then printf '%s' "$INSTALL_DIR"; return; fi
    lb="${HOME:-}/.local/bin"
    if [ -n "${HOME:-}" ]; then
        case ":$PATH:" in
            *":$lb:"*) printf '%s' "$lb"; return ;;   # already on PATH → best choice
        esac
        if mkdir -p "$lb" 2>/dev/null && [ -w "$lb" ]; then printf '%s' "$lb"; return; fi
    fi
    printf '%s' "/usr/local/bin"
}
DEST_DIR="$(choose_dir)"
DEST="${DEST_DIR}/${NAME}"
PREV="${DEST}.previous"
info "Install path: ${BOLD}${DEST}${RESET}"

# ----- short-circuit if already at the published version --------------------
if [ -n "$PUBLISHED" ] && [ -x "$DEST" ]; then
    CURRENT="$("$DEST" --version 2>/dev/null | head -1 | awk '{print $NF}' | tr -d '[:space:]' || true)"
    if [ -n "$CURRENT" ] && [ "$CURRENT" = "$PUBLISHED" ]; then
        ok "${NAME} ${PUBLISHED} already installed at ${DEST} — nothing to do."
        exit 0
    fi
    [ -n "$CURRENT" ] && info "Currently installed: ${CURRENT} → updating to ${PUBLISHED:-latest}"
fi

# ----- working dir (we own it — safe to clean up) ---------------------------
WORKDIR="$(mktemp -d 2>/dev/null || mktemp -d -t 'zzb-install')"
[ -d "$WORKDIR" ] || fail "could not create temp dir"
cleanup() { rm -rf -- "$WORKDIR"; }
trap cleanup EXIT INT HUP TERM
BIN_TMP="${WORKDIR}/${NAME}"
SUMS_TMP="${WORKDIR}/checksums.txt"

# ----- download checksums first (never install unverified) ------------------
info "Fetching release/checksums.txt"
curl --proto '=https' --tlsv1.2 -fsSL --max-time 60 --output "$SUMS_TMP" \
    "${BASE_URL}/release/checksums.txt" \
    || fail "could not fetch checksums.txt — refusing to install without verification"
[ -s "$SUMS_TMP" ] || fail "checksums.txt is empty — refusing to install"

# Lines are: "<hash>  zzb-<os>-<arch>"  (accepts an optional leading '*').
EXPECTED_HASH="$(awk -v a="$ASSET" '$2 == a || $2 == "*"a { print $1; exit }' "$SUMS_TMP" | tr -d '[:space:]')"
[ -n "$EXPECTED_HASH" ] || fail "no checksum entry for ${ASSET} in checksums.txt (is this platform published?)"
case "$EXPECTED_HASH" in *[!a-fA-F0-9]*) fail "checksum entry for ${ASSET} is malformed" ;; esac
[ "${#EXPECTED_HASH}" -eq 64 ] || fail "checksum for ${ASSET} is not 64 hex chars"

# ----- download the binary --------------------------------------------------
URL="${BASE_URL}/release/${ASSET}"
info "Downloading ${URL}"
curl --proto '=https' --tlsv1.2 -fsSL --max-time 300 --output "$BIN_TMP" "$URL" \
    || fail "download failed — the binary may not be published for ${PLATFORM} yet"
[ -s "$BIN_TMP" ] || fail "downloaded file is empty"

# ----- verify (mandatory) ---------------------------------------------------
info "Verifying sha256"
ACTUAL_HASH="$(sha256_of "$BIN_TMP")"
[ "$ACTUAL_HASH" = "$EXPECTED_HASH" ] \
    || fail "checksum mismatch — expected ${EXPECTED_HASH}, got ${ACTUAL_HASH}. Aborting (no install performed)."
ok "Checksum verified"
chmod 0755 "$BIN_TMP"

# ----- install (atomic, with rollback) --------------------------------------
SUDO=""
if ! mkdir -p "$DEST_DIR" 2>/dev/null; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"; info "Creating ${DEST_DIR} (requires sudo)"; sudo mkdir -p "$DEST_DIR" || fail "cannot create ${DEST_DIR}"
    else fail "cannot create ${DEST_DIR} and sudo is unavailable"; fi
elif [ ! -w "$DEST_DIR" ]; then
    if command -v sudo >/dev/null 2>&1; then SUDO="sudo"; info "Installing to ${DEST_DIR} requires sudo"
    else fail "${DEST_DIR} is not writable and sudo is unavailable"; fi
fi

# Snapshot the current binary for one-step rollback. We never delete it.
if [ -e "$DEST" ]; then
    info "Saving current binary as ${PREV}"
    $SUDO mv -f "$DEST" "$PREV" || fail "could not snapshot existing binary to ${PREV}"
fi

info "Installing ${NAME} → ${DEST}"
if command -v install >/dev/null 2>&1; then
    $SUDO install -m 0755 "$BIN_TMP" "$DEST" || fail "install failed"
else
    $SUDO mv -f "$BIN_TMP" "$DEST" || fail "install failed"
    $SUDO chmod 0755 "$DEST"
fi

# ----- post-install sanity --------------------------------------------------
if "$DEST" --version >/dev/null 2>&1; then
    ok "Installed: $("$DEST" --version 2>/dev/null | head -1)"
else
    warn "Installed binary did not respond to --version. Roll back with:"
    warn "  ${SUDO} mv -f \"${PREV}\" \"${DEST}\""
fi

# ----- PATH guidance --------------------------------------------------------
case ":$PATH:" in
    *":${DEST_DIR}:"*) ;;
    *) warn "${DEST_DIR} is not in your \$PATH. Add it:"
       warn "  echo 'export PATH=\"${DEST_DIR}:\$PATH\"' >> ~/.profile" ;;
esac

cat <<EOF

${BOLD}Done.${RESET} ${NAME} is installed at ${DEST}.
  Run    ${BOLD}${NAME} --help${RESET}      for the command list.
  Start  ${BOLD}${NAME} auth login --url https://auth.service.ab0t.com${RESET}   then check / relationship / model.
  Update by re-running this installer, or ${BOLD}${NAME} update${RESET}; the previous binary is kept at
  ${PREV} for rollback:  ${SUDO} mv -f "${PREV}" "${DEST}"
EOF
exit 0
