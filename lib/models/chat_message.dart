import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// A chat message at `chat_rooms/{listId}/messages/{id}`.
///
/// [readBy] and [reactions] are maps rather than arrays so that concurrent
/// writers never clobber one another: each participant only ever touches their
/// own key, which merges cleanly.
@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String roomId,
    required String senderId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default(MessageType.text) MessageType type,
    @Default('') String body,

    /// Denormalised sender profile so history renders without extra reads.
    @Default('') String senderName,
    String? senderPhotoUrl,

    /// Storage download URL for an image or voice attachment.
    String? attachmentUrl,
    String? attachmentPath,
    @Default(0) int attachmentSizeBytes,

    /// Duration of a voice note, in milliseconds.
    @NullableDurationConverter() Duration? voiceDuration,

    /// Waveform samples used to draw a voice note, normalised to `0..1`.
    @Default(<double>[]) List<double> waveform,
    int? imageWidth,
    int? imageHeight,

    /// uid -> time the message was read.
    @Default(<String, DateTime>{})
    @TimestampMapConverter()
    Map<String, DateTime> readBy,

    /// uid -> emoji. One reaction per member.
    @Default(<String, String>{}) Map<String, String> reactions,

    /// Members mentioned in [body], used to raise mention notifications.
    @Default(<String>[]) List<String> mentions,

    /// Set when the message replies to another message in the room.
    String? replyToMessageId,
    @Default('') String replyToPreview,
    @Default(false) bool isEdited,
    @NullableTimestampConverter() DateTime? editedAt,

    /// Populated for [MessageType.system] messages so the client can render a
    /// localized sentence rather than server-generated English.
    ActivityAction? systemAction,
    @Default(<String, String>{}) Map<String, String> systemParams,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

/// Derived properties of a [ChatMessage].
extension ChatMessageX on ChatMessage {
  bool get isDeleted => deletedAt != null;

  bool get isSystem => type == MessageType.system;

  bool get hasAttachment => attachmentUrl != null && attachmentUrl!.isNotEmpty;

  bool get hasReactions => reactions.isNotEmpty;

  bool isAuthoredBy(String userId) => senderId == userId;

  bool isReadBy(String userId) => readBy.containsKey(userId);

  /// True once every participant other than the sender has read the message.
  bool isSeenByAll(Iterable<String> participantIds) {
    final others = participantIds.where((id) => id != senderId);
    return others.isNotEmpty && others.every(readBy.containsKey);
  }

  /// Reaction emoji mapped to the members who chose it.
  Map<String, List<String>> get reactionGroups {
    final grouped = <String, List<String>>{};
    for (final entry in reactions.entries) {
      grouped.putIfAbsent(entry.value, () => <String>[]).add(entry.key);
    }
    return grouped;
  }

  String? reactionOf(String userId) => reactions[userId];
}
