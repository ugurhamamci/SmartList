/// Canonical Cloud Firestore collection and document paths.
///
/// Every repository resolves paths through this class so that a schema change
/// is a single-file edit and so that string literals never drift between the
/// client, the security rules and the Cloud Functions.
abstract final class FirestorePaths {
  // ------------------------------------------------------------ collections
  static const String users = 'users';
  static const String shoppingLists = 'shopping_lists';
  static const String categories = 'categories';
  static const String chatRooms = 'chat_rooms';
  static const String shoppingTemplates = 'shopping_templates';
  static const String sharedLinks = 'shared_links';
  static const String subscriptions = 'subscriptions';
  static const String premiumFeatures = 'premium_features';
  static const String roles = 'roles';
  static const String permissions = 'permissions';
  static const String feedback = 'feedback';
  static const String bugReports = 'bug_reports';
  static const String analyticsEvents = 'analytics_events';

  // --------------------------------------------------------- subcollections
  static const String items = 'items';
  static const String members = 'members';
  static const String activityLogs = 'activity_logs';
  static const String invitations = 'invitations';
  static const String presence = 'presence';
  static const String messages = 'messages';
  static const String typing = 'typing';
  static const String settings = 'settings';
  static const String deviceTokens = 'device_tokens';
  static const String favorites = 'favorites';
  static const String recentSearches = 'recent_searches';
  static const String barcodeHistory = 'barcode_history';
  static const String voiceCommands = 'voice_commands';
  static const String statistics = 'statistics';
  static const String notifications = 'notifications';

  /// Id of the singleton preferences document under `users/{uid}/settings`.
  static const String preferencesDocId = 'preferences';

  // ----------------------------------------------------------- doc builders
  static String user(String userId) => '$users/$userId';

  static String userSettings(String userId) =>
      '${user(userId)}/$settings/$preferencesDocId';

  static String userDeviceTokens(String userId) =>
      '${user(userId)}/$deviceTokens';

  static String userFavorites(String userId) => '${user(userId)}/$favorites';

  static String userRecentSearches(String userId) =>
      '${user(userId)}/$recentSearches';

  static String userBarcodeHistory(String userId) =>
      '${user(userId)}/$barcodeHistory';

  static String userVoiceCommands(String userId) =>
      '${user(userId)}/$voiceCommands';

  static String userStatistics(String userId) => '${user(userId)}/$statistics';

  static String userNotifications(String userId) =>
      '${user(userId)}/$notifications';

  static String shoppingList(String listId) => '$shoppingLists/$listId';

  static String listItems(String listId) => '${shoppingList(listId)}/$items';

  static String listItem(String listId, String itemId) =>
      '${listItems(listId)}/$itemId';

  static String listMembers(String listId) =>
      '${shoppingList(listId)}/$members';

  static String listMember(String listId, String userId) =>
      '${listMembers(listId)}/$userId';

  static String listActivityLogs(String listId) =>
      '${shoppingList(listId)}/$activityLogs';

  static String listInvitations(String listId) =>
      '${shoppingList(listId)}/$invitations';

  static String listPresence(String listId) =>
      '${shoppingList(listId)}/$presence';

  static String listPresenceDoc(String listId, String userId) =>
      '${listPresence(listId)}/$userId';

  /// A chat room shares its identifier with the list it belongs to.
  static String chatRoom(String listId) => '$chatRooms/$listId';

  static String roomMessages(String listId) => '${chatRoom(listId)}/$messages';

  static String roomMessage(String listId, String messageId) =>
      '${roomMessages(listId)}/$messageId';

  static String roomTyping(String listId) => '${chatRoom(listId)}/$typing';

  static String roomTypingDoc(String listId, String userId) =>
      '${roomTyping(listId)}/$userId';

  static String subscription(String userId) => '$subscriptions/$userId';
}

/// Field names used in queries, ordering and partial updates.
///
/// Security rules validate against these exact names; keeping them here avoids
/// silent query breakage when a field is renamed.
abstract final class FirestoreFields {
  // audit
  static const String createdAt = 'createdAt';
  static const String createdBy = 'createdBy';
  static const String updatedAt = 'updatedAt';
  static const String updatedBy = 'updatedBy';
  static const String deletedAt = 'deletedAt';
  static const String version = 'version';

  // shared
  static const String id = 'id';
  static const String name = 'name';
  static const String title = 'title';
  static const String ownerId = 'ownerId';
  static const String userId = 'userId';
  static const String listId = 'listId';
  static const String roomId = 'roomId';
  static const String status = 'status';
  static const String type = 'type';
  static const String sortOrder = 'sortOrder';
  static const String categoryId = 'categoryId';

  // shopping list
  static const String memberIds = 'memberIds';
  static const String memberRoles = 'memberRoles';
  static const String memberCount = 'memberCount';
  static const String isArchived = 'isArchived';
  static const String isPinned = 'isPinned';
  static const String isFavorite = 'isFavorite';
  static const String isCompleted = 'isCompleted';
  static const String completedAt = 'completedAt';
  static const String itemCount = 'itemCount';
  static const String completedItemCount = 'completedItemCount';

  // shopping item
  static const String quantity = 'quantity';
  static const String priority = 'priority';
  static const String barcode = 'barcode';
  static const String purchasedBy = 'purchasedBy';
  static const String purchasedAt = 'purchasedAt';

  // chat
  static const String senderId = 'senderId';
  static const String readBy = 'readBy';
  static const String reactions = 'reactions';

  // notifications
  static const String isRead = 'isRead';
  static const String readAt = 'readAt';

  // presence
  static const String isOnline = 'isOnline';
  static const String lastSeenAt = 'lastSeenAt';

  // invitations
  static const String inviteeEmail = 'inviteeEmail';
  static const String inviteeId = 'inviteeId';
  static const String role = 'role';

  // templates / links
  static const String isPublic = 'isPublic';
  static const String isActive = 'isActive';
  static const String usageCount = 'usageCount';
  static const String isGlobal = 'isGlobal';

  // statistics
  static const String period = 'period';
  static const String periodStart = 'periodStart';

  // barcode / voice
  static const String code = 'code';
  static const String format = 'format';
  static const String scannedAt = 'scannedAt';

  // misc
  static const String token = 'token';
  static const String platform = 'platform';
  static const String occurredAt = 'occurredAt';
  static const String actorId = 'actorId';
  static const String action = 'action';
  static const String query = 'query';
  static const String searchedAt = 'searchedAt';
  static const String targetType = 'targetType';
  static const String severity = 'severity';
  static const String joinedAt = 'joinedAt';
}
