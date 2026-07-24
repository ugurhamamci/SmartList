import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'device_token.freezed.dart';
part 'device_token.g.dart';

/// An FCM registration at `users/{userId}/device_tokens/{id}`.
///
/// The document id is a stable per-installation identifier rather than the FCM
/// token itself, so token rotation updates one document instead of accumulating
/// stale rows. Cloud Functions prune registrations that FCM reports as
/// unregistered.
@freezed
abstract class DeviceToken with _$DeviceToken {
  const factory DeviceToken({
    required String id,
    required String userId,
    required String token,
    required DevicePlatform platform,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(true) bool isActive,
    @Default('') String deviceModel,
    @Default('') String osVersion,
    @Default('') String appVersion,
    @Default('en') String locale,
    @Default('') String timezone,
    @NullableTimestampConverter() DateTime? lastUsedAt,
  }) = _DeviceToken;

  factory DeviceToken.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenFromJson(json);
}
