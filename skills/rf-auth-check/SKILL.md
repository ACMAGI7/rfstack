---
name: rf-auth-check
description: Walk sign-in from start to finish on each platform. Test accounts only.
---

# rf-auth-check

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Test accounts only. If the only account on offer is a real customer, stop. Do not type a production password. No secrets in files or logs.

## Step 0 (read-only)
Run `scripts/preflight.sh` (path lookup is in `/rf-new`). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Read the repo's auth config before you click anything.

## Walk each platform that this repo ships
Mac, Windows, iPad, and web. For each one, check the whole path, not one setting in isolation:
- Google (or the provider) client id matches that platform.
- The return address after sign-in is on the allow list, including the scheme the app actually uses.
- Supabase URL, anon key, and redirect allow list match. Site URL is not a stale localhost unless this is a local run.
- The session lands in the app, the signed-in screen shows the test user, and sign-out clears it.

Use Playwright (`microsoft/playwright-mcp`, Apache-2.0) for the web view. Point at it. Do not copy it.

A failure names the platform, the step, and the setting that disagreed (`file:line` or the config screen). No concrete case, no finding.

## End
A short list: platform, pass or fail, the first broken step. Show the cost, or say the cost is unknown. Do not merge, push, or deploy. Any fix is **change, branch-only, ask first.**
