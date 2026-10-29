# Component Catalog and Product Coverage

Awesome Flutter Kit is a general-purpose Flutter UI foundation. It is not a fitness, nutrition, commerce, or dashboard-only library.

This catalog defines the intended coverage and the rules for deciding what belongs in the shared core.

## 1. Shared core — useful across most apps

### Visual foundation
- Color roles, typography, spacing, shape, borders, surfaces, elevation, motion, icon sizing.
- Light, dark, and system theme behavior.
- Responsive mobile layouts, safe areas, keyboard/IME handling.

### Navigation and structure
- App bars, back affordances, bottom navigation, tabs, modal sheets, dialogs.
- Page/container patterns, section headers, list groups, detail layouts.
- Navigation remains host-app-owned; the kit provides visual building blocks and guidance.

### Actions and controls
- Buttons, icon buttons, text fields, search, checkboxes, switches, radio options, chips, segmented controls, sliders, steppers.
- Menus, selection sheets, date/time selection patterns, password visibility, input formatting and validation.

### Content and feedback
- List rows, cards, badges, avatars, image placeholders, separators.
- Loading, skeleton, empty, no-results, error/retry, offline, permission, success and warning states.
- Pull-to-refresh, pagination, load-more, undo and destructive-action patterns.

### Accessibility and internationalization
- Semantics, focus and reading order, large text, contrast, reduced motion, keyboard support.
- RTL-safe layout and directional icons, localization-friendly APIs, mixed-direction text guidance.

## 2. Common workflow patterns

Build these as composed patterns when they solve recurring tasks without taking ownership of product logic:

- Onboarding and multi-step flows.
- Forms, validation, review and confirmation.
- Search, filtering, sorting and selection.
- Settings and preference screens.
- Lists, detail pages, pagination and refresh.
- Profile and account presentation (without forcing authentication).
- Notifications, banners, transient feedback and recovery.
- Dashboard/layout primitives that do not assume a particular metric or business domain.

## 3. Optional domain pattern families

These are independent showcases or clearly grouped optional modules, never mandatory dependencies of the core:

| Domain | Potential reusable patterns |
| --- | --- |
| Commerce | Product tiles, variants, cart rows, quantity controls, price presentation, checkout steps |
| Messaging | Message bubbles, conversation rows, composer, attachment previews, typing/read states |
| Media | Image/video tiles, galleries, playback controls, upload progress |
| Productivity | Task rows, priorities, filters, boards, calendar agenda, progress |
| Finance | Balance summaries, transaction rows, masked values, budget categories |
| Education | Course cards, lesson progress, quiz choices, learning paths |
| Health/nutrition | Calorie and nutrient summaries, food review, hydration, activity rows |
| Maps/travel | Place rows, itinerary stops, map overlays and route summaries |
| Analytics/admin | Metric tiles, chart containers, filter bars, tables adapted for mobile |
| Support/content | Article rows, FAQ disclosure, help/contact entry points |

These are candidate families, not a promise that every item already exists. Implement a family only when its APIs, accessibility, theme behavior, localization needs, tests, and maintenance cost are understood.

## 4. Rules for adding a component

Before a new shared component is accepted, ask:

1. Is this a repeated UI pattern rather than one screen's custom composition?
2. Is the API narrow, controlled, and understandable?
3. Can it be used by unrelated app categories?
4. Are text, data, formatting, navigation, persistence and service behavior supplied by the host app where appropriate?
5. Does it support both themes, large text, RTL and accessibility semantics?
6. Are disabled, loading, empty, error, and reduced-motion states handled where relevant?
7. Are tests added for behavior and edge cases?
8. Does it add a dependency or abstraction that is actually justified?

If it is domain-specific, group it under a clear domain family and keep the core free of domain assumptions.

## 5. Explicit non-goals for the core

- No forced fitness or nutrition data models.
- No mandatory authentication, backend, analytics, subscriptions, payments, AI, or persistence.
- No single navigation architecture imposed on all host apps.
- No fake integrations that merely look functional.
- No domain-specific terminology in generic APIs.
- No visual novelty that compromises clarity, performance, accessibility, or native conventions.
