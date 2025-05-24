part of '../helpers.dart';

mixin LogDev {
  static final Logger _logDev = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        stackTraceBeginIndex: 0,
        methodCount: 2,
        errorMethodCount: 2,
        lineLength: 120,
        // colors: stdout.supportsAnsiEscapes,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      debug: '🐛',
      info: '💡',
      warning: '🔶',
      error: '🚨',
      fatal: '💀',
      trace: '🔍',
    ),
    output: ConsoleOutput(),
  );

  static void info(String message) {
    if (kDebugMode) _logDev.i(message);
  }

  static void data(String message) {
    if (kDebugMode) _logDev.d(message);
  }

  static void warning(String message) {
    if (kDebugMode) _logDev.w(message);
  }

  static void error(String message) {
    if (kDebugMode) _logDev.e(message);
  }

  static void fatal(String message) {
    if (kDebugMode) _logDev.f(message);
  }

  static void trace(String message) {
    if (kDebugMode) _logDev.t(message);
  }

  static void one(String message) {
    if (kDebugMode) log(message, name: 'DLogDev');
  }
}
