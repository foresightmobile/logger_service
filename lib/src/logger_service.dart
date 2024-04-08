import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Class that wraps https://pub.dev/packages/logger for a common
/// interface should we decide to change implementations in future
class Log {
  /// Creates and configures the underlying logger implementation
  factory Log() {
    if (kDebugMode) {
      _logger ??= Logger(
        printer: printer ??= SimplePrinter(colors: _isColorEnabled),
      );
    }

    return _instance;
  }

  Log._internal();

  /// Enable/disable logging - useful for suppressing logging during unit tests
  static bool enabled = true;

  static bool get _isColorEnabled => !kIsWeb && !Platform.isIOS;

  static final Log _instance = Log._internal();

  static Logger? _logger;

  /// Default tag - replace with your own if required
  static String tag = 'default';

  /// Default stacktrace filter - add/replace with your own if required
  static List<RegExp> stacktraceFilters = [
    RegExp('^(.*logger_service.dart).*'),
    RegExp('^(.*<asynchronous suspension>).*'),
  ];

  /// Default printer - uses [SimplePrinter] if null
  static LogPrinter? printer = PrettyPrinter(
    colors: _isColorEnabled,
    methodCount: 3,
  );

  /// Log a message at level [Level.verbose].
  @Deprecated('[verbose] is being deprecated in favor of [trace].')
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.trace].
  void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.trace, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  @Deprecated('[wtf] is being deprecated in favor of [fatal].')
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.wtf, message, error, stackTrace);
  }

  /// Log a message at level [Level.fatal].
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.fatal, message, error, stackTrace);
  }

  void _log(
    Level level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (enabled) {
      // see https://github.com/leisim/logger/issues/98
      // ignore: parameter_assignments
      if (stackTrace != null) error = '$error\n$stackTrace';

      _logger?.log(
        level,
        '$tag: $message',
        error: error,
        stackTrace: stackTrace,
        // error,
        // stackTrace,
      );
    }
  }
}
