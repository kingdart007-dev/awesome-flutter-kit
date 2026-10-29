# Nutrition Dashboard UX Patterns

This guide documents a practical, mobile-first flow for calorie and nutrition products using Awesome Flutter Kit. It takes inspiration from the publicly described Cal AI experience—photo-first food logging, glanceable calorie and macro summaries, editable recognition results, hydration, and progress—without reproducing its brand, screens, or proprietary implementation.

## The product loop

1. **Understand today at a glance.** Show the calorie budget and remaining amount first, then macro progress and recent meals. Avoid making every metric equally prominent.
2. **Make logging obvious.** Give photo capture a clear primary entry point. Keep search, barcode, voice, gallery, and nutrition-label entry methods available as secondary choices when the host app supports them.
3. **Review before saving.** Recognition is an estimate, not a fact. Present detected foods and portion assumptions in an editable review step. Allow users to correct the item, amount, and serving size before adding it to the diary.
4. **Confirm the result.** After saving, update the diary and daily totals together, and provide concise confirmation that does not block the next action.
5. **Keep secondary trackers nearby.** Water, fasting, activity, steps, and progress are useful, but should not overwhelm the food-log loop. Use progressive disclosure for details and historical charts.

## Suggested component mapping

| Need | Kit pattern | Host-app responsibility |
| --- | --- | --- |
| Daily calorie budget | `AfkCalorieRing` | Goal calculation, consumed total, remaining policy |
| Protein/carbs/fat/fiber and other nutrients | `AfkMacroProgress` | Nutrient data, units, daily targets |
| Select a diary day | `AfkDateSelector` | Calendar rules, timezone, localized date labels |
| Add a meal by photo | `AfkFoodScanCard` | Camera/gallery permission, capture, upload, AI inference |
| Correct recognition results | `AfkFoodEstimateTile` | Editable food model, serving conversion, recalculation |
| Meal diary | `AfkMealEntryTile` | Persistence, meal grouping, edit/delete flows |
| Hydration | `AfkHydrationTracker` | Water history, reminders, daily target |
| Fasting | `AfkFastingCard` | Session timing, persistence, reminders, health safeguards |
| Workout and movement | `AfkActivityEntryTile` | Activity source, burned-calorie estimation, health permissions |

## Required states for a real scan flow

- **Idle:** camera or image-selection action with a concise explanation.
- **Permission denied:** explain why access is needed and offer a manual/search alternative.
- **Selecting image:** show progress without freezing navigation.
- **Analyzing:** preserve the selected image and provide a clear cancel/retry path.
- **No reliable result:** say that the food could not be identified confidently; allow manual search or entry.
- **Review:** list detected items, estimated portions, calories, and relevant nutrients. Every uncertain value must be editable.
- **Saving:** prevent duplicate submissions while retaining an escape path where possible.
- **Saved:** update the diary and totals and announce success accessibly.
- **Offline/server error:** keep user input and the image where appropriate; explain recovery without silently discarding work.

Do not invent a confidence percentage or precision that the model does not provide. Clearly label estimates, and never present nutrition estimates as medical advice.

## Visual hierarchy and interaction

- Use a single dominant calorie summary, not a wall of equal-weight cards.
- Use typography, spacing, and restrained borders before adding color or gradients.
- Use tabular figures for changing numeric values to reduce layout jitter.
- Keep portions and nutrient values editable and clearly connected to the food item they describe.
- Keep common actions reachable with one hand and make touch targets comfortably large.
- Preserve scroll position and the selected date when returning from a food review.
- Respect system text scaling, dark mode, reduced motion, screen-reader semantics, and RTL layouts.
- Keep reminders optional and configurable. Never introduce surprise sounds or haptics.
- Make history and exports available without trapping user data behind an upsell.

## Data and safety boundaries

The UI kit intentionally does not include an AI model, food database, camera integration, account system, subscription flow, health-data connector, or nutrition calculation service. The host app must own these integrations, data retention, consent, privacy disclosures, deletion/export, and error recovery.

Calorie, portion, exercise, and hydration figures can be estimates. Provide correction mechanisms, avoid guarantees about accuracy, and make health-sensitive targets adjustable with appropriate safeguards. Avoid moralizing labels, shame-based streaks, or interfaces that treat a single day as a verdict.

## Verification checklist

- [ ] Test loading, empty, no-result, permission-denied, offline, and retry states.
- [ ] Test both themes, Arabic RTL, long translations, and large text.
- [ ] Verify every scan result can be reviewed and corrected before saving.
- [ ] Verify repeated taps cannot create duplicate diary entries.
- [ ] Verify totals update consistently after add, edit, delete, and undo.
- [ ] Verify date boundaries and daily totals use the user's intended timezone.
- [ ] Verify privacy consent, retention, and deletion for photos and nutrition records.
- [ ] Test with real devices and assistive technologies on Android and iOS.
