#!/usr/bin/env bash
# Fill templates/brief.md and templates/kickoff.md from env vars. Writes out/BRIEF.md, out/KICKOFF.md.
set -euo pipefail
here="$(cd "$(dirname "$0")/.." && pwd)"; out="${OUT:-out}"; mkdir -p "$out"
: "${CLIENT:?}" "${SCOPE:?}"
export WHO="${WHO:-TODO who}" WHAT="${WHAT:-TODO what}" OBSTACLE="${OBSTACLE:-TODO obstacle}" \
  COST="${COST:-TODO cost}" STACK="${STACK:-TODO pick from stack menu}" OWNER="${OWNER:-longjumpguy}" \
  REPO_URL="${REPO_URL:-https://github.com/${ORG:-ACMAGI7}/$(echo "$CLIENT" | tr ' A-Z' '-a-z')-sol}"
fill() { python3 - "$1" <<'PY'
import os,re,sys
print(re.sub(r"\{\{(\w+)\}\}", lambda m: os.environ.get(m[1], m[0]), open(sys.argv[1]).read()), end="")
PY
}
fill "$here/templates/brief.md" > "$out/BRIEF.md"
fill "$here/templates/kickoff.md" > "$out/KICKOFF.md"
echo "wrote $out/BRIEF.md $out/KICKOFF.md"
