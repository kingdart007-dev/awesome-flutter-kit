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

### Color

Use `AfkColors` for neutral palette values. Components should normally use `Theme.of(context).colorScheme` so host apps can customize the kit without rewriting widgets.

## Form fields

Use `AfkTextField` for consistent labels, hints, helper/error messages, focus borders, and disabled states. Pass localized copy from the host app. Prefer semantic keyboard types and text input actions, and avoid fixed-height wrappers so validation messages and text scaling can expand naturally.

## Accessibility and localization

- Respect system text scaling; avoid fixed-height text containers.
- Use semantic labels and clear enabled/disabled states.
- Maintain readable contrast in both themes; never communicate state through color alone.
- Use layout primitives that naturally adapt to RTL.
- Keep user-facing strings supplied by the host app so its localization system remains the source of truth.
- Mirror directional icons only when their meaning is directional.

## Adding a component

Before adding a shared widget, verify that it represents a repeated pattern. Give it a narrow API, predictable defaults, both-theme support, disabled/loading/error states where relevant, and tests for meaningful behavior.
