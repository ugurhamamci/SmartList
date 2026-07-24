import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'shared_link.freezed.dart';
part 'shared_link.g.dart';

/// A share link at `shared_links/{id}`.
///
/// Resolvable without authentication so that a recipient can open the link
/// before creating an account. The document deliberately exposes only the
/// target id and the grant it confers — never list contents — and redeeming it
/// still goes through the invitation Cloud Function, which enforces the grant.
@freezed
abstract class SharedLink with _$SharedLink {
  const factory SharedLink({
    required String id,
    required String listId,
    required MemberRole role,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,

    /// Short, URL-safe token embedded in the shareable URL.
    required String slug,
    @Default(true) bool isActive,

    /// Preview shown on the join screen before membership is granted.
    @Default('') String listTitle,
    @Default('🛒') String listEmoji,
    @Default(0) int useCount,

    /// Optional ceiling on redemptions; null means unlimited.
    int? maxUses,
    @NullableTimestampConverter() DateTime? expiresAt,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _SharedLink;

  factory SharedLink.fromJson(Map<String, dynamic> json) =>
      _$SharedLinkFromJson(json);
}

/// Derived properties of a [SharedLink].
extension SharedLinkX on SharedLink {
  bool get isDeleted => deletedAt != null;

  bool get isExpired {
    final expiry = expiresAt;
    return expiry != null && DateTime.now().toUtc().isAfter(expiry);
  }

  bool get isExhausted => maxUses != null && useCount >= maxUses!;

  /// A link is only redeemable while active, unexpired and under its cap.
  bool get isRedeemable => isActive && !isDeleted && !isExpired && !isExhausted;
}
