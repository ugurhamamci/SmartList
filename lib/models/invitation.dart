import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'invitation.freezed.dart';
part 'invitation.g.dart';

/// An invitation at `shopping_lists/{listId}/invitations/{id}`.
///
/// Addressed by email so it can be created before the invitee has an account;
/// [inviteeId] is filled in when the invitation is accepted.
@freezed
abstract class Invitation with _$Invitation {
  const factory Invitation({
    required String id,
    required String listId,
    required String inviteeEmail,
    required String invitedBy,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default(MemberRole.editor) MemberRole role,
    @Default(InvitationStatus.pending) InvitationStatus status,
    String? inviteeId,

    /// Denormalised so the invite card renders before the list is readable.
    @Default('') String listTitle,
    @Default('🛒') String listEmoji,
    @Default('') String inviterName,
    String? inviterPhotoUrl,
    @NullableTimestampConverter() DateTime? respondedAt,
    @NullableTimestampConverter() DateTime? revokedAt,
    @NullableTimestampConverter() DateTime? expiresAt,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);
}

/// Derived properties of an [Invitation].
extension InvitationX on Invitation {
  bool get isDeleted => deletedAt != null;

  bool get isExpired {
    final expiry = expiresAt;
    return expiry != null && DateTime.now().toUtc().isAfter(expiry);
  }

  /// Only a pending, unexpired invitation can be accepted or declined.
  bool get isActionable => status.isActionable && !isExpired;
}
