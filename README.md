# Awesome Flutter Kit

A polished, reusable Flutter foundation and UI toolkit for Android and iOS. Built around a quiet monochrome visual language, predictable APIs, accessibility, and maintainable defaults.

> **Status:** Early foundation — APIs may evolve before the first stable release.

## What is included

- Monochrome design tokens for color, spacing, and corner radius
- Light and dark theme factories
- Reusable button with filled, outlined, text, disabled, and loading states
- Theme-aware divider with configurable spacing and horizontal insets
- Responsive page layout with consistent padding, safe-area handling, and a readable content width
- Section header and empty-state primitives
- Widget tests and Dart analysis rules
- GitHub Actions quality workflow

## Quick start

Add the package to your Flutter project's dependencies (use a Git dependency until a package release is published):

```yaml
dependencies:
  awesome_flutter_kit:
    git:
      url: https://github.com/kingdart007-dev/awesome-flutter-kit.git
```

Then use the public entry point:

```dart
import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';

MaterialApp(
  theme: AfkTheme.light(),
  darkTheme: AfkTheme.dark(),
  themeMode: ThemeMode.system,
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      child: AfkButton(
        label: 'Continue',
        onPressed: () {},
      ),
    ),
  ),
);
```

## Project principles

1. Android and iOS only; no web or desktop target by default.
2. Clarity, accessibility, correctness, and recovery come before decorative polish.
3. Neutral white, charcoal, and gray surfaces; restrained borders and elevation.
4. Reusable components with small, explicit APIs and predictable states.
5. English/Arabic and RTL/LTR must be supported by consuming apps without clipped layouts or hard-coded direction assumptions.
6. No code generation or Freezed by default.
7. Keep dependencies lean. Routing, localization, persistence, and app state belong to the host app unless a concrete shared need proves otherwise.
8. No fake production behavior, unnecessary abstraction, or silent side effects.

## Development

```sh
flutter pub get
dart format .
flutter analyze
flutter test
```

See [Architecture](docs/architecture.md), [Design System](docs/design-system.md), and [Contributing](CONTRIBUTING.md).

## License

MIT. See [LICENSE](LICENSE).
