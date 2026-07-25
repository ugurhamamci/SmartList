import 'package:json_annotation/json_annotation.dart';

/// Postgres `timestamptz` degerini UTC [DateTime]'a cevirir.
///
/// PostgREST zaman damgalarini ISO-8601 metin olarak dondurur. Alan zorunlu
/// oldugu icin cozulemeyen bir deger simdiki zamana dusuyor: iyimser arayuz
/// siralamasi bozulmasin, sunucudan gelen dogru deger sonraki okumada yerine
/// gecsin.
class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    return _parse(json) ?? DateTime.now().toUtc();
  }

  /// ISO-8601 (UTC) olarak yazilir. Denetim alanlarini (`created_at`,
  /// `updated_at`) istemci hic gondermiyor; onlari veritabani trigger'i
  /// damgaliyor, boylece cihaz saati yanlis olsa bile kayit dogru kalir.
  @override
  Object toJson(DateTime object) => object.toUtc().toIso8601String();
}

/// Nullable counterpart of [TimestampConverter]; preserves `null`.
class NullableTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Object? json) => _parse(json);

  @override
  Object? toJson(DateTime? object) => object?.toUtc().toIso8601String();
}

/// Bir zaman damgasinin gelebilecegi her bicimi kabul eder: PostgREST'ten
/// ISO-8601 metin, Hive onbelleginden epoch milisaniye, bellekteki bir
/// ornekten dogrudan [DateTime].
DateTime? _parse(Object? json) {
  return switch (json) {
    null => null,
    final DateTime value => value.toUtc(),
    final int value => DateTime.fromMillisecondsSinceEpoch(
      value,
      isUtc: true,
    ).toUtc(),
    final String value => DateTime.tryParse(value)?.toUtc(),
    _ => null,
  };
}

/// `uid -> zaman damgasi` haritasini cevirir; okundu bilgisi ve uye basina
/// "en son ne zaman acti" isaretleri bu bicimde tutuluyor. Veritabaninda
/// `jsonb` sutunu.
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
    (key, value) => MapEntry(key, value.toUtc().toIso8601String()),
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

/// Tam sayinin ondalik olarak gelmesini tolere eder. PostgREST `numeric`
/// sutunlarini bazen `1.0` bicimde, bazen metin olarak dondurur.
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

/// Ondalik sayinin tam sayi olarak gelmesini tolere eder: `numeric(12,2)`
/// sutunundaki `12` degeri JSON'da `12` olarak geliyor.
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
