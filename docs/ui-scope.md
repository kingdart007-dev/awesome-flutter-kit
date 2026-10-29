# Mobile UI Kit Scope and Roadmap

Awesome Flutter Kit is a mobile-first UI system for Android and iOS, not a bag of unrelated widgets. The goal is to make polished, accessible, responsive app experiences easier to assemble while keeping host apps in control of product logic, navigation, localization, and data.

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
- [ ] Typography roles and density rules
- [ ] Semantic color roles for success, warning, information, and destructive actions
- [ ] Icon sizing, stroke, alignment, and directional mirroring rules
- [ ] Elevation, borders, focus rings, and surface hierarchy
- [ ] Responsive layout and safe-area conventions

### 2. Core controls
- [x] Buttons, icon buttons, text fields
- [x] Checkbox and switch tiles
- [x] Cards, badges, dividers, section headers
- [ ] Segmented controls, radio tiles, sliders, steppers
- [ ] Search field, chips, selectable rows, toggles and choice groups
- [ ] Date/time pickers and selection sheets
- [ ] Password visibility, clear field, counter, prefix/suffix and input formatting patterns

### 3. Navigation and overlays
- [ ] App bars, large/collapsing headers, back affordances
- [ ] Bottom navigation, tab bars, navigation rail patterns for phone contexts where appropriate
- [ ] Dialogs, confirmation dialogs, action sheets, bottom sheets
- [ ] Toast/snackbar/banner notifications
- [ ] Menus, popovers, tooltips, contextual actions
- [ ] Route transitions, deep-link integration guidance, Android back and iOS swipe-back behavior

### 4. Content and feedback
- [x] Empty state, loading indicator, recoverable error state
- [ ] Skeletons/shimmer with reduced-motion fallback
- [ ] Success, warning, info, and destructive feedback
- [ ] Pull-to-refresh, pagination, load-more, retry patterns
- [ ] Progress bars, progress rings, step progress, status indicators
- [ ] Avatar, image placeholder, media tile, list item, grouped list
- [ ] Offline, permission denied, no results, and stale-data states

### 5. Motion and tactile feedback
- [x] Shared duration and easing tokens
- [x] Press feedback that respects reduced-motion preferences
- [ ] Shared page, modal, and content transitions
- [ ] Animated selection, expand/collapse, reorder, and list insert/remove
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
- [ ] Screenshot/golden strategy and example gallery
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
