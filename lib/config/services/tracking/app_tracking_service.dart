part of '../services.dart';

/// Interface for application tracking services
///
/// Provides a consistent API for tracking events, errors,
/// screen views and user attributes across different
/// analytics and error reporting providers.
abstract class AppTrackingService {
  /// Initialize the tracking service
  Future<void> initialize();

  /// Set a user identifier for associating events with a specific user
  Future<void> setUserId(String? userId);

  /// Set user properties/attributes that apply to all future events
  Future<void> setUserProperties(Map<String, dynamic> properties);

  /// Track a specific event with optional parameters
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  });

  /// Log when a screen is viewed
  Future<void> trackScreenView(
    String screenName, {
    String? screenClass,
  });

  /// Track an error or exception
  Future<void> trackError(
    dynamic exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? errorType,
  });

  /// Add a breadcrumb to help with error context
  Future<void> addBreadcrumb(
    String message, {
    Map<String, dynamic>? data,
    String? category,
  });

  /// Reset all user data (for logout/privacy)
  Future<void> resetUser();

  /// Enable or disable tracking
  Future<void> setTrackingEnabled(bool isEnabled);
}
