# Accessibility and localization

Awesome Flutter Kit provides reusable visual and interaction primitives; the host application remains responsible for translating product copy and choosing the right semantic meaning.

## English and Arabic

- Keep all user-facing strings in the host app's localization resources. Pass translated labels, hints, tooltips, button text, and status messages into kit components.
- Configure Flutter localization delegates and supported locales in the host app; the kit intentionally does not force an application-specific locale.
- Test both LTR and RTL layouts with real Arabic text, mixed Arabic/Latin strings, numerals, dates, and validation messages.
- Use directional icons for directional meaning (back, forward, previous, next) and let Flutter's directional widgets and platform components adapt where possible. Do not mirror universal symbols such as search, close, play, or check.
- Avoid fixed heights around text. Allow labels and supporting text to wrap under large text settings.

## Semantics and interaction

- Interactive controls need clear accessible labels; icon-only actions must include tooltips or semantic labels.
- Do not communicate status with color alone. Pair semantic color with text and/or an icon.
- Keep touch targets comfortably sized; the kit's icon button uses a 48 logical-pixel minimum.
- Respect the operating system's reduced-motion setting. Motion should explain a change or acknowledge an action, not decorate every update.
- Do not add sound or haptics automatically. Host apps should opt in when they add meaningful value and should respect user preferences.
- Preserve predictable keyboard, focus, text selection, and system-back behavior by using Flutter's native controls unless a custom interaction has a clear benefit.

## Verification checklist

- [ ] Run each example in English LTR and Arabic RTL.
- [ ] Check large text and display scaling without clipped content.
- [ ] Verify screen-reader names, state, and focus order.
- [ ] Confirm dialog/sheet dismissal, Android system back, and iOS gesture behavior.
- [ ] Check light, dark, and system themes.
- [ ] Verify reduced-motion behavior on animated components.
- [ ] Test on physical Android and iOS devices before production release.
