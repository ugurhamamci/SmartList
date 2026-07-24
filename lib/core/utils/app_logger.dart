import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Application logger.
///
/// Verbose output is suppressed outside development so that release builds do
/// not leak user content into device logs. Errors are still recorded, and
/// `CrashReporter` forwards them to Crashlytics.
abstract final class AppLogger {
  static Logger _logger = _build(verbose: kDebugMode);

  /// Reconfigures the sink once `AppConfig` has been resolved.
  static void configure({required bool verbose}) {
    _logger = _build(verbose: verbose);
  }

  static Logger _build({required bool verbose}) {
    return Logger(
      filter: _LevelFilter(verbose ? Level.trace : Level.warning),
      printer: PrettyPrinter(
        colors: false,
        printEmojis: false,
        methodCount: verbose ? 2 : 0,
        lineLength: 100,
      ),
      output: ConsoleOutput(),
    );
  }

  static void trace(String message) => _logger.t(message);

  static void debug(String message) => _logger.d(message);

  static void info(String message) => _logger.i(message);

  static void warn(String message, [Object? error]) =>
      _logger.w(message, error: error);

  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  static void fatal(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}

/// Emits every event at or above [minimum]; `Logger`'s default filter drops
/// everything in release mode, which would hide production errors.
class _LevelFilter extends LogFilter {
  _LevelFilter(this.minimum);

  final Level minimum;

  @override
  bool shouldLog(LogEvent event) => event.level.index >= minimum.index;
}
