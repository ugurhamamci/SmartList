import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/constants/app_constants.dart';
import 'package:smartlist/core/utils/json_converters.dart';

part 'user_presence.freezed.dart';
part 'user_presence.g.dart';

/// Presence heartbeat at `shopping_lists/{listId}/presence/{userId}`.
///
/// Presence is scoped to a list rather than global so that the online
/// indicators on a list only reflect members currently looking at it. A client
/// republishes its own document on an interval; a document whose [lastSeenAt]
/// is older than [AppConstants.presenceTimeout] is treated as offline, which
/// makes the system self-healing after a crash or lost connection.
@freezed
abstract class UserPresence with _$UserPresence {
  const factory UserPresence({
    required String id,
    required String userId,
    required String listId,
    @TimestampConverter() required DateTime lastSeenAt,
    @Default(false) bool isOnline,
    @Default('') String displayName,
    String? photoUrl,

    /// Set while the member has a specific item open for editing, which the UI
    /// uses to warn about a concurrent edit.
    String? editingItemId,
    @Default('') String deviceId,
  }) = _UserPresence;

  factory UserPresence.fromJson(Map<String, dynamic> json) =>
      _$UserPresenceFromJson(json);
}

/// Derived properties of a [UserPresence] record.
extension UserPresenceX on UserPresence {
  /// Treats a stale heartbeat as offline even if the flag still reads true.
  bool get isActive {
    if (!isOnline) {
      return false;
    }
    final age = DateTime.now().toUtc().difference(lastSeenAt);
    return age <= AppConstants.presenceTimeout;
  }

  bool get isEditing => editingItemId != null;
}
