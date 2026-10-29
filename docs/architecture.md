# Architecture

Awesome Flutter Kit is a UI foundation package, not an application framework. It should make common interface decisions consistent without taking control away from the host app.

## Package boundaries

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
