---
name: rf-privacy
description: Map personal data, check logs and retention, and compare the app's privacy label with what it collects. Not legal advice.
---

# rf-privacy

**Not legal advice.** Thailand's PDPA, GDPR, and Apple's privacy labels need a lawyer to sign off. This skill only lists what the software does.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Do not copy real personal data into the report. Describe the field ("taxpayer id"), not a person's value.

## Step 0 (read-only)
Run `scripts/preflight.sh` (path lookup is in `/rf-new`). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset.

## Checks
1. Map where personal data goes: form, database, log, analytics, crash report, backup, third party. One row per destination, with `file:line`.
2. Logs and error reports must not contain taxpayer ids, names, emails, or tokens. A hit needs a concrete line.
3. Say how long each store keeps the data, or "not set" if the code never deletes it.
4. Compare `PrivacyInfo.xcprivacy` and the App Store privacy answers with what the app actually collects. List mismatches. Apple rejects a wrong label.

No concrete case, no finding. Do not invent a legal conclusion.

Any change to a privacy file or a log line is **change, branch-only, ask first.**

## End
The map, the mismatches, and the sentence "not legal advice". Show the cost, or say the cost is unknown. Do not merge, push, or ship.
