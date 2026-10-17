#!/usr/bin/env bash
# Backup only. If ponytail's flag is missing or "off", switch it back to full.
# Does not block "stop ponytail". The next session or prompt turns it back on.
# Pass "startup" to also print who decides how much code to write.
flag="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/.ponytail-active"
mode=""
[ -f "$flag" ] && mode=$(tr -d '[:space:]' < "$flag" 2>/dev/null || true)
if [ -z "$mode" ] || [ "$mode" = "off" ]; then
  mkdir -p "$(dirname "$flag")" 2>/dev/null || true
  printf '%s\n' full > "$flag" 2>/dev/null || true
  echo "Ponytail full is required in rfstack; it is back on."
fi
if [ "${1:-}" = "startup" ]; then
  echo "Ponytail sets how much code to write; pstack sets the routine."
fi
exit 0
