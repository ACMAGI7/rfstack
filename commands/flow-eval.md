---
description: Step 3 - fresh-context rubric eval by the evaluator subagent
---
0. **Pre-flight** (read-only). Run `scripts/preflight.sh` from `${CLAUDE_PLUGIN_ROOT}` when that variable is set, else `~/.cursor/plugins/local/rfstack/scripts/preflight.sh`. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. If it prints `missing:` or `stale plan:`, stop and show that line.

Launch the `flow-evaluator` subagent with Task. Tell it: Ponytail level full is active for this whole command, including helper agents. Give it ONLY: path to `.flow/PRD.md`, the base branch, and the rubric text below. Do not pass your own reasoning.

Rubric lookup. Use the first file that exists. Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset:
1. `.claude/rubric.md` in the project
2. `${CLAUDE_PLUGIN_ROOT}/rubric.md` only when `CLAUDE_PLUGIN_ROOT` is set
3. `~/.cursor/plugins/local/rfstack/rubric.md`
4. If none of those exist, use this default:

Score each 1-5. Pass bar: every category >= 3 and average >= 4.
1. Code quality - simple, no dead code or bloat, clear names, matches repo conventions, typed, errors handled.
2. Project vision fit - does what the PRD asks, nothing out of scope, fits existing architecture.
3. Behavior - every "Done means" item is demonstrably met; tests cover behavior not implementation; edge cases.
4. Safety - no secrets in code, no destructive migrations without a plan, work on a branch, nothing merged or pushed to main.

Save its scorecard to `.flow/EVAL.md`. That write is **change, branch-only, ask first.** If any category is below the pass bar, fix those items (counts toward review cap), otherwise proceed. A fix is **change, branch-only, ask first.**

## End of run
Show the cost from ponytail's task log (`~/.config/ponytail/band/*.csv`) or `total_cost_usd`. If you cannot read a cost, say the cost is unknown. Do not invent a number.

## Guardrails (always)
- Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
