---
name: rf-audit
description: Bot recipe for /rf-audit. Lean by default, --deep and --diff. Generated from commands/rf-audit.md.
---

# rf-audit

Generated from `commands/rf-audit.md`. Edit that file, then update this one. Follow `rf-shared`.

Ponytail level full is active for this whole command, including helper agents.

Read-only until the report. Lean unless `--deep`. `--diff <base>` audits only `git diff <base>...HEAD`. Cap: 2 helper agents, or 5 with `--deep`. Diff mode in CI: `--max-budget-usd 2 --max-turns 40`.

## Lean
0. Pre-flight. Skills: `pstack:how`, `ponytail:ponytail-audit`, `gstack:health`, `ponytail:ponytail-debt`.
1. `pstack:how`.
2. `ponytail:ponytail-audit`.
3. `gstack:health`.
4. `ponytail:ponytail-debt`.
5. `rf-merge-report` → `.flow/AUDIT.md` and `.flow/audit.sarif`. Saving them is **change, branch-only, ask first.**

## --deep adds
`pstack:thermo-nuclear-code-quality-review`, `improve-codebase-architecture`, `gstack:test-audit`, `pstack:correct` (report only). For a UI repo, point at `baseline-ui`, `fixing-accessibility`, `fixing-metadata`, `fixing-motion-performance`, and `gstack:design-review`. Do not copy them.

## Stop
No source edits in the audit. Fixes wait until Chase picks numbers, then `/flow`. Do not push. Show the cost or say the cost is unknown.
