---
name: rf-design
description: Report-only design check for any website or app, any language, any stack. Spacing, proportions, alignment, zoom, narrow screens, contrast, motion. Never changes colours, fonts or brand.
---

# rf-design

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

Report the smallest fix, never redesign. This skill never edits app code, commits, pushes or opens a PR. No secrets in the report.

Usage: `/rf-design [--all] [--release]`. `--all` checks the whole app and writes a baseline. `--release` runs the render pass in all three browsers. Fixes change size, padding, gap, line height or layout only, never colours or fonts. Detail, per-stack patterns and sources: `references/layer1.md`.

## Step 0 (read-only)
Run `scripts/preflight.sh` (path lookup is in `/rf-new`). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. If it prints `missing:` or `stale plan:`, stop and show that line.

## 1. Pick the rules
- **Layer 1, universal:** always runs, on every repo, with or without a DESIGN.md. No Clueless or script-specific numbers.
- **Layer 2, project consistency:** the project's `DESIGN.md`, `docs/design/*`, or a rules file the README names. None, and the repo is Clueless (macOS, iPadOS, Windows, website `/clueless` pages): `clueless-rules.md`. None, and not Clueless: skip Layer 2 and write "No DESIGN.md, so project-consistency checks were skipped." Never apply Clueless rules to another product.
- Project numbers win over Layer 1 starting defaults; standards (WCAG AA) are floors the project can't lower. A missing value: "project must define". Never invent one.

## 2. Source drift
If the rules file pins a source sha, compare it with the source repo's latest commit. If it moved, the report's first line is `Source moved: pinned <sha> → latest <sha>. Rules may be stale.`

## 3. How to check
1. **Code pass (fast, first):** read changed UI files in any stack: CSS, Tailwind classes, token files, JSX/TSX, SwiftUI, Android XML/Compose, XAML (basic patterns in references). `--all` = whole app.
2. **Render pass (main check, §6):** screenshots and measurements. Code reading can't see real ink height, fallback fonts, zoom or overlap; the render pass decides.

## 4. Layer 1: universal rules
Labels marked *starting default, tuned by trial* have no public standard; everything else cites one (references §Sources).

**Proportion and clear space** (labelled controls: buttons, chips, tabs, fields, selects)
- Clear space between the label's real ink (highest mark to lowest mark of the script that renders, not the font size) and the control edge: ≥ 0.25 × font size, top and bottom (*starting default*).
- Horizontal padding ≥ vertical clear space; label optically centred (*general principle*).
- Control height ÷ font size within 1.75 – 3.5 (*starting default*). Icon-to-label gap 0.25 – 0.75 × font size (*starting default*).
- Across sm → md → lg → xl, height, padding, icon size and gap never shrink (*general principle*).
- Corners: same-sized buttons share one corner size; a nested shape's radius = outer radius − padding (*general principle*). Corner shape itself is Layer 2.
- Proximity: space inside a group < space between groups (*general principle*).
- Alignment: icons, labels and controls in a row share one centre line or baseline; flag one-off nudges (`margin-top: 1px`, `top: -2px`).

**Scripts and languages**
- Marks above or below (Thai, Vietnamese, Hindi/Devanagari, Arabic, others) never touch or clip at any edge. Flag fixed heights + `overflow: hidden`, line clamps, `line-height: 1` or a px line height near the font size, and letter-spacing on these scripts.
- Writing direction: use start/end (logical properties: `padding-inline-start`, `margin-inline-end`, `inset-inline`, `text-align: start`; `ps-`/`pe-` in Tailwind; leading/trailing natively). Flag left/right. Under `dir="rtl"`, padding, directional icons and arrows mirror; logos, media controls and numbers don't.
- Translation growth: labels can grow 30–40% (short labels more). No clipping; each label wraps, or truncates with the full text reachable (tooltip, title or accessible name).
- Chinese, Japanese, Korean: no `word-break: break-all` on prose; Korean `word-break: keep-all`; `line-break: strict` for Japanese; line height ≥ 1.5 for body text (W3C JLREQ). No letter-spacing.
- Numbers, dates, currency: format by locale (`Intl`, platform formatters), never hand-built strings; `font-variant-numeric: tabular-nums` in tables and totals; number columns end-aligned so they stay aligned when the format changes.
- Fallback fonts: for each script the app ships, the font stack has a font that covers it; measure the font that actually renders (its metrics differ). Flag stacks with no fallback for a shipped script.

**Reading and zoom**
- Reading width ≈ 45–75 characters per line for Latin prose; fewer for Chinese and Japanese (advisory).
- Text zoom 200% (WCAG 1.4.4) and phone text-size settings: layout holds; no fixed heights on text containers; text sizes in `rem`/`sp`/Dynamic Type, not fixed px/pt where the platform scales.
- Page zoom 400% = reflow at 320 CSS px (WCAG 1.4.10): no horizontal scroll or clipping except tables, maps, code.
- Text-spacing override (WCAG 1.4.12: line height 1.5, letter 0.12em, word 0.16em, paragraph 2em): nothing clips.
- Phone text inputs ≥ 16 px, or iPhone Safari zooms in on focus (platform behaviour).

**Targets, contrast, safe areas**
- Tap targets: ≥ 24 × 24 CSS px everywhere (WCAG 2.5.8). Touch layouts: 44 × 44 pt (Apple HIG) / 48 × 48 dp (Material), advisory for every project.
- Contrast (WCAG 1.4.3 / 1.4.11): body text 4.5:1; large text (≥ 24 px, or ≥ 18.66 px bold) 3:1; control outlines, focus rings and icons 3:1. Check light, dark and forced-colors (Windows high contrast); outlines and focus must not vanish there. Flag only; never pick colours.
- Safe areas: fixed bars, toolbars and buttons clear notches, rounded corners and the home indicator (`env(safe-area-inset-*)` with `viewport-fit=cover`; native safe-area insets).

**States and layering**
- Every pressable has a visible focus style (WCAG 2.4.7); flag `outline: none` with no replacement. A sticky bar or popup must not hide the focused item (WCAG 2.4.11).
- Disabled and loading don't change size; content swaps hold width.
- Fixed or sticky bars, banners, toasts, cookie bars and popups never cover a clickable item at any size.
- Hover is never the only way to reach something; hover effects sit inside `@media (hover: hover)`.

**Motion and cost**
- Only `transform` and `opacity` animate; flag animated width, height, top/left/right/bottom, margin, padding, and `transition: all`.
- New motion has a reduced-motion path (`prefers-reduced-motion`, platform setting).
- Heavy effects: flag large `blur`/`backdrop-filter` and big shadows on large or animated areas; suggest a lighter version that looks the same (smaller radius, static image, effect on a smaller layer) (*general principle*).

## 5. Layer 2: project consistency (needs rules)
- Spacing scale, z-index ladder, dialog/sheet/toast widths, reserved bands (window buttons).
- Control sizes and ratios: the project's tables (Clueless: the ratios in clueless-rules.md §Proportion).
- Corner shape, durations, easing, focus ring, disabled value, min button width (else "project must define"), script line heights.
- Run the project's own gates if present (lint, stylelint, design-debt, visual specs).

## 6. Render pass (main check; phase 2, not run yet)
- **Browsers:** Chromium on every UI PR; Chromium, WebKit (Safari) and Firefox on release PRs (`--release`), for cost. Native apps: simulator or emulator screenshots.
- **Sizes:** 1280 × 800, tablet portrait and landscape, 390 px phone, 320 px, 200% text zoom, 400% page zoom, phone largest text size; LINE in-app browser on a phone for sites shared through LINE.
- **Modes:** light, dark, forced-colors, `dir="rtl"`, a pseudo-locale +40% longer, and sample strings in each shipped script (plus Thai, Vietnamese, Hindi, Arabic, CJK if the app accepts user text).
- **States:** happy path, empty, error, loading, very long name, broken image.
- **Measure:** ink-to-edge clear space, tap target sizes, centre-line alignment, overflow, contrast. Overlap test (ACMAGI7/Vercel-website PR #156 method): for every link and button, the element at its centre point must be the item itself or inside it. That PR has no test file; rebuild it as a Playwright check.

## 7. Baseline mode (`--all`)
- Count violations per rule across the whole app into `.flow/design-baseline.json`: `{ "source_sha": "...", "date": "...", "counts": { "<rule>": n } }`. Local only; don't commit.
- Later runs fail only if a count goes up; counts that went down are reported so the baseline can be lowered. No baseline: report, don't fail.

## 8. Report
```
Source: <rules file> @ <sha>, or "No DESIGN.md, so project-consistency checks were skipped."  (drift line first if it moved)
| file:line or screen@size | Layer | Rule | Measured | Allowed | Fix |
Baseline: <rule> was n, now m
Not checked: ...   Risk: ...
```
Mark known exceptions from the rules file. [NEW] rules are advice on shipped platforms. Starting defaults are warnings, not failures, until tuned. Suggest the one-line fix; a human applies it. Show the cost, or say the cost is unknown.

## Open (needs the designer)
- Icon sizes per control and line spacing for control labels aren't set as rules in the Clueless source.
- Starting defaults (clear space, height ÷ font, icon gap) need tuning on 2–3 real trials.
