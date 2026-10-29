# Architecture

Awesome Flutter Kit is a UI foundation package, not an application framework. It should make common interface decisions consistent without taking control away from the host app.

## Product-agnostic architecture\n\nThe kit is intended to support many product categories, not one app or industry. Keep the core layer domain-neutral. A component belongs in core when it represents a common interaction or visual pattern across different apps; specialized patterns must remain optional and clearly grouped by domain. A host app should never need to depend on nutrition, commerce, chat, or media concepts just to use a button, form, navigation, or theme.\n\nPrefer this conceptual separation as the library grows:\n\n- **Core foundation:** tokens, themes, accessibility helpers, motion, layout, controls, feedback, navigation primitives.\n- **Common patterns:** forms, search/filter, settings, onboarding, empty/loading/error/retry, selection, pagination.\n- **Optional domain patterns:** commerce, nutrition/health, messaging, media, maps, finance, productivity, education, and dashboards. Add these only when useful reusable patterns and tests exist; do not add fake services or business logic.\n\n## Package boundaries

- `lib/awesome_flutter_kit.dart`: stable, intentional public exports.
- `lib/src/theme/`: neutral design tokens and theme factories.
- `lib/src/components/`: small reusable widgets with narrow APIs.
- `test/`: behavior and public API tests.

Keep implementation details under `lib/src`; consumers should import the public library entry point.

## Design rules

1. Prefer theme-driven colors and typography over hard-coded widget styling.
2. Use the spacing and radius tokens rather than one-off values for repeated patterns.
3. Components accept localized strings from the host app; this package must not hard-code English UI copy into user-facing components.
4. Honor text scaling, semantics, minimum touch targets, and RTL-safe layout primitives.
5. Avoid unnecessary dependencies, global state, hidden side effects, and code generation.

## App integration

The host application owns routing, localization delegates, locale selection, app-wide state, persistence, and product-specific behavior. Riverpod and go_router can be used by host apps, but are not dependencies of this UI package.

## Quality gates

Run `dart format .`, `flutter analyze`, and `flutter test` before merging. Add tests when a component gains meaningful behavior or states.
