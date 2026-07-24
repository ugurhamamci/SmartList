import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/models/enums.dart';

/// Assembles the prompts and response schema for list generation.
///
/// Kept separate from both the provider implementations and the service so the
/// wording can be tuned, reviewed and unit-tested without touching transport or
/// orchestration code.
abstract final class PromptBuilder {
  /// Instruction turn shared by every generation request.
  static String systemPrompt(GenerationBrief brief) {
    final units = brief.measurementSystem == MeasurementSystem.metric
        ? 'metric units (g, kg, ml, l)'
        : 'imperial units (oz, lb, fl_oz, gal)';

    return '''
You plan grocery shopping lists. Produce a practical list a shopper can take to
an ordinary supermarket and complete in one trip.

Rules:
- Reply with JSON only, matching the supplied schema. No prose outside the JSON.
- Quantities use $units, or "piece" for countable products.
- Every item must be a specific purchasable product ("whole milk", not "dairy").
- Never include an item the user already has at home.
- Never include an item that violates a stated restriction or allergy.
- Group related products by assigning the same category name.
- Estimate prices in ${brief.currency} only where you are reasonably confident;
  omit the estimate otherwise rather than guessing.
- Write item names and the title in the language identified by the locale code
  "${brief.localeCode}".
- Keep the list within the stated budget when one is given; if that is not
  possible, prioritise essentials and say so in the rationale.
- Use the rationale field for a two-sentence explanation of your choices.
''';
  }

  /// The request turn, specialised by [GenerationBrief.kind].
  static String userPrompt(GenerationBrief brief) {
    final buffer = StringBuffer()
      ..writeln(_intent(brief))
      ..writeln('People to shop for: ${brief.peopleCount}');

    if (brief.budget != null) {
      buffer.writeln('Budget: ${brief.budget} ${brief.currency}');
    }
    if (brief.restrictions.isNotEmpty) {
      buffer.writeln(
        'Restrictions and allergies: ${brief.restrictions.join(', ')}',
      );
    }
    if (brief.preferences.isNotEmpty) {
      buffer.writeln('Preferences: ${brief.preferences.join(', ')}');
    }
    if (brief.pantryItems.isNotEmpty) {
      buffer.writeln(
        'Already at home, do not include: ${brief.pantryItems.join(', ')}',
      );
    }
    if (brief.prompt.trim().isNotEmpty && brief.kind != AiListKind.custom) {
      buffer.writeln('Additional notes: ${brief.prompt.trim()}');
    }

    return buffer.toString();
  }

  static String _intent(GenerationBrief brief) {
    return switch (brief.kind) {
      AiListKind.weeklyShopping =>
        'Build a weekly grocery shopping list covering ${brief.days} days, '
            'including staples, fresh produce, and household basics.',
      AiListKind.mealPlan =>
        'Plan meals for ${brief.days} days and list every ingredient needed to '
            'cook them. Consolidate ingredients shared between meals into a '
            'single item with the combined quantity.',
      AiListKind.party =>
        'Build a shopping list for a party for ${brief.peopleCount} guests: '
            'food, drinks, ice, serveware and cleanup supplies.',
      AiListKind.baby =>
        brief.babyAgeMonths == null
            ? 'Build a shopping list of baby essentials: feeding, nappies, '
                  'bathing and clothing basics.'
            : 'Build a shopping list of baby essentials appropriate for a '
                  '${brief.babyAgeMonths}-month-old: age-appropriate food, '
                  'nappies, bathing and clothing basics.',
      AiListKind.diet =>
        'Build a grocery list for the eating plan described below, covering '
            '${brief.days} days and respecting every stated restriction. '
            '${brief.prompt.trim()}',
      AiListKind.custom =>
        brief.prompt.trim().isEmpty
            ? 'Build a general-purpose grocery shopping list.'
            : brief.prompt.trim(),
    };
  }

  /// JSON Schema the response must satisfy.
  ///
  /// Deliberately restricted to the subset every provider's structured-output
  /// mode accepts: object, array, string, number, boolean, enum, `required`,
  /// and `additionalProperties: false`. Numeric and string constraints are
  /// omitted because they are not universally supported.
  static Map<String, dynamic> responseSchema() {
    return <String, dynamic>{
      'type': 'object',
      'additionalProperties': false,
      'required': ['title', 'description', 'emoji', 'rationale', 'items'],
      'properties': <String, dynamic>{
        'title': {
          'type': 'string',
          'description': 'Short, human-readable list title.',
        },
        'description': {
          'type': 'string',
          'description': 'One sentence describing the list.',
        },
        'emoji': {
          'type': 'string',
          'description': 'A single emoji representing the list.',
        },
        'rationale': {
          'type': 'string',
          'description': 'Two sentences explaining the choices made.',
        },
        'items': <String, dynamic>{
          'type': 'array',
          'items': <String, dynamic>{
            'type': 'object',
            'additionalProperties': false,
            'required': [
              'name',
              'quantity',
              'unit',
              'category',
              'notes',
              'priority',
            ],
            'properties': <String, dynamic>{
              'name': {
                'type': 'string',
                'description': 'Specific purchasable product name.',
              },
              'quantity': {'type': 'number'},
              'unit': {
                'type': 'string',
                'enum': MeasurementUnit.values
                    .map((unit) => unit.wire)
                    .toList(),
              },
              'category': {
                'type': 'string',
                'description': 'Supermarket category, e.g. Produce, Dairy.',
              },
              'notes': {
                'type': 'string',
                'description': 'Optional preparation or brand note.',
              },
              'priority': {
                'type': 'string',
                'enum': ItemPriority.values
                    .map((priority) => priority.wire)
                    .toList(),
              },
              'estimatedPrice': {
                'type': ['number', 'null'],
                'description': 'Unit price estimate, or null if unsure.',
              },
            },
          },
        },
      },
    };
  }

  /// Appended to the prompt for providers that cannot enforce a schema, so the
  /// response is still parseable.
  static String schemaInstruction() {
    return 'Reply with a single JSON object and nothing else. It must contain '
        'the string fields "title", "description", "emoji" and "rationale", '
        'and an "items" array whose entries contain "name" (string), '
        '"quantity" (number), "unit" (string), "category" (string), '
        '"notes" (string), "priority" (string) and optionally '
        '"estimatedPrice" (number or null).';
  }
}
