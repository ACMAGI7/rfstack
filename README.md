# rfstack

A Claude Code plugin that packages a 4-step AI coding workflow:

1. **Plan** (`/flow-plan`) – research first (parallel subagents for bug context + repo conventions), then grill you into a one-page PRD (goal, scope, done-means) before any code.
2. **Review** (`/flow-review`) – adversarial review to simplify and de-bloat. Max 2 rounds.
3. **Eval** (`/flow-eval`) – a fresh-context `flow-evaluator` subagent scores the diff against a rubric (code quality, project fit, behavior, safety).
4. **Test + repair** (`/flow-test`) – run the app, Playwright e2e for UI changes, fail → fix → retest (max 3 loops), then hand to a human.

`/flow <task>` runs all four end to end. Artifacts go in `.flow/` in your project.

## Guardrails
- Work on a branch; never merge or push to `main` without the user's explicit OK.
- Max 2 review rounds, max 3 test-repair loops.
- No secrets in code.

## Rubric
Default in `rubric.md`. Override per project with `.claude/rubric.md`.

## Install
Dependencies (skills):
```bash
npx skills add DietrichGebert/ponytail
npx skills add q-qp-p/pstack
npx skills add kunchenguid/no-mistakes
npx skills add obra/superpowers
npx skills add mattpocock/skills   # grill-me
npx skills add vercel-labs/skills
```
Plugin:
```bash
claude plugin marketplace add longjumpguy/rfstack
claude plugin install rfstack@rfstack
```

## Credits
Built on these skills (all credit to their authors):
- [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail)
- [q-qp-p/pstack](https://github.com/q-qp-p/pstack)
- [kunchenguid/no-mistakes](https://github.com/kunchenguid/no-mistakes)
- [obra/superpowers](https://github.com/obra/superpowers)
- [mattpocock/skills](https://github.com/mattpocock/skills) (grill-me)
- [vercel-labs/skills](https://github.com/vercel-labs/skills)

## License
MIT
