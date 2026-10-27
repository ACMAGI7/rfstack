# CHANGELOG — rfstack

**Document ID:** WP-CL-RFSTACK-001
**Project:** rfstack — Refinery.co
**Repository:** ACMAGI7/rfstack
**Standard:** ISO/IEC 29110-5-1-2 (Basic Profile)

> A Claude Code plugin for a short coding workflow: Plan, Review, Eval, Test. Version numbers here follow
> `.claude-plugin/plugin.json`. The repository had no changelog for its first four commits; both entries
> below were written retroactively on 2026-10-27, when this record was opened.

---

## [0.2.0] — 2026-10-17

**Release type:** Feature — lean `/rf-*` commands, a preflight and short skills (PR #1)
**Implemented by:** Chase (`longjumpguy`), with Cursor agent

### Added

| ID | Change | Commit |
|----|--------|--------|
| NF-2 | **Three lean commands on top of `/flow`:** `/rf-new` starts work on an `rf/<slug>` branch; `/rf-audit` is a read-only quality check (`--diff <base>` looks only at the branch's changes); `/rf-scan` runs scanners first (gitleaks, osv-scanner, semgrep, Supabase advisors), then a short AI review (`--partial` continues when a scanner is not installed). `--deep` turns off the lean mode. | `433cbbe` (PR #1) |
| NF-3 | **A read-only preflight and a ponytail backup hook.** | `433cbbe` (PR #1) |
| NF-4 | **Short skills for release, auth, Stripe, tax and privacy work.** | `433cbbe` (PR #1) |

### Changed

| ID | Change | Commit |
|----|--------|--------|
| IR-2 | Install links point at `ACMAGI7/rfstack` and `michael-denyer/pstack-claude`. | `433cbbe` (PR #1) |

### Notes

- Still open and not part of this entry: PR #2 (preflight accepts `codex_reviews` disabled), PR #3 (`rf-design`, a universal design check), PR #4 (pipeline kit: client intake, PR self-test loop, single human gate).

### ISO 29110 Artefacts

- Full commit SHA: `433cbbe90655b9c16556f0170bfbb55009650dbd`
- Branch: `main` (PR #1, merged 2026-10-17)
- Change requests: none · Risks: none · Issues closed: none (no issue was referenced)
- Implemented by: Chase (`longjumpguy`), with Cursor agent
- Logged by: refinery-ops, 2026-10-27

## [0.1.0] — 2026-10-13

**Release type:** Initial public release
**Implemented by:** Chase (`longjumpguy`)

### Added

| ID | Change | Commit |
|----|--------|--------|
| NF-1 | **The four-step `/flow` workflow:** `/flow-plan` (research first, then a one-page PRD), `/flow-review` (adversarial review to simplify, at most 2 rounds), `/flow-eval` (a fresh-context `flow-evaluator` scores the diff against `rubric.md`), `/flow-test` (run, fail, fix, retest, at most 3 loops, then hand to a human). `/flow <task>` runs all four; artefacts go in `.flow/`. | `92e3b6b` |
| IR-1 | **README poster** added, then made black and white. | `0c88774`, `f344c43` |

### ISO 29110 Artefacts

- Full commit SHAs: `92e3b6bedea5293ef523cb281c028664103330e1`, `0c88774bd0fe32fc5acbe7f96a631824cc7df7e1`, `f344c43372c9c1eaae805d309a430e768eb9b159`
- Branch: `main`
- Change requests: none · Risks: none · Issues closed: none
- Logged by: refinery-ops, record opened 2026-10-27
