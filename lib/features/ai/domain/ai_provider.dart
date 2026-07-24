import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/models/enums.dart';

/// Contract every AI vendor implementation satisfies.
///
/// The application depends only on this interface, so switching vendors — or
/// adding one — never touches a call site. Implementations translate
/// [AiRequest] into their own wire format and normalise the reply back into an
/// [AiResponse], mapping transport and vendor errors to `AiException`.
abstract interface class AiProvider {
  /// Which vendor this implementation speaks to.
  AiProviderKind get kind;

  /// Model used when [AiRequest.model] is null.
  String get defaultModel;

  /// Whether the provider can enforce a JSON Schema on its output. When false,
  /// `AiService` falls back to instructing the schema in the prompt and
  /// parsing defensively.
  bool get supportsStructuredOutput;

  /// True when the provider has usable credentials, whether a direct key or a
  /// server-side proxy. A provider that is not configured is skipped during
  /// resolution rather than failing at call time.
  bool get isConfigured;

  /// Issues a completion.
  ///
  /// Throws `AiException` on a vendor or transport failure, and
  /// `RateLimitException` when the vendor reports throttling.
  Future<AiResponse> complete(AiRequest request);
}

/// Resolves the active [AiProvider] from the user's preference, falling back
/// through the configured vendors so a missing key degrades rather than breaks.
///
/// Registration order is the fallback order.
class AiProviderRegistry {
  AiProviderRegistry(this._providers);

  final List<AiProvider> _providers;

  /// Every registered provider, in fallback order.
  List<AiProvider> get all => List.unmodifiable(_providers);

  /// Providers that currently hold credentials.
  List<AiProvider> get configured =>
      _providers.where((provider) => provider.isConfigured).toList();

  /// The provider for [kind], or null when it is not registered.
  AiProvider? byKind(AiProviderKind kind) {
    for (final provider in _providers) {
      if (provider.kind == kind) {
        return provider;
      }
    }
    return null;
  }

  /// Resolves the provider to use.
  ///
  /// Prefers [preferred] when it is registered and configured; otherwise
  /// returns the first configured provider. Returns null when nothing is
  /// configured, which the caller surfaces as a setup problem rather than a
  /// transient failure.
  AiProvider? resolve(AiProviderKind? preferred) {
    if (preferred != null) {
      final match = byKind(preferred);
      if (match != null && match.isConfigured) {
        return match;
      }
    }
    final fallbacks = configured;
    return fallbacks.isEmpty ? null : fallbacks.first;
  }
}
