import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts a Firestore `Timestamp` to a UTC [DateTime].
///
/// A field written with `FieldValue.serverTimestamp()` reads back as `null`
/// from the local cache until the server acknowledges the write. Because
/// `createdAt` and `updatedAt` are non-nullable in the domain model, a pending
/// value resolves to the current time so that optimistic UI keeps a sensible
/// ordering; the authoritative server value replaces it on the next snapshot.
class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    return _parse(json) ?? DateTime.now().toUtc();
  }

  /// Serialisation emits a [Timestamp]; repositories substitute
  /// `FieldValue.serverTimestamp()` for audit fields before writing.
  @override
  Object toJson(DateTime object) => Timestamp.fromDate(object);
}

/// Nullable counterpart of [TimestampConverter]; preserves `null`.
class NullableTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Object? json) => _parse(json);

  @override
  Object? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

/// Accepts every wire representation a timestamp can arrive in: a Firestore
/// [Timestamp] from a snapshot, an ISO-8601 string or epoch milliseconds from
/// the Hive cache, or a [DateTime] from an in-memory fixture.
DateTime? _parse(Object? json) {
  return switch (json) {
    null => null,
    final Timestamp value => value.toDate().toUtc(),
    final DateTime value => value.toUtc(),
    final int value => DateTime.fromMillisecondsSinceEpoch(
      value,
      isUtc: true,
    ).toUtc(),
    final String value => DateTime.tryParse(value)?.toUtc(),
    // A pending server timestamp surfaces as a FieldValue sentinel.
    _ => null,
  };
}

/// Converts a `uid -> Timestamp` map, the shape used for read receipts and
/// per-member "last opened" markers.
///
/// A map keyed by uid is preferred over a parallel array because each writer
/// only ever touches their own key, so concurrent updates merge instead of
/// overwriting one another.
class TimestampMapConverter
    implements JsonConverter<Map<String, DateTime>, Object?> {
  const TimestampMapConverter();

  @override
  Map<String, DateTime> fromJson(Object? json) {
    if (json is! Map) {
      return const <String, DateTime>{};
    }
    final result = <String, DateTime>{};
    for (final entry in json.entries) {
      final key = entry.key;
      final value = _parse(entry.value);
      if (key is String && value != null) {
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Object toJson(Map<String, DateTime> object) => object.map(
    (key, value) => MapEntry(key, Timestamp.fromDate(value)),
  );
}

/// Serialises a [Duration] as whole milliseconds.
class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}

/// Nullable counterpart of [DurationConverter].
class NullableDurationConverter implements JsonConverter<Duration?, int?> {
  const NullableDurationConverter();

  @override
  Duration? fromJson(int? json) =>
      json == null ? null : Duration(milliseconds: json);

  @override
  int? toJson(Duration? object) => object?.inMilliseconds;
}

/// Tolerates integers arriving as doubles, which Firestore does for values
/// that were written as `1.0` and for aggregation results.
class FlexibleIntConverter implements JsonConverter<int, Object?> {
  const FlexibleIntConverter();

  @override
  int fromJson(Object? json) => switch (json) {
    final int value => value,
    final double value => value.round(),
    final String value => int.tryParse(value) ?? 0,
    _ => 0,
  };

  @override
  Object toJson(int object) => object;
}

/// Tolerates doubles arriving as integers, which Firestore does for whole
/// numbers such as a price of `12`.
class FlexibleDoubleConverter implements JsonConverter<double, Object?> {
  const FlexibleDoubleConverter();

  @override
  double fromJson(Object? json) => switch (json) {
    final double value => value,
    final int value => value.toDouble(),
    final String value => double.tryParse(value) ?? 0,
    _ => 0,
  };

  @override
  Object toJson(double object) => object;
}

/// Nullable counterpart of [FlexibleDoubleConverter]; preserves `null` so that
/// "no price recorded" stays distinguishable from a price of zero.
class NullableDoubleConverter implements JsonConverter<double?, Object?> {
  const NullableDoubleConverter();

  @override
  double? fromJson(Object? json) => switch (json) {
    null => null,
    final double value => value,
    final int value => value.toDouble(),
    final String value => double.tryParse(value),
    _ => null,
  };

  @override
  Object? toJson(double? object) => object;
}
