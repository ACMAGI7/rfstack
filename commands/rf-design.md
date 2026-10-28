---
description: Read-only design check for any website or app, any language. Layer 1 universal rules, Layer 2 the project's DESIGN.md. --all writes a baseline. --release checks three browsers.
argument-hint: "[--all] [--release]"
---
Task: $ARGUMENTS

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Follow the `rf-design` skill in this plugin (`skills/rf-design/SKILL.md`), with `$ARGUMENTS` as its flags. It reads `references/layer1.md` and, for Clueless repos only, `clueless-rules.md` from the same folder.

## Guardrails (always)
- Report only. Do not change source files, commit or push. Saving `.flow/design-baseline.json` with `--all` is a local file and is not committed.
- Never merge or push to `main` or `master` without an explicit yes in this chat.
- No secrets in files, commits, logs, or the report.
