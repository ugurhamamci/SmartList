import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// A notification at `users/{userId}/notifications/{id}`.
///
/// Fanned out by Cloud Functions; the client may only mark one read or delete
/// it. Copy is assembled on the device from [type] and [params] so that the
/// text follows the reader's language rather than the actor's.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required NotificationType type,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,

    /// Interpolation values for the localized template, e.g. `actorName`.
    @Default(<String, String>{}) Map<String, String> params,
    @Default(false) bool isRead,
    @NullableTimestampConverter() DateTime? readAt,

    /// Deep-link targets used to route a tap.
    String? listId,
    String? itemId,
    String? messageId,
    String? invitationId,

    /// Denormalised actor identity for the avatar on the notification row.
    String? actorId,
    @Default('') String actorName,
    String? actorPhotoUrl,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

/// Derived properties of an [AppNotification].
extension AppNotificationX on AppNotification {
  bool get isDeleted => deletedAt != null;

  bool get isUnread => !isRead;

  /// True when tapping the notification can navigate somewhere.
  bool get hasTarget =>
      listId != null ||
      itemId != null ||
      messageId != null ||
      invitationId != null;
}
