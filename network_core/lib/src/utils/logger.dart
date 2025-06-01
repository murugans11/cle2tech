// In network_core/lib/src/utils/logger.dart
import 'package:logging/logging.dart' as logging;

// Re-define LogLevel to map to logging package's levels if desired, or use theirs directly.
// For simplicity, we can define our own and map them.
enum LogLevel {
  debug, // Fine-grained information, useful for debugging.
  info,  // General information about app operation.
  warning, // Potential issue or an unexpected event.
  error,   // Error that might not stop the app but should be addressed.
  fatal,   // Severe error causing the app to terminate or become unstable.
}

class Logger {
  final logging.Logger _logger;

  // Optional: Allow a custom name for the logger
  Logger({String name = 'NetworkCore'}) : _logger = logging.Logger(name) {
    // Initialize the logger (once per application or logger instance)
    _setupLogger();
  }

  // Keep track if setup has been done to avoid multiple subscriptions
  static bool _isLoggerSetup = false;

  void _setupLogger() {
    if (_isLoggerSetup) return;

    logging.Logger.root.level = logging.Level.ALL; // Log all levels by default
    logging.Logger.root.onRecord.listen((record) {
      // Customize log format here
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');

      // For complex objects passed in object field of LogRecord:
      if (record.object != null && record.object is Map && (record.object as Map).isNotEmpty) {
        print('  Context: ${record.object}');
      }
      if (record.error != null) {
        print('  Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        print('  StackTrace: ${record.stackTrace}');
      }
    });
    _isLoggerSetup = true;
  }

  void log(
    LogLevel level,
    String message, {
    dynamic data, // Will be passed as 'object' to LogRecord if not null
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? headers, // Custom handling for headers
    dynamic responseData,        // Custom handling for responseData
  }) {
    logging.Level loggingLevel;
    switch (level) {
      case LogLevel.debug:
        loggingLevel = logging.Level.CONFIG; // Or FINE, FINER, FINEST
        break;
      case LogLevel.info:
        loggingLevel = logging.Level.INFO;
        break;
      case LogLevel.warning:
        loggingLevel = logging.Level.WARNING;
        break;
      case LogLevel.error:
        loggingLevel = logging.Level.SEVERE;
        break;
      case LogLevel.fatal:
        loggingLevel = logging.Level.SHOUT;
        break;
      default:
        loggingLevel = logging.Level.INFO;
    }

    Map<String, dynamic> logContext = {};
    if (data != null) logContext['data'] = data;
    if (headers != null) logContext['headers'] = headers;
    if (responseData != null) logContext['responseData'] = responseData;

    _logger.log(loggingLevel, message, logContext.isEmpty ? null : logContext, error, stackTrace);
  }
}
