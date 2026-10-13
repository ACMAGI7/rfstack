---
description: Step 3 - fresh-context rubric eval by the evaluator subagent
---
Launch the `flow-evaluator` subagent with Task. Give it ONLY: path to `.flow/PRD.md`, the base branch, and the rubric path (`.claude/rubric.md` in the project if it exists, else `${CLAUDE_PLUGIN_ROOT}/rubric.md`). Do not pass your own reasoning.
Save its scorecard to `.flow/EVAL.md`. If any category is below the pass bar, fix those items (counts toward review cap), otherwise proceed.

## Guardrails (always)
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
