---
name: rf-new
description: Bot recipe for /rf-new. Lean by default, --deep for the longer steps. Generated from commands/rf-new.md.
---

# rf-new

Generated from `commands/rf-new.md`. Edit that file, then update this one. Follow `rf-shared`.

Ponytail level full is active for this whole command, including helper agents.

Branch `rf/<slug>`. Lean unless `--deep` is present. Cap: 2 helper agents, or 4 with `--deep`.

## Lean
0. Pre-flight. Skills: `pstack:sharpen`, `grill-with-docs`, `pstack:tdd`, `pstack:bro`. Stop on `missing:` or `stale plan:`.
1. `pstack:sharpen`. Read-only. Three lines.
2. `grill-with-docs`. **change, branch-only, ask first.**
3. `/flow-plan`, with `Base:` and `Files:` in `.flow/PLAN.md`. **change, branch-only, ask first.**
4. `pstack:tdd`, ponytail full. **change, branch-only, ask first.**
5. `/flow-review` → `/flow-eval` → `/flow-test`. **change, branch-only, ask first.**
6. `pstack:bro` in chat. No push.

## --deep adds
`gstack:office-hours` before step 2. `gstack:plan-eng-review` and, for a product bet, `gstack:plan-ceo-review` after step 3. `pstack:architect` before step 4. `pstack:create-verification-skill`. Repo hooks via `setup-pre-commit`, `git-guardrails-claude-code`, and gitleaks. Every one of those writes is **change, branch-only, ask first.**

## Stop
Do not merge, push, tag, or release. Show the cost or say the cost is unknown.
