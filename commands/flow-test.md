---
description: Step 4 - run the app, e2e test, fail->fix->retest (max 3 loops)
---
1. Run the project's tests/lint/typecheck. Start the app.
2. For UI changes, write/run Playwright e2e covering every "Done means" item in `.flow/PRD.md`.
3. On failure: use `systematic-debugging`, fix the root cause, retest. Max 3 loops.
4. Use `verification-before-completion`. Write `.flow/TEST.md` (what ran, results, evidence). Commit on the branch, then hand to the user: summary, branch name, open issues. Do NOT merge or push to main.

## Guardrails (always)
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
