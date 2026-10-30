#!/usr/bin/env bash
# The single human gate: main needs green checks + 1 approving review. Run once per repo, by Chase.
set -euo pipefail
REPO="${1:?usage: protect-main.sh owner/repo}"
gh api -X PUT "repos/$REPO/branches/main/protection" --input - <<JSON
{"required_status_checks":{"strict":true,"contexts":["checks"]},
 "enforce_admins":true,
 "required_pull_request_reviews":{"required_approving_review_count":1,"dismiss_stale_reviews":true},
 "restrictions":null}
JSON
echo "protected main on $REPO"
