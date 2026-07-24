import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/config/feature_flags.dart';
import 'package:smartlist/core/utils/json_converters.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// A SmartList account, stored at `users/{id}`.
///
/// Entitlement fields ([isPremium], [subscriptionTier]) are writable only by
/// the backend; the security rules reject any client attempt to change them.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String displayName,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    String? photoUrl,
    String? phoneNumber,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPremium,
    @Default(SubscriptionTier.free) SubscriptionTier subscriptionTier,
    @Default(false) bool isOnline,
    @NullableTimestampConverter() DateTime? lastSeenAt,
    @Default('en') String locale,
    String? timezone,

    /// Identity providers linked to the account, e.g. `password`, `google.com`,
    /// `apple.com`.
    @Default(<String>[]) List<String> providerIds,

    /// Denormalised counters maintained by Cloud Functions; cheap to render on
    /// the profile screen without fanning out reads.
    @Default(0) int listCount,
    @Default(0) int completedItemCount,

    /// Number of AI generations consumed in the current billing month, used to
    /// enforce the free-plan ceiling.
    @Default(0) int aiGenerationsThisMonth,
    @NullableTimestampConverter() DateTime? aiQuotaResetAt,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

/// Convenience predicates over an [AppUser].
extension AppUserX on AppUser {
  /// Capabilities granted by the account's current tier.
  Set<FeatureFlag> get entitlements => subscriptionTier.entitlements;

  bool can(FeatureFlag flag) => subscriptionTier.grants(flag);

  bool get isDeleted => deletedAt != null;

  /// Initials shown when no avatar has been uploaded.
  String get initials {
    final source = displayName.trim().isEmpty ? email : displayName.trim();
    final parts = source
        .split(RegExp(r'[\s@._-]+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts[1].substring(0, 1))
        .toUpperCase();
  }

  bool get hasPasswordProvider => providerIds.contains('password');
}
