---
description: Step 1 - grill the user into a short PRD before any code
argument-hint: <what to build or fix>
---
Task: $ARGUMENTS

1. If this is a bug: first dispatch parallel subagents (skill `dispatching-parallel-agents`): one gathers bug context (repro, logs, related code, git blame), one maps repo conventions (structure, patterns, test setup). Wait for both.
2. Use the `grill-me` skill: ask one question at a time until goal, scope and done-means are unambiguous. Stop asking once clear.
3. Write `.flow/PRD.md` with: Goal, In scope, Out of scope, Done means (testable checks), Risks. Keep it under one page.
4. Use `writing-plans` to turn it into a short step plan in `.flow/PLAN.md`. Do not write code yet. Ask for confirmation.

## Guardrails (always)
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
