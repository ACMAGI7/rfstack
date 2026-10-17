---
description: Start work on a new branch. Lean by default. --deep adds the longer product and hook steps.
argument-hint: "[--deep] <what to build>"
---
Task: $ARGUMENTS

Lean is the default. If `$ARGUMENTS` contains `--deep`, also run the deep steps below.

## Step 0 — pre-flight (read-only)
Find `scripts/preflight.sh` in this order. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset:
1. `${CLAUDE_PLUGIN_ROOT}/scripts/preflight.sh` when `CLAUDE_PLUGIN_ROOT` is set
2. `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`
3. The `scripts/preflight.sh` next to this plugin

Run it in the target repo. Lean skills:
`--skill 'pstack:sharpen|claude plugin install pstack@pstack-claude' --skill 'grill-with-docs|npx skills add mattpocock/skills' --skill 'pstack:tdd|claude plugin install pstack@pstack-claude' --skill 'pstack:bro|claude plugin install pstack@pstack-claude'`

With `--deep`, also pass `--skill 'gstack:office-hours|npx skills add garrytan/gstack' --skill 'gstack:plan-eng-review|npx skills add garrytan/gstack' --skill 'gstack:plan-ceo-review|npx skills add garrytan/gstack' --skill 'pstack:architect|claude plugin install pstack@pstack-claude' --skill 'pstack:create-verification-skill|claude plugin install pstack@pstack-claude' --skill 'setup-pre-commit|npx skills add mattpocock/skills' --skill 'git-guardrails-claude-code|npx skills add mattpocock/skills'`.

If it prints `missing:` or `stale plan:`, stop and show that line. Do not install anything yourself.

Read `git status`, `git log -5`, the branch name, and README, CLAUDE.md and AGENTS.md when they exist.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Spending cap: 2 helper agents, or 4 with `--deep`. Review loops max 2. Test-repair loops max 3. Not run in CI. Show this cap before step 1.

## Lean steps
1. Restate the goal in 3 lines with `pstack:sharpen`. Read-only.
2. Grill the tech choices with `grill-with-docs` (Matt Pocock) and write the decisions. **change, branch-only, ask first.** Only then write `docs/adr/*` and `GLOSSARY.md` on branch `rf/<slug>`.
3. One-page plan with `/flow-plan`. `.flow/PLAN.md` must contain `Base: <full HEAD sha>` and `Files: <comma-separated paths this plan will touch>`. **change, branch-only, ask first.**
4. Build, test first, with `pstack:tdd` and ponytail level full. **change, branch-only, ask first.**
5. `/flow-review`, then `/flow-eval`, then `/flow-test`. **change, branch-only, ask first.**
6. Plain summary with `pstack:bro`: what was done, what was skipped, risks, branch name. Chat only. No push.

## --deep adds
- Before step 2: `gstack:office-hours` in startup mode. Read-only.
- After step 3: `gstack:plan-eng-review`. Add `gstack:plan-ceo-review` only when this is a product bet. Edits to the plan are **change, branch-only, ask first.**
- Before step 4: `pstack:architect`. Any skeleton it writes is **change, branch-only, ask first.**
- `pstack:create-verification-skill` for a "does the app still work" skill. **change, branch-only, ask first.**
- Repo hooks with `setup-pre-commit`, `git-guardrails-claude-code`, and a gitleaks pre-commit hook. **change, branch-only, ask first.**

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or, in CI, `total_cost_usd` from `--output-format json`. If you cannot read a cost, say the cost is unknown. Do not invent a number. Do not merge, push, tag, or release.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Branch `rf/<slug>` only. Never merge or push to `main` or `master` without an explicit yes in this chat.
- No secrets in files, commits, or logs.
- Stopping ponytail is allowed. The next `/rf-*` or `/flow*` command turns level full back on in step 0.
