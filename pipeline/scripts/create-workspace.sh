#!/usr/bin/env bash
# Create client repo from a template, push BRIEF.md, labels + issues from its Tasks, kickoff as issue.
# DRY_RUN=1 (default) only prints. Needs gh logged in (or GH_TOKEN) with repo scope.
set -euo pipefail
: "${CLIENT:?}"; ORG="${ORG:-ACMAGI7}"; TEMPLATE="${TEMPLATE:-ACMAGI7/UMEKA-Sol}"; OUT="${OUT:-out}"
REPO="$ORG/$(echo "$CLIENT" | tr ' A-Z' '-a-z')-sol"; DRY="${DRY_RUN:-1}"
run() { if [ "$DRY" = 1 ]; then echo "[dry-run] $*"; else "$@"; fi; }

# Template repo must have "Template repository" ticked in its settings.
run gh repo create "$REPO" --private --template "$TEMPLATE"
run gh api -X PUT "repos/$REPO/contents/BRIEF.md" -f message="Add brief" -f content="$(base64 < "$OUT/BRIEF.md" | tr -d '\n')"
for l in discovery backend frontend rollout needs-fix needs-human; do run gh label create "$l" -R "$REPO" -f; done
grep -E '^- \[ \] .+\|' "$OUT/BRIEF.md" | sed 's/^- \[ \] //' | while IFS='|' read -r title label who; do
  run gh issue create -R "$REPO" -t "$(echo $title)" -b "From BRIEF.md" -l "$(echo $label)" -a "$(echo $who)"
done
# Kickoff stays inside GitHub. Nothing external is sent.
run gh issue create -R "$REPO" -t "Kickoff" -F "$OUT/KICKOFF.md" -l discovery

# TODO(notion): create client page under Refinery Solutions DB. Token: secret NOTION_TOKEN.
# TODO(drive): create Drive folder "Clients/$CLIENT". Credential: secret GDRIVE_SA_JSON.
echo "workspace: $REPO"
