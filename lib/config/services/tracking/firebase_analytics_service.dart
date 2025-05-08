part of '../services.dart';

class FirebaseAnalyticsService implements AppTrackingService {
  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;
  bool _isEnabled = true;

  FirebaseAnalyticsService({
    FirebaseAnalytics? analytics,
    FirebaseCrashlytics? crashlytics,
  })  : _analytics = analytics ?? FirebaseAnalytics.instance,
        _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  @override
  Future<void> initialize() async {
    // Enable collection if allowed by user
    await _crashlytics.setCrashlyticsCollectionEnabled(_isEnabled);
    await _analytics.setAnalyticsCollectionEnabled(_isEnabled);

    // Set up automatic screen tracking if needed
    // await _analytics.setAutomaticScreenReportingEnabled(true);
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_isEnabled) return;

    if (userId != null) {
      await _analytics.setUserId(id: userId);
      await _crashlytics.setUserIdentifier(userId);
    } else {
      await _analytics.setUserId(id: null);
      await _crashlytics.setUserIdentifier('');
    }
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isEnabled) return;

    // Set analytics user properties
    for (final entry in properties.entries) {
      if (entry.value != null) {
        await _analytics.setUserProperty(
          name: entry.key,
          value: entry.value.toString(),
        );
      }
    }

    // Set crashlytics custom keys
    for (final entry in properties.entries) {
      if (entry.value != null) {
        await _crashlytics.setCustomKey(entry.key, entry.value.toString());
      }
    }
  }

  @override
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isEnabled) return;

    // Firebase has naming restrictions for events and parameters
    final sanitizedParams = parameters != null ? _sanitizeParameters(parameters) : null;

    await _analytics.logEvent(
      name: _sanitizeEventName(eventName),
      parameters: sanitizedParams as Map<String, Object>?,
    );
  }

  @override
  Future<void> trackScreenView(
    String screenName, {
    String? screenClass,
  }) async {
    if (!_isEnabled) return;

    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  @override
  Future<void> trackError(
    dynamic exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? errorType,
  }) async {
    if (!_isEnabled) return;

    // Set extra context if available
    if (context != null) {
      for (final entry in context.entries) {
        await _crashlytics.setCustomKey(entry.key, entry.value.toString());
      }
    }

    if (errorType != null) {
      await _crashlytics.setCustomKey('error_type', errorType);
    }

    // Log to Firebase Analytics
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error_message': exception.toString(),
        if (errorType != null) 'error_type': errorType,
      },
    );

    // Log to Crashlytics (non-fatal)
    await _crashlytics.recordError(
      exception,
      stackTrace,
      reason: errorType,
      fatal: false,
    );
  }

  @override
  Future<void> addBreadcrumb(
    String message, {
    Map<String, dynamic>? data,
    String? category,
  }) async {
    if (!_isEnabled) return;

    await _crashlytics.log(message);

    if (data != null) {
      final dataString = data.entries.map((e) => '${e.key}: ${e.value}').join(', ');

      await _crashlytics.log('$message - $dataString');
    }
  }

  @override
  Future<void> resetUser() async {
    if (!_isEnabled) return;

    await _analytics.setUserId(id: null);
    await _crashlytics.setUserIdentifier('');

    // Reset custom keys/properties
    // Note: Firebase doesn't have a direct method to clear all properties
    // You may need to set important ones to null or a default value
  }

  @override
  Future<void> setTrackingEnabled(bool isEnabled) async {
    _isEnabled = isEnabled;
    await _crashlytics.setCrashlyticsCollectionEnabled(isEnabled);
    await _analytics.setAnalyticsCollectionEnabled(isEnabled);
  }

  // Helper methods for Firebase naming restrictions
  String _sanitizeEventName(String name) {
    // Firebase event names must be <= 40 chars, alphanumeric + underscores
    final sanitized = name.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').replaceAll(RegExp(r'__+'), '_');

    return sanitized.length > 40 ? sanitized.substring(0, 40) : sanitized;
  }

  Map<String, dynamic> _sanitizeParameters(Map<String, dynamic> parameters) {
    final result = <String, dynamic>{};

    for (final entry in parameters.entries) {
      // Firebase parameter names must be <= 40 chars, alphanumeric + underscores
      final key = entry.key.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').replaceAll(RegExp(r'__+'), '_');

      final sanitizedKey = key.length > 40 ? key.substring(0, 40) : key;

      // Convert values to types supported by Firebase
      result[sanitizedKey] = _convertToSupportedType(entry.value);
    }

    return result;
  }

  dynamic _convertToSupportedType(dynamic value) {
    if (value == null) return null;
    if (value is String || value is num || value is bool) return value;
    return value.toString();
  }
}
