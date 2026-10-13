---
description: Step 2 - adversarial review to simplify and de-bloat (max 2 rounds)
---
Review the diff vs the base branch (`git diff main...HEAD` plus uncommitted).
Round = run `ponytail-review` (cut code you don't need) and `pstack` principles (`correct`, `principle-subtract-before-you-add`, `principle-fix-root-causes`), then apply fixes. Use `no-mistakes` as the pre-push gate if configured.
Do at most 2 rounds total; record findings and what changed in `.flow/REVIEW.md`. If issues remain after round 2, list them and stop.

## Guardrails (always)
- Work on a feature branch (`flow/<slug>`). NEVER merge into or push to `main`/`master` without the user's explicit OK.
- Max 2 adversarial review rounds. Max 3 test-repair loops. Then stop and hand to the human.
- Never write secrets, keys or tokens into code, commits, or logs. Use env vars.
