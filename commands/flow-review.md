---
description: Step 2 - adversarial review to simplify and de-bloat (max 2 rounds)
---
0. **Pre-flight** (read-only). Run `scripts/preflight.sh` from `${CLAUDE_PLUGIN_ROOT}` when that variable is set, else `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Pass `--skill 'ponytail-review|claude plugin install ponytail@ponytail' --skill 'no-mistakes|npx skills add kunchenguid/no-mistakes'`. If it prints `missing:` or `stale plan:`, stop and show that line.

Review the diff vs the base branch (`git diff main...HEAD` plus uncommitted).
Round = run `ponytail-review` (cut code you don't need) and `pstack` principles (`correct`, `principle-subtract-before-you-add`, `principle-fix-root-causes`), then apply fixes. Use `no-mistakes` as the pre-push gate if configured.
Do at most 2 rounds total; record findings and what changed in `.flow/REVIEW.md`. If issues remain after round 2, list them and stop. Writing `.flow/REVIEW.md` or applying a fix is **change, branch-only, ask first.**

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
