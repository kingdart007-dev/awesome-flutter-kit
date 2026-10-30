# Motion, Responsiveness, and Native Feel

This document defines how Awesome Flutter Kit should make interfaces feel immediate, calm, and physically coherent across iOS and Android.

The target is not "more animation." The target is **fast feedback, stable layouts, natural movement, and predictable interruption/recovery**.

## 1. The interaction contract

Every interactive component should follow these rules:

1. **Acknowledge input immediately.** Pressed, focused, selected, or disabled state should be visible without waiting for an asynchronous operation.
2. **Never animate the action itself into a delay.** Run the callback at the correct point in the interaction; animation is feedback, not a gate.
3. **Keep motion interruptible.** A second tap, a back gesture, route change, or updated state must not leave the interface stuck in an obsolete animation.
4. **Preserve context.** When showing a sheet, expanding content, or changing tabs, avoid needless layout jumps and preserve the user's reading position when practical.
5. **Make state changes understandable without motion.** Reduced-motion users and screen-reader users must receive the same information.
6. **Use platform conventions deliberately.** iOS and Android should feel related, not mechanically identical. The host app remains responsible for routing and platform-specific navigation integration.

## 2. Shared motion tokens

Use the shared `AfkMotion` tokens. Do not scatter arbitrary durations and curves across components. The following are design targets; align the existing token definitions with these values before introducing another token system.

| Token | Target | Typical use |
| --- | ---: | --- |
| instant | 0 ms | State changes that must not animate |
| micro | 100–140 ms | Press feedback, icon state changes |
| short | 160–220 ms | Small fades, selection indicators |
| standard | 220–300 ms | Content transitions, compact overlays |
| expressive | 300–380 ms | Larger sheet or page movement when context benefits |
| reduced motion | 0 ms or a non-spatial alternative | User/system requests reduced motion |

Use ease-out for elements entering, ease-in for elements leaving, and a standard ease-in-out curve for reversible state changes. Prefer a single well-tuned curve over spring physics by default. Use spring-like motion only when it improves spatial understanding and remains stable across device performance levels.

Durations are starting points, not requirements to animate every interaction. A frequent action should feel faster than a rare, complex transition.

## 3. Press and selection feedback

- Show pressed feedback on touch-down, not only after release.
- Keep scale changes subtle; avoid shrinking text or changing a control's layout bounds.
- Use color, border, opacity, or a small scale shift where appropriate, not all effects at once.
- Provide clear focus-visible feedback for keyboard, switch-access, and other non-touch input.
- Disabled controls must look and behave disabled; do not use press feedback for them.
- Loading controls must prevent duplicate submissions when the host action is in progress and must expose a semantic busy state.
- Selection changes should be immediate. Animate only the indicator or related content, not the availability of the selection.
- Haptics are optional host-app behavior. Never trigger haptics automatically for every generic tap.
- Sound is opt-in, context-appropriate, and controlled by the host app. Never play surprise sounds from shared UI components.

## 4. Navigation, sheets, and overlays

- Route transitions belong to the host app's navigation solution. The kit may provide reusable transition builders, but must not introduce a routing dependency.
- Keep forward and backward transitions coherent and preserve platform back behavior.
- Modal sheets should enter from a direction that communicates their relationship to the current screen; dismiss by the expected gesture and system action where supported.
- Scrim opacity should be restrained. Avoid heavy blur by default because it can cost performance and reduce clarity.
- A dismissible overlay must not trap focus or leave invisible controls interactive behind it.
- Prevent duplicate sheets/dialogs from repeated taps where the host flow requires a single active instance.
- Use drag gestures only when the gesture has a clear purpose and does not conflict with scrolling or platform navigation.
- When an overlay is dismissed, return focus to a meaningful triggering control where practical.

## 5. Scrolling and layout stability

- Use Flutter's lazy list/grid builders for long or unbounded collections.
- Avoid nested scroll views unless their coordination is intentional and tested.
- Prefer slivers or one coherent scrollable for complex scrolling screens.
- Reserve image and asynchronous-content space when dimensions are known to avoid content jumps.
- Skeletons should match the final content's rough geometry; do not use a skeleton that causes a second large layout shift.
- Do not rebuild expensive, unrelated parts of the widget tree for a local state change.
- Keep keys stable for reorderable or animated collections so elements retain identity.
- Respect safe areas, keyboard insets, text scaling, and long localized strings; never force text into a fixed-height container to preserve a screenshot.
- Avoid adding animation wrappers around every list item. Animate insertions/removals only when the change is meaningful and performance-tested.

## 6. Loading and async actions

- For a very short operation, prefer immediate state feedback over a flashing spinner.
- For longer operations, show progress or a layout-matched skeleton, with a clear explanation when needed.
- Preserve already available content during refresh when safe; don't replace an entire screen with a spinner for a small background update.
- Provide retry and recovery for recoverable failures.
- Distinguish empty data, no search results, offline state, permission denial, and server failure; they are not interchangeable.
- Keep loading, success, and error announcements accessible.
- The UI kit must not fake completion, network activity, AI analysis, or persistence. Host applications supply real operation state.
- Guard against stale asynchronous results updating a screen after the user has left or changed the query.

## 7. Reduced motion and accessibility

- Check `MediaQuery.disableAnimationsOf(context)` where supported by the project's minimum Flutter version, or use the compatible `MediaQuery` API available to the package.
- When reduced motion is enabled, remove nonessential spatial movement and replace it with an immediate state change or restrained opacity change.
- Do not disable essential feedback, state labels, focus indicators, or progress semantics.
- Do not communicate success, error, selection, or navigation solely through animation or color.
- Ensure tap targets are at least 48 logical pixels unless a documented platform-specific exception is necessary.
- Respect system text scaling and semantic labels; test with screen readers and larger text.
- Test RTL layouts and mirror only directional icons. Do not mirror universal symbols such as search, close, or play/pause without a clear platform reason.

## 8. Performance rules

- Prefer implicit animations for simple property changes; use explicit controllers when coordination, interruption, or lifecycle control truly requires them.
- Dispose controllers and listeners. Avoid creating controllers inside frequently rebuilt build methods.
- Avoid unnecessary opacity, clipping, blur, and multiple layers of compositing in scrolling lists.
- Keep animated subtrees small and use `AnimatedBuilder` or equivalent isolation when appropriate.
- Avoid expensive synchronous work in build methods and animation listeners.
- Do not use `saveLayer`-triggering effects casually; profile complex visual treatments on real devices.
- Use `const` widgets and stable object identities where they genuinely reduce rebuild work, without turning code into unreadable ceremony.
- Avoid optimizing solely from assumptions. Profile frame timing and memory on representative low/mid-range Android hardware and current iPhones.
- Verify behavior at 60 Hz and high-refresh-rate displays; don't assume every device has the same frame budget.

## 9. Verification checklist

For every new or substantially changed interactive component, verify:

- [ ] Immediate visual acknowledgement on press and focus.
- [ ] Correct idle, pressed, focused, selected, disabled, loading, success, and error states where applicable.
- [ ] No action is delayed solely for animation.
- [ ] Rapid repeated input and interrupted transitions do not create stuck states.
- [ ] Reduced-motion behavior is meaningful and tested.
- [ ] Semantics expose labels, values, and state.
- [ ] Text scaling and long English/Arabic labels do not overflow.
- [ ] RTL layout and directional icons behave correctly.
- [ ] Keyboard insets and safe areas are handled.
- [ ] Widget tests cover meaningful state transitions.
- [ ] Animation-heavy behavior is profiled on physical iOS and Android devices before release.

## 10. What this library will not do

- No global animation that makes every screen move the same way.
- No mandatory haptics or sounds.
- No decorative animation that blocks input or obscures information.
- No heavy blur/glow/gradient as a substitute for hierarchy.
- No custom replacement for a robust Flutter primitive without a concrete usability or consistency benefit.
- No claim of "native performance" without device testing.

The guiding principle is simple: **the interface should feel ready before the user has to think about it.**
