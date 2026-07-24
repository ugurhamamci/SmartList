import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'voice_command.freezed.dart';
part 'voice_command.g.dart';

/// One product extracted from a spoken phrase.
///
/// [confidence] is carried through so the review sheet can flag a low-certainty
/// parse for confirmation instead of silently adding a wrong item.
@freezed
abstract class ParsedVoiceItem with _$ParsedVoiceItem {
  const factory ParsedVoiceItem({
    required String name,
    @Default(1) @FlexibleDoubleConverter() double quantity,
    @Default(MeasurementUnit.piece) MeasurementUnit unit,
    String? categoryId,
    @Default(ItemPriority.normal) ItemPriority priority,
    @Default(1) @FlexibleDoubleConverter() double confidence,

    /// Substring of the transcript this item was derived from.
    @Default('') String sourcePhrase,
  }) = _ParsedVoiceItem;

  factory ParsedVoiceItem.fromJson(Map<String, dynamic> json) =>
      _$ParsedVoiceItemFromJson(json);
}

/// A voice capture at `users/{userId}/voice_commands/{id}`.
///
/// Retained so a mis-parse can be reviewed and corrected, and so the parser can
/// be evaluated against real phrasing.
@freezed
abstract class VoiceCommand with _$VoiceCommand {
  const factory VoiceCommand({
    required String id,
    required String userId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(VoiceCommandStatus.listening) VoiceCommandStatus status,
    @Default('') String transcript,
    @Default('en') String localeId,
    @Default(1) @FlexibleDoubleConverter() double confidence,
    @Default(<ParsedVoiceItem>[]) List<ParsedVoiceItem> parsedItems,

    /// List the items were added to once the parse was accepted.
    String? listId,

    /// Ids of the items actually created, so the action can be undone.
    @Default(<String>[]) List<String> createdItemIds,

    /// Failure reason when [status] is `failed`, as an `AppException` code.
    String? errorCode,
    @NullableDurationConverter() Duration? captureDuration,
  }) = _VoiceCommand;

  factory VoiceCommand.fromJson(Map<String, dynamic> json) =>
      _$VoiceCommandFromJson(json);
}

/// Derived properties of a [VoiceCommand].
extension VoiceCommandX on VoiceCommand {
  bool get hasTranscript => transcript.trim().isNotEmpty;

  bool get hasItems => parsedItems.isNotEmpty;

  bool get isApplied => status == VoiceCommandStatus.applied;

  /// Items whose parse is uncertain enough to warrant explicit confirmation.
  List<ParsedVoiceItem> get lowConfidenceItems =>
      parsedItems.where((item) => item.confidence < 0.6).toList();
}
