---
description: Step 4 - run the app, e2e test, fail->fix->retest (max 3 loops)
---
0. **Pre-flight** (read-only). Run `scripts/preflight.sh` from `${CLAUDE_PLUGIN_ROOT}` when that variable is set, else `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Pass `--skill 'systematic-debugging|npx skills add obra/superpowers' --skill 'verification-before-completion|npx skills add obra/superpowers'`. If it prints `missing:` or `stale plan:`, stop and show that line.

1. Run the project's tests/lint/typecheck. Start the app.
2. For UI changes, write/run Playwright e2e covering every "Done means" item in `.flow/PRD.md`. **change, branch-only, ask first.**
3. On failure: use `systematic-debugging`, fix the root cause, retest. Max 3 loops. A fix is **change, branch-only, ask first.**
4. Use `verification-before-completion`. Write `.flow/TEST.md` (what ran, results, evidence). Commit on the branch, then hand to the user: summary, branch name, open issues, and the cost of this run. Do NOT merge or push to main. The commit is **change, branch-only, ask first.**

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
