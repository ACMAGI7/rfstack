# rf-design Layer 1: patterns and sources

## Code patterns by stack (basic; the render pass decides)
| Check | CSS / Tailwind | SwiftUI | Android (XML / Compose) | XAML (WinUI/WPF) |
|---|---|---|---|---|
| Left/right instead of start/end | `padding-left`, `margin-right`, `left:`, `text-align: left`; `pl-`, `mr-`, `left-` | leading/trailing by default; flag a forced `.layoutDirection(.leftToRight)` and directional arrows without `.flipsForRightToLeftLayoutDirection(true)` | `paddingLeft`, `layout_marginRight`, `gravity="left"`; Compose `absolutePadding` | `HorizontalAlignment="Left"` on text; no `FlowDirection` support |
| Fixed height on text | `height:` + `overflow: hidden`; `h-8 overflow-hidden`; `line-clamp-1`; `truncate` with no full-text route | `.frame(height:)` + `.lineLimit(1)` | `layout_height="40dp"` on a TextView; `maxLines="1"` without ellipsize; `Modifier.height()` | `Height=` on a TextBlock's container; `TextTrimming` without tooltip |
| Text that won't scale | `font-size` in px on body text (rem preferred); `text-[14px]` | `.font(.system(size:))` without `relativeTo:` | text in `dp` instead of `sp` | fixed `FontSize` ignoring text scaling |
| Animated layout | `transition: width/height/top/left/margin/padding/all`; `@keyframes` on those; `transition-all` | animating `.frame` size | `animateContentSize` on large trees; ValueAnimator on layout params | animating `Width`/`Height`/`Margin` |
| Focus removed | `outline: none`/`0` with no `:focus-visible` style; `outline-none` alone | `.focusable(false)` on a control | `focusable="false"` on a clickable | `FocusVisualStyle="{x:Null}"` |
| Heavy effects | `backdrop-filter`/`filter: blur()` over large or animated areas; very large `box-shadow` | `.blur()`, `.ultraThinMaterial` over full-screen animated views | `RenderEffect` blur on large views | `AcrylicBrush` on animated surfaces |
| Safe areas | fixed/sticky bottom bars without `env(safe-area-inset-bottom)`; no `viewport-fit=cover` | `.ignoresSafeArea()` on bars with controls | no `WindowInsets` handling with edge-to-edge | — |
| Number columns | no `tabular-nums`; hand-built `"$" + n`; `toFixed` for money display | string-built currency instead of `.formatted(.currency)` | `String.format` instead of `NumberFormat` | `ToString()` without culture |
Token files (JSON, CSS variables, Tailwind config): check the values themselves against Layer 1 (e.g. button height ÷ font, focus ring present, input font ≥ 16 px on phones).

## Sources for every number
| Number | Source |
|---|---|
| 24 × 24 CSS px target | WCAG 2.2 SC 2.5.8 Target Size (Minimum), AA |
| 44 × 44 pt touch target | Apple Human Interface Guidelines (advisory) |
| 48 × 48 dp touch target | Material Design accessibility (advisory) |
| 4.5:1 body, 3:1 large text | WCAG 2.2 SC 1.4.3 Contrast (Minimum); large = 18 pt (24 px) or 14 pt (≈18.66 px) bold |
| 3:1 outlines, icons, focus | WCAG 2.2 SC 1.4.11 Non-text Contrast |
| 200% text | WCAG 2.2 SC 1.4.4 Resize Text |
| 400% / 320 CSS px reflow | WCAG 2.2 SC 1.4.10 Reflow |
| Line 1.5, letter 0.12em, word 0.16em, paragraph 2em | WCAG 2.2 SC 1.4.12 Text Spacing |
| Focus visible; not hidden by sticky content | WCAG 2.2 SC 2.4.7; SC 2.4.11 Focus Not Obscured (Minimum) |
| Reduced motion | CSS `prefers-reduced-motion`; WCAG 2.2 SC 2.3.3 (AAA, advisory) |
| CJK body line height ≥ 1.5 | W3C JLREQ (line gap 50–100% of character size) |
| 45–75 characters per line | Typographic convention (Bringhurst), advisory |
| 30–40% translation growth | Common localisation guidance; W3C i18n notes short strings can grow far more |
| 16 px phone inputs | iOS Safari zooms on focus below 16 px (platform behaviour) |
| Clear space ≥ 0.25 × font; height ÷ font 1.75–3.5; icon gap 0.25–0.75 × font | *Starting default, tuned by trial* (no standard). Deliberately wide so only clear problems flag |
