---
name: rf-shared
description: Shared stop rules for the rf-new, rf-audit and rf-scan bot recipes. Generated from the rfstack command guardrails.
---

# rf-shared

Generated from `commands/rf-new.md`, `commands/rf-audit.md`, `commands/rf-scan.md`, and `commands/flow*.md`. Edit those, then update this file.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

## Step 0
Run `scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. It checks skills (`missing: X, install with Y`), that `.flow/PLAN.md` is still on the same base commit, that gstack telemetry is off and `codex_reviews` is `disabled` (`gstack-config set codex_reviews disabled`), and (for `/rf-scan`) which scanners are installed. `--partial` continues without the missing scanners. Also read `git status`, `git log -5`, and README / CLAUDE.md / AGENTS.md.

## Report (`rf-merge-report`)
No concrete case, no finding. Each kept item is "this input → this wrong result" with `file:line`. Scanner hits keep their rule id. Duplicates become one item that lists the tools. Groups: Must fix, Should fix, Nice to have. Max 20. Each has What, Problem, Fix, If we skip it. Start with a 3-line summary for Chase: what is wrong, what to fix first, cost of this run. Also return SARIF. The agent uses Read, Grep, Glob only.

## Chase's stop points
Never push, merge, tag, release, send, or deploy without a yes in this chat. No secrets in files. Stop if the plan is stale. Any repo change is **change, branch-only, ask first.** Live tests only on a test URL Chase names. Stripe is test mode only. Refuse `sk_live`.

## Spending caps
`/rf-new` lean/deep: 2/4 helper agents. Review loops 2. Test-repair loops 3. Not in CI.
`/rf-audit` lean/deep: 2/5 helper agents. Diff mode in CI: `--max-budget-usd 2 --max-turns 40`.
`/rf-scan` lean/deep: 2/5 helper agents. One second opinion. CI: `--max-budget-usd 2 --max-turns 40`.
End every run with the cost, or "cost unknown". Do not invent a number.

These caps are starting guesses.
