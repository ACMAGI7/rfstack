---
description: Run the full 4-step flow end-to-end (plan, review, eval, test)
argument-hint: <what to build or fix>
---
Task: $ARGUMENTS

Run in order, pausing only where noted:
1. **Plan** - follow /flow-plan. Pause for the user to confirm the PRD.
2. **Build** - create branch `flow/<slug>`; implement the plan (use `test-driven-development` where practical).
3. **Review** - follow /flow-review (max 2 rounds).
4. **Eval** - follow /flow-eval (fresh-context `flow-evaluator` subagent).
5. **Test+repair** - follow /flow-test (max 3 loops), then hand to human.

Command files are in `${CLAUDE_PLUGIN_ROOT}/commands/`; read them for detail.

## Guardrails (always)
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
