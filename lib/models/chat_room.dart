import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

/// The conversation attached to a list, stored at `chat_rooms/{listId}`.
///
/// The document id equals the list id, so a member of the list is a
/// participant of exactly one room and the security rules can authorise the
/// room by reading the list.
@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String listId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default(<String>[]) List<String> memberIds,
    @Default(0) int messageCount,

    /// Denormalised preview of the newest message for the list overview.
    @Default('') String lastMessagePreview,
    String? lastMessageSenderId,
    @Default('') String lastMessageSenderName,
    MessageType? lastMessageType,
    @NullableTimestampConverter() DateTime? lastMessageAt,

    /// uid -> id of the last message that member has read. Unread counts are
    /// derived client-side from this marker.
    @Default(<String, String>{}) Map<String, String> lastReadMessageIds,

    /// uid -> time that member last opened the room.
    @Default(<String, DateTime>{})
    @TimestampMapConverter()
    Map<String, DateTime> lastReadAt,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

/// Derived properties of a [ChatRoom].
extension ChatRoomX on ChatRoom {
  bool get isDeleted => deletedAt != null;

  bool get hasMessages => messageCount > 0;

  /// True when a message arrived after [userId] last opened the room.
  bool hasUnreadFor(String userId) {
    final last = lastMessageAt;
    if (last == null) {
      return false;
    }
    if (lastMessageSenderId == userId) {
      return false;
    }
    final seenAt = lastReadAt[userId];
    return seenAt == null || last.isAfter(seenAt);
  }
}
