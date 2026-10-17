---
description: Read-only quality audit. Lean by default. --deep adds more checks. --diff <base> audits only the branch change.
argument-hint: "[--deep] [--diff <base>]"
---
Task: $ARGUMENTS

Lean is the default. `--deep` adds the extra checks. `--diff <base>` audits only what changed since `<base>` (`git diff <base>...HEAD` plus uncommitted edits on those files). That is the CI mode.

## Step 0 — pre-flight (read-only)
Find `scripts/preflight.sh` in this order. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset:
1. `${CLAUDE_PLUGIN_ROOT}/scripts/preflight.sh` when `CLAUDE_PLUGIN_ROOT` is set
2. `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`
3. The `scripts/preflight.sh` next to this plugin

Lean skills: `--skill 'pstack:how|claude plugin install pstack@pstack-claude' --skill 'ponytail:ponytail-audit|claude plugin install ponytail@ponytail' --skill 'gstack:health|npx skills add garrytan/gstack' --skill 'ponytail:ponytail-debt|claude plugin install ponytail@ponytail'`

With `--deep`, also pass `--skill 'pstack:thermo-nuclear-code-quality-review|claude plugin install pstack@pstack-claude' --skill 'improve-codebase-architecture|npx skills add mattpocock/skills' --skill 'gstack:test-audit|npx skills add garrytan/gstack' --skill 'pstack:correct|claude plugin install pstack@pstack-claude'`.

If it prints `missing:` or `stale plan:`, stop and show that line.

Read `git status`, `git log -5`, the branch name, and README, CLAUDE.md and AGENTS.md when they exist.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Spending cap: 2 helper agents, or 5 with `--deep`. `--diff` in CI uses `--max-budget-usd 2 --max-turns 40`. Show this cap before step 1.

## Lean steps (read-only until the report)
1. Map the repo with `pstack:how`. With `--diff`, map only the changed files.
2. Quality audit with `ponytail:ponytail-audit` (bugs, risk, scale, missing tests, speed, what to cut). Max 20 findings.
3. Health dashboard with `gstack:health` (types, lint, tests, dead code).
4. Deliberate shortcuts with `ponytail:ponytail-debt`.
5. Merge steps 2 to 4 with the `rf-merge-report` agent (Read, Grep, Glob only). It enforces "no concrete case, no finding". Saving `.flow/AUDIT.md` and `.flow/audit.sarif` is **change, branch-only, ask first.** Do not change source files. Do not push.

## --deep adds
After step 4, still read-only: `pstack:thermo-nuclear-code-quality-review`, `improve-codebase-architecture` (Matt Pocock), `gstack:test-audit`, and `pstack:correct` (report only, no edits). Feed those into the same merge. For a UI repo, you may also point at `baseline-ui`, `fixing-accessibility`, `fixing-metadata`, `fixing-motion-performance` and `gstack:design-review`. Do not copy those skills.

## End of run
The report starts with a 3-line summary for Chase. Then show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

Chase picks finding numbers in chat. Only then does a fix go through `/flow` on a branch. That later fix is **change, branch-only, ask first.**

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Never merge or push to `main` or `master` without an explicit yes in this chat.
- No secrets in files, commits, logs, or the report.
- Stopping ponytail is allowed. The next `/rf-*` or `/flow*` command turns level full back on in step 0.
