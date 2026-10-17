---
name: rf-scan
description: Bot recipe for /rf-scan. Scanners before AI. Lean by default. Generated from commands/rf-scan.md.
---

# rf-scan

Generated from `commands/rf-scan.md`. Edit that file, then update this one. Follow `rf-shared`.

Ponytail level full is active for this whole command, including helper agents.

Scanners before any AI review. Lean unless `--deep`. `--partial` keeps going with the scanners that are installed. Cap: 2 helper agents, or 5 with `--deep`. One second opinion. CI: `--max-budget-usd 2 --max-turns 40`.

## Lean
0. Pre-flight with `--scanners`. Skills: `gstack:cso`, `pstack:thermos`, `pstack:interrogate`, `pstack:blast-radius`.
1. `gitleaks git --report-format sarif`.
2. `osv-scanner scan -r . --format sarif`. Else `npm audit --json` and `cargo audit --json`.
3. `semgrep scan --config auto --sarif`.
4. Supabase `get_advisors` (security and performance). Read-only. "not run" if there is no project.
5. Refinery checklist in `commands/rf-scan.md` (Supabase RLS, Stripe signature, no `sk_live`, Tauri capabilities, Next.js env, PDPA logs).
6. `gstack:cso --code --owasp --supply-chain`, explaining the scanner hits.
7. One of `pstack:thermos` (branch change) or `pstack:interrogate` (whole repo). Not both.
8. `rf-merge-report` → `.flow/SECURITY.md` and `.flow/security.sarif`. **change, branch-only, ask first.**
9. Fixes only after Chase picks numbers: `pstack:blast-radius`, then `/flow`. **change, branch-only, ask first.**

## --deep adds
`gstack:cso --infra --skills`. Point at Trail of Bits `rust-review`, `insecure-defaults`, `supply-chain-risk-auditor`, `fp-check`, `variant-analysis` (CC-BY-SA, do not copy). CodeQL on public repos only. Strix only on a test URL Chase names. Repo hooks are **change, branch-only, ask first.**

## Stop
Do not merge, push, or deploy. Show the cost or say the cost is unknown. Redact keys to a prefix.
