# Project Instructions

## Frontend Design Rules

For all frontend UI work in this repository, follow the local Codex skill:

`/Users/ting/.codex/skills/redesign-skill/SKILL.md`

Use it as the source of truth for frontend redesign decisions unless the user gives a more specific visual direction.

## Required Workflow

Before redesigning or making non-trivial UI changes:

1. Scan the existing codebase and identify the framework, styling method, and current design patterns.
2. Diagnose typography, color, layout, interactivity, states, content, component patterns, iconography, and code quality.
3. Fix with the existing stack. Do not migrate frameworks or styling libraries unless explicitly requested.
4. Verify with a production build and, when practical, a desktop and mobile browser check.

Keep changes focused and reviewable. Do not rewrite the frontend from scratch when targeted upgrades are enough.

## Avoid

- Default Bootstrap look and unstyled scaffold screens.
- Generic white cards with default borders and shadows.
- Purple/blue AI-gradient aesthetics unless explicitly requested.
- Fully centered, symmetrical layouts by default.
- Three equal feature cards as the default composition.
- Placeholder latin text, generic names, or vague AI copy.
- Missing hover, active, focus, loading, empty, and error states.

## Prefer

- Strong typography with clear hierarchy.
- Intentional color palettes and consistent surfaces.
- Asymmetrical grids where they improve the page.
- Thin, expressive table lines instead of heavy default table borders.
- Custom loading, empty, and error states that match the product.
- Semantic HTML and accessible focus states.
- Responsive layouts that avoid horizontal overflow on mobile.

## Water Matters Visual Direction

Use this retro editorial admin direction unless the user provides a different one:

- Lime: `#ebffb2`
- Lavender: `#c4bbfd`
- Ink: `#000000`
- Retro pink: `#ff8fa3`
- Bold grotesk typography similar to editorial portfolio references.
- Chunky black type, expressive spacing, and light asymmetry.
- Loading states can reference a simple black outlined water cup motif.

## Water Matters Design System

Current frontend styling uses Tailwind CSS v4 with semantic classes composed in `frontend/src/styles/global.css` via `@theme`, `@layer base`, and `@layer components`. Keep Vue templates readable; prefer semantic classes such as `.auth-panel`, `.poster-card`, and `.btn-primary` over long utility strings in templates.

Use these visual rules unless the user gives a different direction:

- Major panels use a `4px` black border and a hard lower-right shadow.
- Inputs, buttons, badges, tables, active nav items, and small data cards use a `2px` black border.
- Dividers and table row lines use a `1px` black line.
- Hard shadows only offset down/right with no blur.
- Desktop major-panel shadows should read as a visible block, not just a thicker border.
- Disabled buttons use muted gray styling and no hard shadow.
- Login dashboard keeps `HYDRATE` and `TODAY` cards horizontally staggered.
- Login water cup uses the PNG asset, not an SVG redraw, and must stay responsive with safe mobile side spacing.
- Mobile outer cards should be inset enough that right/bottom shadows remain visible.
- Mobile hero title may be smaller than desktop to avoid crowding.

Navigation and button actions should follow the current arrow style:

- Main action buttons and sidebar nav links use slightly expanded letter spacing.
- Main action buttons and sidebar nav links show a thick right-arrow icon.
- Use a heavy, solid arrow shape similar to Font Awesome `arrow-right-long`, implemented as a CSS mask or equivalent icon treatment.
- The arrow inherits `currentColor` and nudges horizontally on hover.
- Icon-only social login buttons must not receive action arrows.
- Pagination is directional: previous uses a left arrow, next uses a right arrow.

## Preservation Rules

When redesigning existing screens, preserve these unless the user explicitly approves a change:

- URL structure and route behavior.
- API contracts and request payload fields.
- Form field ids and names.
- Primary headings and navigation labels.
- Existing working flows and validation behavior.
- Legal copy, if present.
