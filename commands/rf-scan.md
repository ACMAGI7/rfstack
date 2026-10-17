---
description: Security scan. Scanners run before any AI review. Lean by default. --deep adds more checks. --partial continues when a scanner is missing.
argument-hint: "[--deep] [--partial]"
---
Task: $ARGUMENTS

Lean is the default. `--partial` carries on with the scanners that are installed. `--deep` adds the extra checks. Scanners run before any AI review.

## Step 0 — pre-flight (read-only)
Find `scripts/preflight.sh` in this order. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset:
1. `${CLAUDE_PLUGIN_ROOT}/scripts/preflight.sh` when `CLAUDE_PLUGIN_ROOT` is set
2. `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`
3. The `scripts/preflight.sh` next to this plugin

Always pass `--scanners`. Also pass `--partial` when the user passed `--partial`.

Skills: `--skill 'gstack:cso|npx skills add garrytan/gstack' --skill 'pstack:thermos|claude plugin install pstack@pstack-claude' --skill 'pstack:interrogate|claude plugin install pstack@pstack-claude' --skill 'pstack:blast-radius|claude plugin install pstack@pstack-claude'`

With `--deep`, also pass `--skill 'trailofbits:rust-review|npx skills add trailofbits/skills' --skill 'trailofbits:insecure-defaults|npx skills add trailofbits/skills' --skill 'trailofbits:supply-chain-risk-auditor|npx skills add trailofbits/skills' --skill 'trailofbits:fp-check|npx skills add trailofbits/skills' --skill 'trailofbits:variant-analysis|npx skills add trailofbits/skills'`. Trail of Bits skills are CC-BY-SA. Point at them. Do not copy them into this repo.

If it prints `missing:` or `stale plan:`, stop and show that line. A missing scanner stops unless `--partial` was passed.

Read `git status`, `git log -5`, the branch name, and README, CLAUDE.md and AGENTS.md when they exist.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Spending cap: 2 helper agents, or 5 with `--deep`. One second-opinion pass. CI uses `--max-budget-usd 2 --max-turns 40`. Show this cap before step 1.

## Scanners first (before any AI review)
Run only the tools that are installed. Record the exact command and its raw output path. Writing files under `.flow/` is **change, branch-only, ask first.** Until there is a yes, keep results in the chat.

1. Secrets, including git history: `gitleaks git --report-format sarif`.
2. Known-bad packages: `osv-scanner scan -r . --format sarif`. If osv-scanner is missing, fall back to `npm audit --json` when `package.json` exists and `cargo audit --json` when `Cargo.toml` exists.
3. Code patterns: `semgrep scan --config auto --sarif`. Free registry rules, internal use.
4. Supabase `get_advisors` for security and for performance, for the project named in the repo config. Read-only. If there is no Supabase project or no connection, write "not run" and continue. Do not copy supabase/splinter.

## Then the AI
5. Refinery checklist. Read the code. A hit still needs a concrete case (`file:line`).
   - Supabase: row-level security is on for every public table. The `service_role` key is never in client code. Advisors are clean, or name the advisor id.
   - Stripe: every webhook checks the signature with `constructEvent`. No key starting with `sk_live` in the repo. Test mode is the default.
   - Tauri: capabilities and permissions are as small as they can be. A content security policy is set. No signing keys, `.p8`, or `apple.env` in the repo. The updater private key is not in git.
   - Next.js / Vercel: server-only env vars are not prefixed `NEXT_PUBLIC_`. API routes check who is calling.
   - Thai tax software: taxpayer id numbers and personal data are never written to logs (PDPA).
6. AI security review with `gstack:cso --code --owasp --supply-chain`. Start from the scanner results. Explain them. Do not hunt from scratch.
7. One second opinion on the Must-fix items only. Use `pstack:thermos` when the scan is of a branch change. Use `pstack:interrogate` when it is the whole repo. Do not run both.
8. Merge scanner and AI findings with `rf-merge-report` (Read, Grep, Glob only). It writes nothing itself. Saving `.flow/SECURITY.md` and `.flow/security.sarif` is **change, branch-only, ask first.**
9. Fixes only after Chase picks numbers in chat. Then `pstack:blast-radius`, then `/flow`. **change, branch-only, ask first.**

## --deep adds
- `gstack:cso --infra --skills` after step 6.
- Point at Trail of Bits `rust-review`, `insecure-defaults`, `supply-chain-risk-auditor`, `fp-check` and `variant-analysis`. Do not copy them.
- CodeQL only on a public repo.
- Live testing with `penetration-testing-with-strix` only after Chase names a test URL in this chat. Never on a live site. One URL at a time.
- Repo hooks (gitleaks pre-commit, `setup-pre-commit`, `git-guardrails-claude-code`) are **change, branch-only, ask first.**

## End of run
The report starts with a 3-line summary for Chase. Then show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number. Do not merge, push, tag, or release.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Never merge or push to `main` or `master` without an explicit yes in this chat.
- No secrets in files, commits, logs, or the report. Redact any leaked key to its prefix.
- Gstack telemetry stays off. Do not turn on `codex_reviews`.
- Stopping ponytail is allowed. The next `/rf-*` or `/flow*` command turns level full back on in step 0.
