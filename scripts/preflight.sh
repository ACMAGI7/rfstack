#!/usr/bin/env bash
# rfstack step 0. Read-only. "missing: X, install with Y" or "stale plan: ...".
set -u
repo="."; partial=0; scanners=0; skills=()
while [ $# -gt 0 ]; do
  case "$1" in
    --repo) repo="$2"; shift 2;;
    --skill) skills+=("$2"); shift 2;;
    --scanners) scanners=1; shift;;
    --partial) partial=1; shift;;
    *) echo "unknown arg: $1" >&2; exit 2;;
  esac
done
stop() { printf '%s\n' "$*" >&2; exit 1; }
roots="${RFSTACK_SKILL_DIRS:-$HOME/.claude/skills:$HOME/.agents/skills:$HOME/.claude/plugins:$HOME/.cursor/plugins}"
for spec in "${skills[@]+"${skills[@]}"}"; do
  name="${spec%%|*}"; how="${spec#*|}"; short="${name##*:}"; found=0
  IFS=':' read -r -a dirs <<< "$roots"
  for d in "${dirs[@]}"; do
    [ -d "$d" ] || continue
    if [ -e "$d/$short" ] || [ -e "$d/$short.md" ] || find "$d" -maxdepth 7 -name "$short" -print -quit 2>/dev/null | grep -q .; then found=1; break; fi
  done
  [ "$found" = 1 ] || stop "missing: $name, install with $how"
done
if [ -f "$repo/.flow/PLAN.md" ]; then
  base=$(sed -n 's/^Base:[[:space:]]*//p' "$repo/.flow/PLAN.md" | head -1 | tr -d '`[:space:]')
  [ -n "$base" ] || stop "stale plan: .flow/PLAN.md has no Base commit"
  headsha=$(git -C "$repo" rev-parse HEAD 2>/dev/null) || stop "stale plan: cannot read HEAD"
  basefull=$(git -C "$repo" rev-parse --verify "${base}^{commit}" 2>/dev/null) || stop "stale plan: base $base is not in this repo"
  [ "$basefull" = "$headsha" ] || stop "stale plan: base moved ($basefull -> $headsha)"
  files=$(sed -n 's/^Files:[[:space:]]*//p' "$repo/.flow/PLAN.md" | head -1 | tr -d '`')
  IFS=','; for raw in $files; do
    f=$(printf '%s' "$raw" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [ -n "$f" ] || continue
    if git -C "$repo" cat-file -e "$basefull:$f" 2>/dev/null; then
      [ -e "$repo/$f" ] || stop "stale plan: $f is gone"
      git -C "$repo" diff --quiet "$basefull" -- "$f" || stop "stale plan: $f changed since base"
    elif [ -e "$repo/$f" ]; then stop "stale plan: $f was not in the base and is now present"; fi
  done; unset IFS
fi
cfg="${GSTACK_CONFIG:-$HOME/.claude/skills/gstack/bin/gstack-config}"
if [ -x "$cfg" ]; then
  norm() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]'; }
  tel=$(norm "$("$cfg" get telemetry 2>/dev/null || true)")
  codex=$(norm "$("$cfg" get codex_reviews 2>/dev/null || true)")
  [ "$tel" = "off" ] || stop "gstack telemetry is not off (got: ${tel:-empty}). Turn it off. This check does not change settings."
  [ "$codex" = "off" ] || stop "gstack codex_reviews is not off (got: ${codex:-empty}). Turn it off. This check does not change settings."
else echo "note: gstack-config not found; telemetry not active"; fi
if [ "$scanners" = 1 ]; then
  miss=()
  command -v gitleaks >/dev/null 2>&1 || miss+=("missing: gitleaks, install with brew install gitleaks")
  command -v osv-scanner >/dev/null 2>&1 || miss+=("missing: osv-scanner, install with brew install osv-scanner")
  command -v semgrep >/dev/null 2>&1 || miss+=("missing: semgrep, install with brew install semgrep")
  if [ "${#miss[@]}" -gt 0 ]; then
    if [ "$partial" = 1 ]; then printf 'partial: continuing\n'; printf '%s\n' "${miss[@]}"; else printf '%s\n' "${miss[@]}" >&2; exit 1; fi
  fi
fi
echo "preflight ok"
