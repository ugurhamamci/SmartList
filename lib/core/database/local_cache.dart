import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:smartlist/core/constants/app_constants.dart';
import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/utils/app_logger.dart';

/// Hive-backed offline cache.
///
/// Documents are stored as JSON maps rather than through generated
/// `TypeAdapter`s: the models already serialise via `json_serializable`, and a
/// schema-free payload means adding a field never requires a cache migration or
/// invalidates a user's offline data.
///
/// Firestore's own persistence already serves reads while offline. This cache
/// exists for the cases Firestore does not cover: rendering the first frame
/// before a listener attaches, and surviving a signed-out cold start. It is
/// always treated as disposable, so a read failure degrades to a cache miss
/// rather than an error the user sees.
class LocalCache {
  const LocalCache();

  /// Opens every box up front so later reads are synchronous.
  static Future<void> initialize() async {
    await Hive.initFlutter('smartlist');
    for (final name in HiveBoxes.all) {
      if (!Hive.isBoxOpen(name)) {
        await Hive.openBox<String>(name);
      }
    }
  }

  Box<String> _box(String name) {
    if (!Hive.isBoxOpen(name)) {
      throw CacheException(details: 'Box "$name" was not opened');
    }
    return Hive.box<String>(name);
  }

  /// Reads one document, or `null` on a miss or unreadable payload.
  Map<String, dynamic>? read(String boxName, String key) {
    try {
      final raw = _box(boxName).get(key);
      if (raw == null) {
        return null;
      }
      return jsonDecode(raw) as Map<String, dynamic>;
    } on Object catch (error) {
      AppLogger.warn('Cache read failed for $boxName/$key', error);
      return null;
    }
  }

  /// Reads every document in a box, skipping entries that fail to decode.
  List<Map<String, dynamic>> readAll(String boxName) {
    try {
      final box = _box(boxName);
      final results = <Map<String, dynamic>>[];
      for (final raw in box.values) {
        try {
          results.add(jsonDecode(raw) as Map<String, dynamic>);
        } on Object catch (error) {
          AppLogger.warn('Skipping corrupt cache entry in $boxName', error);
        }
      }
      return results;
    } on Object catch (error) {
      AppLogger.warn('Cache readAll failed for $boxName', error);
      return const [];
    }
  }

  Future<void> write(
    String boxName,
    String key,
    Map<String, dynamic> value,
  ) async {
    try {
      await _box(boxName).put(key, jsonEncode(value));
    } on Object catch (error) {
      AppLogger.warn('Cache write failed for $boxName/$key', error);
    }
  }

  /// Replaces the contents of a box in one transaction.
  Future<void> writeAll(
    String boxName,
    Map<String, Map<String, dynamic>> entries,
  ) async {
    try {
      final encoded = entries.map(
        (key, value) => MapEntry(key, jsonEncode(value)),
      );
      await _box(boxName).putAll(encoded);
    } on Object catch (error) {
      AppLogger.warn('Cache writeAll failed for $boxName', error);
    }
  }

  Future<void> delete(String boxName, String key) async {
    try {
      await _box(boxName).delete(key);
    } on Object catch (error) {
      AppLogger.warn('Cache delete failed for $boxName/$key', error);
    }
  }

  Future<void> clearBox(String boxName) async {
    try {
      await _box(boxName).clear();
    } on Object catch (error) {
      AppLogger.warn('Cache clear failed for $boxName', error);
    }
  }

  /// Drops every cached document. Called on sign-out so that one user's data
  /// never surfaces in another's session on a shared device.
  Future<void> clearAll() async {
    for (final name in HiveBoxes.all) {
      if (name != HiveBoxes.preferences) {
        await clearBox(name);
      }
    }
  }

  // ------------------------------------------------------------ preferences

  String? readPreference(String key) {
    try {
      return _box(HiveBoxes.preferences).get(key);
    } on Object catch (error) {
      AppLogger.warn('Preference read failed for $key', error);
      return null;
    }
  }

  Future<void> writePreference(String key, String value) async {
    try {
      await _box(HiveBoxes.preferences).put(key, value);
    } on Object catch (error) {
      AppLogger.warn('Preference write failed for $key', error);
    }
  }

  Future<void> deletePreference(String key) async {
    try {
      await _box(HiveBoxes.preferences).delete(key);
    } on Object catch (error) {
      AppLogger.warn('Preference delete failed for $key', error);
    }
  }
}
