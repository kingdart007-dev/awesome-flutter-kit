# Product-Agnostic Mobile UI Kit Scope and Roadmap

Awesome Flutter Kit is a product-agnostic mobile UI system for Android and iOS, not a fitness kit or a bag of unrelated widgets. It should support apps across commerce, productivity, communication, education, media, finance, health, and future categories without forcing any domain into the core. The goal is to make polished, accessible, responsive app experiences easier to assemble while keeping host apps in control of product logic, navigation, localization, and data.\n\n## Product coverage strategy\n\n- **Core first:** finish cross-product foundations, controls, forms, navigation, overlays, feedback, accessibility, localization, and testing.\n- **Patterns second:** build reusable workflows such as onboarding, search/filter, settings, paginated lists, and multi-step forms.\n- **Domain showcases third:** add isolated optional examples for commerce, chat, media, productivity, finance, education, and health only when there is a reusable need.\n- **No domain lock-in:** health/nutrition components remain optional examples and must not dictate core naming, dependencies, navigation, or visual identity.\n- **No pretend integrations:** UI patterns can provide interaction hooks, but API calls, AI, payments, camera access, storage, and other services belong to the host app unless explicitly designed as a separate package.\n

## Product vocabulary

- **Design system:** visual rules, tokens, interaction principles, accessibility, and usage guidance.
- **UI elements / primitives:** foundational visual pieces such as color, type, spacing, icons, and dividers.
- **UI components / widgets:** reusable building blocks such as buttons, fields, cards, badges, and list rows.
- **UI controls:** components users directly operate, such as switches, checkboxes, sliders, segmented controls, and pickers.
- **Patterns / flows:** combinations that solve common tasks, such as onboarding, search, forms, settings, and destructive confirmation.
- **Motion system:** shared timing, easing, transitions, tactile feedback, and reduced-motion behavior.
- **Interaction states:** idle, pressed, focused, selected, disabled, loading, success, warning, error, and empty.

## Coverage checklist

### 1. Design foundations
- [x] Neutral color, spacing, radius, and initial motion tokens
- [x] Light and dark theme factories
- [x] Typography roles and density rules
- [x] Semantic success, warning, and information colors; destructive feedback uses the theme error role
- [ ] Icon sizing, stroke, alignment, and directional mirroring rules
- [ ] Elevation, borders, focus rings, and surface hierarchy
- [ ] Responsive layout and safe-area conventions

### 2. Core controls
- [x] Buttons, icon buttons, text fields
- [x] Checkbox and switch tiles
- [x] Cards, badges, dividers, section headers
- [x] Segmented controls, radio tiles, sliders
- [x] Controlled numeric stepper
- [x] Selectable chips and choice groups
- [x] Search field
- [x] Numeric stepper and selectable rows
- [x] Compact controlled date selector; [ ] date/time pickers and selection sheets
- [ ] Password visibility, clear field, counter, prefix/suffix and input formatting patterns

### 3. Navigation and overlays
- [x] App bar with platform-default back affordance
- [ ] Large/collapsing headers and custom back patterns
- [x] Bottom navigation
- [x] Tab bar for related views; [ ] navigation rail patterns for phone contexts where appropriate
- [x] Confirmation dialogs
- [x] Bottom sheets; [ ] action-sheet presets
- [x] Snackbar notifications
- [ ] Toast/banner notifications
- [ ] Menus, popovers, tooltips, contextual actions
- [ ] Route transitions, deep-link integration guidance, Android back and iOS swipe-back behavior

### 4. Content and feedback
- [x] Empty state, loading indicator, recoverable error state
- [x] Static skeleton placeholders
- [ ] Animated shimmer with reduced-motion fallback
- [x] Success, warning, and info messages
- [ ] Destructive inline feedback patterns
- [ ] Pull-to-refresh, pagination, load-more, retry patterns
- [x] Linear progress bar with determinate/indeterminate semantics
- [x] Calorie-budget ring and macro progress; [ ] generic step progress and richer status indicators
- [x] Nutrition meal diary, editable food-estimate, and activity rows; [ ] avatar, image placeholder, media tile, grouped list
- [x] Controlled fasting-session and hydration summaries; [ ] offline, permission denied, no results, and stale-data states

### 5. Motion and tactile feedback
- [x] Shared duration and easing tokens
- [x] Press feedback that respects reduced-motion preferences
- [x] Shared content replacement fade with reduced-motion fallback; [ ] shared page and modal transitions
- [x] Accessible expand/collapse section with reduced-motion support; [ ] animated selection, reorder, and list insert/remove
- [ ] Haptic conventions by action importance
- [ ] Sound effects as explicit opt-in host-app behavior; never play surprise sounds by default

### 6. Accessibility and localization
- [ ] Arabic/English example app with runtime language switching
- [ ] Verified RTL layout and directional icon behavior
- [ ] Text scaling, semantics, focus order, screen-reader labels, contrast
- [ ] Reduced-motion checks and no animation-only meaning
- [ ] Keyboard/IME actions, focus handling, validation announcements
- [ ] Long Arabic/English strings and mixed-direction text tests

### 7. Engineering and quality
- [x] Public export entry point and widget tests for core primitives
- [x] CI formatting, analysis, and test workflow
- [x] Interactive example gallery app
- [ ] Screenshot/golden strategy
- [ ] API stability and migration policy
- [ ] Performance checks for animation-heavy widgets
- [ ] Contribution checklist for accessibility, RTL, theming, tests, and motion
- [ ] Device validation on current Android and iOS versions

## Principles

1. Motion explains state and relationships; it must not delay frequent actions.
2. Respect platform expectations instead of copying iOS behavior onto every Android interaction.
3. Prefer built-in Flutter primitives when they are robust; add abstractions only for repeated, meaningful patterns.
4. No forced sound, haptics, gradients, blur, or animation for decoration alone.
5. All public components must support theme changes, text scaling, disabled states where applicable, and localization supplied by the consuming app.
6. Keep the core dependency-free beyond Flutter unless a demonstrated need justifies a dependency.
7. Treat Android and iOS as the only supported platforms for this project's product scope.
