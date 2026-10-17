# Clueless rules for rf-design

Source: `ACMAGI7/Clueless-Design-System-Universal/CLUELESS-DESIGN-RULES.md`, v1.0 (2026-10-13).
Pinned sha: `e52b1b5821f3a866546b61a5a1ed146ea6c5dfaf`
Numbers are copied verbatim; the source wins on any difference. macOS is the reference. **[NEW]** = proposal, not shipped (all iPad Touch values). Gates: `npm run check` (stylelint, ESLint, design-debt) and `npm run test:visual` (density, home-board, notices, settings, a11y).

## Spacing (§5.1)
Allowed px: **2, 4, 6, 8, 12, 16, 20, 24, 32, 40, 48, 80** (`--sp-N`).
Roles: 2/6 icon-to-label, badge-to-edge · 8 inner stacks · 12 dense card padding · 16 between controls · 24 between groups, Settings page padding · 40 screen padding · 48 between blocks · 80 page margins. 4/20/32: no stated role.
- MUST in `proto/ui`: multiple of 4, or 2 or 6. Snap 10, 14, 18. No half-step tokens. Exception: Home's 10 px gap and gutter; `styles/` ungated.

## Placement (§5.2–5.4, §17)
| Thing | Value |
|---|---|
| Screen padding | Std `clamp(16px, 2vw, 24px)`; Large pt `clamp(16px, 2.2vw, 26px)`, pr/pb/pl `clamp(20px, 3.4vw, 40px)` |
| Reading column | `max-width: min(var(--ui-maxw), 100%)`, 1180 |
| Settings | one 720 px column |
| Dialog sm/md/lg/xl | 380/440/470/560; max-width 92% (xl 94%); <560 px viewport `100vw - 32px`; max-height 86vh |
| Bottom sheet | maxWidth 520, max-height 80vh; full width <560 px |
| Toast | `min(520px, 100% - 32px)`, min-height 44, centred on content column; max 3 |
| Tooltip | 64–260 wide, 32 tall |
| Window default / min | 1180 × 760 / 920 × 600 |
| Traffic lights (macOS) | x 13–70, y 12–32; insets 84 / 36; no control in the band |
| Rail / collapsed | Std 220 / 44; Large 240 / 44 |
| Tab strip / chrome | Std 36 / 38; Large 44 / 46 |
| Page well | 8 left (0 beside Ask list), 10 right, bottom, below strip |
| Home cell | 120 × 96, gap 10; place by cell; default board fits 1280 × 800 with no scroll |
- Nothing floats over screen content (DEC 0.5); notices dock in the rail footer.
- z-index: a rung 0, 1, 10, 30, 40, 55, 60, 70, 80, 90, 100, or rung ± n.
- iPad [NEW]: padding adds `env(safe-area-inset-*)`. Windows: reserve ~140 px top right, left inset 0. Website: container 1180 (today 1160); no horizontal overflow at 390 px.

## Motion (§10)
Easing: `--ease` `cubic-bezier(.2,.7,.3,1)` all UI · `--ease-in` `cubic-bezier(.4,0,1,1)` exits only · `--ease-spring` `cubic-bezier(.3,1.5,.5,1)` playful only, never a control, panel or screen.
Durations ms: 120 press · 160 every exit · 180 default hover/fill, rail, scrim · 220 menu in, toast out · 240 tooltip in · 300 create-menu · 350 base, pop, dialog in, toast in · 380 sheet · 400 cover · 450 screen in (rise 14 px, Glass off) · 700 hero · 1200 intro.
- No literal `cubic-bezier(` or `NNNms` outside `tokens.css`. Exit faster than enter. Delays use `fill-mode: both`.
- Press .97; hover lift Button -1px, card -2px, inside `@media (hover: hover)`. Stagger 80 ms. Tooltip at 450 ms.
- Reduce motion (`data-motion="reduce"` and OS): durations 0ms, press 1, lift 0px, global damper; keep colour and ring. Exception: LatticeLoader pulse.
- Moving wallpapers rest when hidden; Home shader 12 fps.

## Controls (§6, §7, §11, §13.4)
Button heights Std / Large / Touch [NEW]: sm 24/34/44 · md 28/40/44 · lg 32/44/48 · xl 36/48/52.
Padding-x Std/Large: 12/18 · 14/20 · 16/22 · 20/28. Font: 12/13 · 13/13 · 13/14 · 14/15. Icon gap: 5/7 · 6/8 · 7/9 · 8/9.
| Control | Standard | Touch [NEW] |
|---|---|---|
| IconButton; glyph | 24/28/32 (Large 26/34/40); 14/16/18 | 44/44/48; 18/20/24 |
| Chip sm / md | 20 / 24 (Large md 26) | 28 / 32, 44 hit |
| Segmented, ToolbarGroup item | 32 × 28 | 44 × 44 |
| Switch | 34 × 20, 24 hit | 40 × 24, 44 hit |
| Checkbox / Radio | 22 / 14 | 24, row 44 hit |
| Slider | 26 high, 22 thumb | 44 high, 28 thumb |
| Menu row; Settings row | ~24 (28 compact); min 44 | 44; 56 |
| Tab ×; Dialog × | 20 (24 hit); 30 | 44 hit; 44 |
- Pressables are pills (`--r-control` 999); containers squircles on 4, 8, 12, 14, 16, 18, 22, 28 (Large card 20, card-lg 24, panel 28, surface 32); chips 99.
- Size via `size`/`variant`; never set `height` or `border-radius` on a Button. Button, Field, Select in a row share a height.
- Hit: ≥ 24 × 24 px desktop, `::before` slop (1 px border: `inset: -3px -1px`). Touch [NEW]: 44 × 44 pt, 8 pt apart, nothing hover-only.
- Website: app UI at Standard; 50–52 px CTAs become xl (36); marketing CTAs may be 48+, 44 min on a phone.

## States (§11)
- Focus: 2 px `--tint` ring at 2 px offset, keyboard only; `.cl-focus-inset` where an ancestor clips. Known exception: Light looks, 1.1–1.4:1 (C5). `outline: none` without a replacement fails design-debt.
- Disabled: opacity .45. Loading (Button): three 5 px dots, holds the width, implies disabled. 1 px border on every variant so heights match.
- Truncation: `Text truncate` is one ellipsis line; Chip, ListRow and TaskRow titles ellipsis. Min button width: not defined (project must define).

## Thai (§4.4, §11) — all [NEW]
- Thai line height = max(Latin, `ceil(size × k)`), k 1.5 up to 17 px, 1.4 from 22 px, 1.35 from 30 px; set under `:lang(th)`. E.g. meta 14 → 18, body 18 → 20 (Std).
- Control labels `line-height: 1.4` (not 1); Chip `overflow: hidden` → `visible`, sm grows to 22. Thai ≥ 12 px in a control, Tooltip 13. No letter-spacing on Thai. Truncated lines use the Thai line height.
- Known gap (C53): Button and Chip `line-height: 1`, Tabs 1.2, menu items and tooltips 16 px, toasts 1.35, badges 1.4.

## Proportion (derived from the Button table, Standard and Large, sm–xl)
f = font size; clearance = (height − f) / 2, with `line-height: 1` and the 1 px border inside the height.
| Ratio | Range |
|---|---|
| Height ÷ font | 2.00 – 3.20 |
| Clearance ÷ font | 0.50 – 1.10 |
| Same, Thai line box 1.4 × f [NEW] | ≥ 0.30 |
| Padding-x ÷ font | 1.00 – 1.87 |
| Padding-x ÷ clearance | 1.47 – 2.00 |
| Icon gap ÷ font | 0.42 – 0.64 |
| IconButton glyph ÷ height | 0.45 – 0.58 |
Proximity: 16 between controls, 24 between groups, 48 between blocks (§5.1). Corner shape: pill, `--r-control` 999 (§7.2).
