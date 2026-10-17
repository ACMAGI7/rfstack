---
name: rf-tax-tests
description: Known-answer tests for ACMAG tax figures, rounding, and Buddhist-calendar dates. Not legal advice.
---

# rf-tax-tests

**Not legal advice.** A wrong tax figure is a money and legal risk. These tests check the software against published examples. A lawyer or the accountant signs off on the rules. This skill does not.

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

No taxpayer names or id numbers in fixtures, logs, or commits. Use made-up numbers.

## Step 0 (read-only)
Run `scripts/preflight.sh` (path lookup is in `/rf-new`). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset.

## Tests
1. Known answers taken from Revenue Department worked examples. Record the example name and the expected baht. One assertion per example.
2. Rounding cases: half amounts, satang, and the boundary where a round changes the baht.
3. Buddhist-calendar dates: a form dated in BE must hit the same tax year as the CE date the code stores. Include 1 Jan and a leap day.

Point at Trail of Bits `property-based-testing` and `mutation-testing` (CC-BY-SA-4.0). Do not copy them. Use them as-is when they are installed: random inputs, then a planted bug the tests must notice.

Writing the tests is **change, branch-only, ask first.**

## End
How many examples passed, which failed, and the first wrong figure (expected vs actual). Show the cost, or say the cost is unknown. Do not merge or push.
