# Design System

The kit uses a premium-minimal, monochrome foundation. It should feel calm and deliberate rather than decorated.

## Visual language

- **Palette:** neutral white, near-black, charcoal, and warm grays.
- **Surfaces:** prefer open space and subtle dividers. Avoid heavy elevation, persistent gradients, glow, and noisy decoration.
- **Shape:** use the shared radius scale; cards group content only when grouping improves comprehension.
- **Typography:** establish hierarchy through size, weight, and spacing before color.
- **Motion:** keep transitions short, purposeful, interruptible, and respectful of reduced-motion settings.
- **Icons:** use consistent icon families; do not use emoji as product UI icons.

## Tokens

### Spacing

| Token | Logical pixels |
| --- | ---: |
| xxs | 4 |
| xs | 8 |
| sm | 12 |
| md | 16 |
| lg | 24 |
| xl | 32 |
| xxl | 48 |

### Radius

| Token | Logical pixels |
| --- | ---: |
| sm | 8 |
| md | 12 |
| lg | 16 |
| xl | 24 |
| pill | 999 |

### Typography

`AfkTypography` provides shared roles: page title (24 px), section title (20 px), item title (16 px), body (14 px), and label (14 px semibold). The theme applies these roles to the corresponding Material text styles while preserving a host-customizable theme.

### Color

Use `AfkColors` for neutral palette values and shared semantic feedback colors. Components should normally use `Theme.of(context).colorScheme` for host-customizable surfaces and foregrounds. Semantic success and warning tokens provide matched light/dark pairs; avoid hard-coding separate feedback colors in individual widgets.

## Motion and interaction

Use `AfkMotion` for shared durations and easing rather than choosing arbitrary timings per component.  `AfkPressable` adds a subtle scale response for custom content, while respecting `MediaQuery.disableAnimations`. `AfkContentSwitcher` provides a restrained fade when replacing keyed content and becomes immediate when reduced motion is requested. Keep feedback quick and interruptible; do not use animation to delay an action. The host app should opt into haptics or sound only when appropriate to the action and user settings.

## Navigation

Use `AfkAppBar` for a consistent, low-elevation top bar and `AfkBottomNavigationBar` for a small set of top-level destinations. Use `AfkTabBar` for closely related sibling views, not top-level app navigation. Pair it with Flutter's `DefaultTabController` or an explicit `TabController` and a `TabBarView`. Keep the selected index controlled by the app's navigation state, localize destination labels, and preserve platform back behavior in the host app. Avoid using bottom navigation for transient actions or deep hierarchies.

## Selection controls

Use `AfkStepper` for bounded integer adjustments with clear increment/decrement actions. The host app supplies localized tooltips and the displayed value format. Use `AfkSegmentedControl` for two or more mutually exclusive, compact choices; `AfkChoiceChip` for optional filters or compact toggles; and `AfkSlider` for bounded numeric values. Keep selection controlled by the host app, localize labels there, and avoid segmented controls for long lists or complex content.

## Dialogs and transient feedback

Use `AfkConfirmDialog.show` for decisions that need explicit confirmation, including a destructive style when relevant. The host app supplies localized strings and decides when the action is appropriate. Use `AfkSnackBar.show` for brief, non-blocking feedback; do not rely on a snackbar alone for critical errors or actions requiring a decision.

## Loading and status feedback

Use `AfkProgressBar` for determinate or indeterminate work and expose a concise label when progress needs context. Use `AfkSkeleton` to preserve layout while content loads; keep it decorative and exclude it from the accessibility tree. Use `AfkStatusMessage` for concise success, information, or caution feedback. Reserve urgent or blocking problems for the recoverable error state or a platform-appropriate dialog.

## Search

Use `AfkSearchField` for query-driven filtering or lookup. The host app owns the controller and search behavior; the component only reports edits and provides an accessible clear action. Supply localized hint and clear-tooltip text, debounce expensive searches in the host layer, and preserve the query when returning from a result if that matches the task flow.

## Lists and sheets

Use `AfkListTile` for simple, consistent rows with optional leading/trailing content and supporting text. Use `AfkBottomSheet.show` for modal tasks that should remain in context; prefer a scrollable child for long content and let the host application own the form state and translated copy.

## Form fields

Use `AfkTextField` for consistent labels, hints, helper/error messages, focus borders, and disabled states. Pass localized copy from the host app. Prefer semantic keyboard types and text input actions, and avoid fixed-height wrappers so validation messages and text scaling can expand naturally.

## Surfaces and status

Use `AfkCard` to group related content only when grouping improves scanning; it defaults to a quiet border and no elevation, and supports an optional tap action. Use `AfkBadge` for short status or metadata labels, not long messages. `AfkIconButton` requires a tooltip and preserves a 48 logical-pixel touch target. Use `AfkLoadingIndicator` for pending work and `AfkErrorState` when the user needs a clear explanation or a retry action. Error and loading copy stays supplied by the host app so localization remains in one place.

## Selection controls

Use `AfkCheckboxTile` for independent on/off choices and `AfkSwitchTile` for settings that take effect immediately. Both support an optional subtitle, standard full-row interaction, and a disabled state. Keep labels concise, pass localized strings from the host app, and use the callback to update state in the host application rather than introducing hidden state into the component.

## Accessibility and localization

- Respect system text scaling; avoid fixed-height text containers.
- Use semantic labels and clear enabled/disabled states.
- Maintain readable contrast in both themes; never communicate state through color alone.
- Use layout primitives that naturally adapt to RTL.
- Keep user-facing strings supplied by the host app so its localization system remains the source of truth.
- Mirror directional icons only when their meaning is directional.

## Adding a component

Before adding a shared widget, verify that it represents a repeated pattern. Give it a narrow API, predictable defaults, both-theme support, disabled/loading/error states where relevant, and tests for meaningful behavior.


## Disclosure and progressive detail

Use `AfkExpandableSection` to keep secondary settings or nutrients available without giving them the same visual priority as the main task. Supply localized expand/collapse tooltips when useful; it exposes expanded semantics, reports state changes, and respects reduced-motion preferences.

## Nutrition dashboard patterns

The optional nutrition-oriented primitives are useful for photo-first trackers and similar health products:

- `AfkDateSelector` provides a controlled horizontal date strip; the host app supplies localized dates and calendar semantics.
- `AfkCalorieRing` summarizes intake against a daily budget. It accepts estimated values from the host app and exposes a semantic value.
- `AfkMacroProgress` compares a nutrient value with its target using a restrained progress track.
- `AfkMealEntryTile` gives meal history a consistent title, detail line, and calorie summary.
- `AfkFoodScanCard` provides a prominent entry point for a host-owned camera/AI flow.
- `AfkFoodEstimateTile` presents an estimated food, portion, and calorie value with an explicit edit action before saving. It does not request camera access or pretend to analyze food.
- `AfkHydrationTracker` shows water intake and emits a controlled increment callback; persistence and goal policy stay in the host app.
- `AfkFastingCard` presents a host-owned fasting session without implementing a hidden timer.
- `AfkActivityEntryTile` displays activity duration and estimated burned calories.

These patterns take inspiration from the broader UX principles visible in Cal AI—fast photo-first logging, glanceable calorie and macro summaries, editable meal records, and clear hydration tracking—without copying its brand or implying that this UI kit includes an AI model, food database, or health-data integration.
