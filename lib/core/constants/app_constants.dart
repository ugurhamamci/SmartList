/// Tunable, non-visual application constants.
abstract final class AppConstants {
  /// Page size for every paginated Firestore query.
  static const int pageSize = 20;

  /// Page size for chat history, which scrolls faster than lists.
  static const int messagePageSize = 30;

  /// Number of recent searches retained per user.
  static const int maxRecentSearches = 10;

  /// Number of barcode scans retained per user.
  static const int maxBarcodeHistory = 100;

  /// Debounce applied to search fields before a query is issued.
  static const Duration searchDebounce = Duration(milliseconds: 350);

  /// Debounce applied to the typing indicator write.
  static const Duration typingDebounce = Duration(milliseconds: 600);

  /// A typing indicator older than this is treated as stale.
  static const Duration typingTimeout = Duration(seconds: 5);

  /// Interval at which the presence heartbeat is republished.
  static const Duration presenceHeartbeat = Duration(seconds: 30);

  /// A member is shown as offline once their heartbeat is older than this.
  static const Duration presenceTimeout = Duration(seconds: 90);

  /// Retry policy for failed offline mutations.
  static const int maxSyncRetries = 5;
  static const Duration syncRetryBaseDelay = Duration(seconds: 2);

  /// Maximum image dimension (px) used when compressing before upload.
  static const double maxImageDimension = 1440;
  static const int imageUploadQuality = 82;

  /// Field limits mirrored by the Firestore security rules.
  static const int maxListTitleLength = 120;
  static const int maxListDescriptionLength = 500;
  static const int maxItemNameLength = 200;
  static const int maxItemNoteLength = 500;
  static const int maxMessageLength = 2000;
  static const int maxFeedbackLength = 5000;

  /// Password policy enforced client-side before hitting Firebase Auth.
  static const int minPasswordLength = 8;

  /// Free-plan ceilings; enforced by the `FeatureFlag` entitlement checks.
  static const int freePlanListLimit = 5;
  static const int freePlanMemberLimit = 3;
  static const int freePlanMonthlyAiGenerations = 10;

  /// Spacing between `sortOrder` values so an item can be dropped between two
  /// neighbours without renumbering the whole list.
  static const double sortOrderGap = 1000;
}

/// Names of the Hive boxes used for the offline cache.
abstract final class HiveBoxes {
  static const String shoppingLists = 'cache_shopping_lists';
  static const String shoppingItems = 'cache_shopping_items';
  static const String categories = 'cache_categories';
  static const String users = 'cache_users';
  static const String messages = 'cache_messages';
  static const String notifications = 'cache_notifications';
  static const String templates = 'cache_templates';
  static const String statistics = 'cache_statistics';
  static const String pendingMutations = 'pending_mutations';
  static const String preferences = 'preferences';

  static const List<String> all = [
    shoppingLists,
    shoppingItems,
    categories,
    users,
    messages,
    notifications,
    templates,
    statistics,
    pendingMutations,
    preferences,
  ];
}

/// Keys stored in `flutter_secure_storage`.
abstract final class SecureStorageKeys {
  static const String aiProviderOverride = 'ai_provider_override';
  static const String aiUserApiKey = 'ai_user_api_key';
  static const String biometricEnabled = 'biometric_enabled';
  static const String lastSignedInEmail = 'last_signed_in_email';
}

/// Keys stored in the unencrypted preferences box.
abstract final class PreferenceKeys {
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String currency = 'currency';
  static const String measurementSystem = 'measurement_system';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String lastSyncedAt = 'last_synced_at';
}
