---
description: Run the full 4-step flow end-to-end (plan, review, eval, test)
argument-hint: <what to build or fix>
---
Task: $ARGUMENTS

0. **Pre-flight** (read-only). Run `scripts/preflight.sh` from `${CLAUDE_PLUGIN_ROOT}` when that variable is set, else `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Pass `--skill 'grill-me|npx skills add mattpocock/skills' --skill 'writing-plans|npx skills add obra/superpowers' --skill 'test-driven-development|npx skills add obra/superpowers' --skill 'ponytail-review|claude plugin install ponytail@ponytail' --skill 'systematic-debugging|npx skills add obra/superpowers' --skill 'verification-before-completion|npx skills add obra/superpowers'`. If it prints `missing:` or `stale plan:`, stop and show that line.

Run in order, pausing only where noted:
1. **Plan** - follow /flow-plan. Pause for the user to confirm the PRD.
2. **Build** - create branch `flow/<slug>`; implement the plan (use `test-driven-development` where practical).
3. **Review** - follow /flow-review (max 2 rounds).
4. **Eval** - follow /flow-eval (fresh-context `flow-evaluator` subagent).
5. **Test+repair** - follow /flow-test (max 3 loops), then hand to human.

Command files are in `${CLAUDE_PLUGIN_ROOT}/commands/` when `CLAUDE_PLUGIN_ROOT` is set. If it is unset, use `~/.cursor/plugins/local/rfstack/commands/` or the folder this file was loaded from. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Read those files for detail.

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
- Any step that edits the repo is change, branch-only, ask first.
