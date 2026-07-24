import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'activity_log.freezed.dart';
part 'activity_log.g.dart';

/// An append-only audit entry at
/// `shopping_lists/{listId}/activity_logs/{id}`.
///
/// The security rules forbid update and delete, so the trail is tamper-evident.
/// Entries also drive the list activity feed and feed the statistics
/// aggregation.
@freezed
abstract class ActivityLog with _$ActivityLog {
  const factory ActivityLog({
    required String id,
    required String listId,
    required String actorId,
    required ActivityAction action,
    @TimestampConverter() required DateTime createdAt,

    /// Denormalised actor identity; the feed must stay readable after a member
    /// leaves the list.
    @Default('') String actorName,
    String? actorPhotoUrl,

    /// Entity the action was performed on, when applicable.
    String? targetId,
    @Default('') String targetName,

    /// Additional non-indexed context, e.g. the previous and new role.
    @Default(<String, String>{}) Map<String, String> metadata,
  }) = _ActivityLog;

  factory ActivityLog.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogFromJson(json);
}
