import 'package:logger/logger.dart';

enum LogLevel { verbose, debug, info, warning, error, terribleFailure }

class AppLogger {
  static final AppLogger _appLogger = AppLogger._internal();

  factory AppLogger() => _appLogger;

  AppLogger._internal();

  final Logger _logger = Logger();

  void log({required String message, LogLevel logLevel = LogLevel.warning}) {
    switch (logLevel) {
      case LogLevel.verbose:
        _logger.v(message);
        break;
      case LogLevel.debug:
        _logger.d(message);
        break;
      case LogLevel.info:
        _logger.i(message);
        break;
      case LogLevel.warning:
        _logger.w(message);
        break;
      case LogLevel.error:
        _logger.e(message);
        break;
      case LogLevel.terribleFailure:
        _logger.wtf(message);
        break;
    }
  }
}
