import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/features/ai/domain/ai_service.dart';
import 'package:smartlist/models/enums.dart';

/// Returns a canned reply, so parsing and fallback behaviour can be tested
/// without touching the network.
class _FakeProvider implements AiProvider {
  _FakeProvider({
    required this.kind,
    required this.isConfigured,
    this.reply = '',
    this.stopReason = AiStopReason.completed,
    this.refusalCategory,
  });

  @override
  final AiProviderKind kind;

  @override
  final bool isConfigured;

  final String reply;
  final AiStopReason stopReason;
  final String? refusalCategory;

  int callCount = 0;

  @override
  String get defaultModel => 'fake-model';

  @override
  bool get supportsStructuredOutput => true;

  @override
  Future<AiResponse> complete(AiRequest request) async {
    callCount++;
    return AiResponse(
      text: reply,
      provider: kind,
      model: defaultModel,
      stopReason: stopReason,
      refusalCategory: refusalCategory,
    );
  }
}

const _brief = GenerationBrief(kind: AiListKind.weeklyShopping);

const _validReply = '''
{
  "title": "Weekly Shop",
  "description": "Staples for the week",
  "emoji": "🛒",
  "rationale": "Covers breakfast and dinner basics.",
  "items": [
    {"name": "Whole milk", "quantity": 2, "unit": "l", "category": "Dairy",
     "notes": "", "priority": "normal", "estimatedPrice": 1.5},
    {"name": "Bananas", "quantity": 6, "unit": "piece", "category": "Produce",
     "notes": "ripe", "priority": "low", "estimatedPrice": null}
  ]
}
''';

void main() {
  group('generateList', () {
    test('parses a well-formed reply', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(
            kind: AiProviderKind.claude,
            isConfigured: true,
            reply: _validReply,
          ),
        ]),
      );

      final list = await service.generateList(_brief);

      expect(list.title, 'Weekly Shop');
      expect(list.kind, AiListKind.weeklyShopping);
      expect(list.items, hasLength(2));
      expect(list.items.first.unit, MeasurementUnit.liter);
      expect(list.items[1].priority, ItemPriority.low);
      // Only the priced line contributes: 1.5 * 2.
      expect(list.estimatedTotal, 3.0);
    });

    test('recovers a payload wrapped in prose and a code fence', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(
            kind: AiProviderKind.claude,
            isConfigured: true,
            reply: 'Sure, here you go:\n```json\n$_validReply\n```\nEnjoy!',
          ),
        ]),
      );

      final list = await service.generateList(_brief);

      expect(list.items, hasLength(2));
    });

    test('skips items with no usable name instead of failing', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(
            kind: AiProviderKind.claude,
            isConfigured: true,
            reply: '''
{
  "title": "T", "description": "", "emoji": "🛒", "rationale": "",
  "items": [
    {"name": "", "quantity": 1, "unit": "piece", "category": "",
     "notes": "", "priority": "normal"},
    {"name": "Bread", "quantity": 1, "unit": "piece", "category": "Bakery",
     "notes": "", "priority": "normal"}
  ]
}
''',
          ),
        ]),
      );

      final list = await service.generateList(_brief);

      expect(list.items, hasLength(1));
      expect(list.items.single.name, 'Bread');
    });

    test('throws when no provider is configured', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(kind: AiProviderKind.claude, isConfigured: false),
        ]),
      );

      await expectLater(
        service.generateList(_brief),
        throwsA(
          isA<AiException>().having((e) => e.code, 'code', 'ai.no_provider'),
        ),
      );
    });

    test('surfaces a refusal as a typed exception', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(
            kind: AiProviderKind.claude,
            isConfigured: true,
            stopReason: AiStopReason.refusal,
            refusalCategory: 'cyber',
          ),
        ]),
      );

      await expectLater(
        service.generateList(_brief),
        throwsA(isA<AiException>().having((e) => e.code, 'code', 'ai.refused')),
      );
    });

    test(
      'surfaces a truncated reply rather than parsing partial JSON',
      () async {
        final service = AiService(
          AiProviderRegistry([
            _FakeProvider(
              kind: AiProviderKind.claude,
              isConfigured: true,
              reply: '{"title": "Partial", "items": [',
              stopReason: AiStopReason.maxTokens,
            ),
          ]),
        );

        await expectLater(
          service.generateList(_brief),
          throwsA(
            isA<AiException>().having((e) => e.code, 'code', 'ai.truncated'),
          ),
        );
      },
    );

    test('rejects a reply containing no JSON object', () async {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(
            kind: AiProviderKind.claude,
            isConfigured: true,
            reply: 'I cannot help with that.',
          ),
        ]),
      );

      await expectLater(
        service.generateList(_brief),
        throwsA(
          isA<AiException>().having((e) => e.code, 'code', 'ai.unparseable'),
        ),
      );
    });
  });

  group('provider resolution', () {
    test('falls back past an unconfigured preferred provider', () async {
      final claude = _FakeProvider(
        kind: AiProviderKind.claude,
        isConfigured: false,
      );
      final gemini = _FakeProvider(
        kind: AiProviderKind.gemini,
        isConfigured: true,
        reply: _validReply,
      );
      final service = AiService(AiProviderRegistry([claude, gemini]));

      await service.generateList(_brief, preferred: AiProviderKind.claude);

      expect(claude.callCount, 0);
      expect(gemini.callCount, 1);
    });

    test('honours the preferred provider when it is configured', () async {
      final claude = _FakeProvider(
        kind: AiProviderKind.claude,
        isConfigured: true,
        reply: _validReply,
      );
      final gemini = _FakeProvider(
        kind: AiProviderKind.gemini,
        isConfigured: true,
        reply: _validReply,
      );
      final service = AiService(AiProviderRegistry([gemini, claude]));

      await service.generateList(_brief, preferred: AiProviderKind.claude);

      expect(claude.callCount, 1);
      expect(gemini.callCount, 0);
    });

    test('reports only configured providers as available', () {
      final service = AiService(
        AiProviderRegistry([
          _FakeProvider(kind: AiProviderKind.claude, isConfigured: true),
          _FakeProvider(kind: AiProviderKind.openAi, isConfigured: false),
        ]),
      );

      expect(service.availableProviders, [AiProviderKind.claude]);
    });
  });
}
