---
description: Step 1 - grill the user into a short PRD before any code
argument-hint: <what to build or fix>
---
Task: $ARGUMENTS

0. **Pre-flight** (read-only). Run `scripts/preflight.sh` from `${CLAUDE_PLUGIN_ROOT}` when that variable is set, else `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Pass `--skill 'dispatching-parallel-agents|npx skills add obra/superpowers' --skill 'grill-me|npx skills add mattpocock/skills' --skill 'writing-plans|npx skills add obra/superpowers'`. If it prints `missing:` or `stale plan:`, stop and show that line.

1. If this is a bug: first dispatch parallel subagents (skill `dispatching-parallel-agents`): one gathers bug context (repro, logs, related code, git blame), one maps repo conventions (structure, patterns, test setup). Wait for both.
2. Use the `grill-me` skill: ask one question at a time until goal, scope and done-means are unambiguous. Stop asking once clear.
3. Write `.flow/PRD.md` with: Goal, In scope, Out of scope, Done means (testable checks), Risks. Keep it under one page. **change, branch-only, ask first.**
4. Use `writing-plans` to turn it into a short step plan in `.flow/PLAN.md`. Include a line `Base: <full HEAD sha>` and a line `Files: <comma-separated paths this plan will touch>`. Do not write code yet. Ask for confirmation. **change, branch-only, ask first.**

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
