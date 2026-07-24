import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'list_member.freezed.dart';
part 'list_member.g.dart';

/// Membership record at `shopping_lists/{listId}/members/{userId}`.
///
/// The document id is the member's uid. Profile fields are denormalised so a
/// member list renders without an extra read per collaborator; Cloud Functions
/// refresh them when the source profile changes.
@freezed
abstract class ListMember with _$ListMember {
  const factory ListMember({
    required String id,
    required String userId,
    required String listId,
    required MemberRole role,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default('') String displayName,
    @Default('') String email,
    String? photoUrl,
    @NullableTimestampConverter() DateTime? joinedAt,

    /// Who invited this member; null for the list creator.
    String? invitedBy,

    /// Denormalised per-member contribution counters, maintained by Cloud
    /// Functions and surfaced in list statistics.
    @Default(0) int itemsAdded,
    @Default(0) int itemsCompleted,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ListMember;

  factory ListMember.fromJson(Map<String, dynamic> json) =>
      _$ListMemberFromJson(json);
}

/// Derived properties of a [ListMember].
extension ListMemberX on ListMember {
  bool get isDeleted => deletedAt != null;

  bool get isOwner => role.isOwner;

  bool get canEditItems => role.canEditItems;

  bool get canCompleteItems => role.canCompleteItems;
}
