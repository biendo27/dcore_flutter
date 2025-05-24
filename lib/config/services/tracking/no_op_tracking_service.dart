part of '../services.dart';

/// A no-operation implementation of AppTrackingService that does nothing.
///
/// Useful for when tracking is disabled or in test environments.
class NoOpTrackingService implements AppTrackingService {
  @override
  Future<void> initialize() async {
    // Do nothing
    LogDev.info('NoOpTrackingService initialize');
  }

  @override
  Future<void> setUserId(String? userId) async {
    // Do nothing
    LogDev.info('NoOpTrackingService setUserId: $userId');
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    // Do nothing
    LogDev.info('NoOpTrackingService setUserProperties: $properties');
  }

  @override
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    // Do nothing
    LogDev.info('NoOpTrackingService trackEvent: $eventName');
  }

  @override
  Future<void> trackScreenView(
    String screenName, {
    String? screenClass,
  }) async {
    // Do nothing
    LogDev.info('NoOpTrackingService trackScreenView: $screenName');
  }

  @override
  Future<void> trackError(
    dynamic exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? errorType,
  }) async {
    // Do nothing
    LogDev.info('NoOpTrackingService trackError: $exception');
  }

  @override
  Future<void> addBreadcrumb(
    String message, {
    Map<String, dynamic>? data,
    String? category,
  }) async {
    // Do nothing
    LogDev.info('NoOpTrackingService addBreadcrumb: $message');
  }

  @override
  Future<void> resetUser() async {
    // Do nothing
    LogDev.info('NoOpTrackingService resetUser');
  }

  @override
  Future<void> setTrackingEnabled(bool isEnabled) async {
    // Do nothing
    LogDev.info('NoOpTrackingService setTrackingEnabled: $isEnabled');
  }
}
