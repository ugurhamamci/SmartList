import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartlist/core/config/app_config.dart';
import 'package:uuid/uuid.dart';

/// Compile-time configuration. Overridden in tests and in `bootstrap` so that
/// the resolved instance is shared rather than rebuilt per read.
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

// Firebase saglayicilari kaldirildi: proje Supabase'e gecti. Supabase
// istemcisi `features/auth/auth_providers.dart` icinde `supabaseClientProvider`
// olarak sunuluyor; burada durmasi bu dosyayi kimlik dogrulama ozelligine
// bagimli hale getirirdi.

// ----------------------------------------------------------------- device

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  // Android encryption is handled by the plugin's default ciphers; the former
  // `encryptedSharedPreferences` flag is deprecated and ignored.
  return const FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// Identifier generator, injected so that tests can produce stable ids.
final uuidProvider = Provider<Uuid>((ref) => const Uuid());

/// Current wall clock, injected so that time-dependent logic is testable.
final clockProvider = Provider<DateTime Function()>((ref) {
  return () => DateTime.now().toUtc();
});

/// Live connectivity state. `true` while at least one transport is available.
///
/// Connectivity only reports whether an interface exists, not whether the
/// backend is reachable, so this drives the offline banner while Firestore's own
/// retry logic remains the source of truth for writes.
final isOnlineProvider = StreamProvider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);

  bool hasTransport(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  return connectivity.onConnectivityChanged.map(hasTransport);
});
