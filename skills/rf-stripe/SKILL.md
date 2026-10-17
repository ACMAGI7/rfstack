---
name: rf-stripe
description: Stripe payment-flow testing for checkout, webhooks, refunds, and renewals. Test mode only. Refuses any live secret key.
---

# rf-stripe

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

**Test mode only.** If a key, file, env var, or message starts with `sk_live`, stop at once. Do not call Stripe with it. Do not copy it into a file, a log, or the chat. Say only that a live key was refused. Use a test key (`sk_test_`) from the environment, never from a committed file.

## Step 0 (read-only)
Run `scripts/preflight.sh` (path lookup is in `/rf-new`). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Confirm the Stripe dashboard and CLI are in test mode before any trigger. Point at `stripe-best-practices` (stripe/ai, MIT). Do not copy it.

## Flows to prove
Use the Stripe CLI (`stripe listen`, `stripe trigger`) and test clocks for renewals. Each item needs a concrete result:
- Checkout in test mode completes, and the app records the test customer.
- The webhook checks `constructEvent` (the signature). A bad signature is rejected.
- A test refund moves the app's record to refunded.
- A test clock renewal creates the next invoice without a live charge.

No live cards, live customers, or live prices. Do not create live products.

## End
Pass or fail per flow, with the test id only (no keys). Show the cost, or say the cost is unknown. Do not merge, push, or deploy. Any fix is **change, branch-only, ask first.**
