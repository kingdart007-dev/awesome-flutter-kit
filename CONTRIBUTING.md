# Contributing

Thanks for helping improve Awesome Flutter Kit.

## Before opening a change

- Keep changes focused and explain the user-facing benefit.
- Reuse existing tokens and components when that improves consistency.
- Avoid adding dependencies unless there is a clear, documented need.
- Include tests for meaningful behavior and state changes.
- Check accessibility, text scaling, RTL, and both light and dark themes.

## Local quality checks

```sh
dart format .
flutter analyze
flutter test
```

## API guidance

Keep public APIs small and predictable. Export public types from `lib/awesome_flutter_kit.dart`; do not expose internal implementation files as part of the supported API.
