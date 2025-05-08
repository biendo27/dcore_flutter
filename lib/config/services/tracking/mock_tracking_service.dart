part of '../services.dart';

/// A mock implementation of AppTrackingService for testing.
///
/// Records all tracking calls for verification in tests.
class MockTrackingService implements AppTrackingService {
  bool _isEnabled = true;

  // Capture calls for verification in tests
  final List<String> userIds = [];
  final List<Map<String, dynamic>> userProperties = [];
  final List<TrackedEvent> events = [];
  final List<TrackedScreenView> screenViews = [];
  final List<TrackedError> errors = [];
  final List<TrackedBreadcrumb> breadcrumbs = [];
  bool wasInitialized = false;
  bool wasReset = false;

  @override
  Future<void> initialize() async {
    if (!_isEnabled) return;
    wasInitialized = true;
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_isEnabled) return;
    userIds.add(userId ?? '');
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isEnabled) return;
    userProperties.add(Map.from(properties));
  }

  @override
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isEnabled) return;
    events.add(TrackedEvent(
      name: eventName,
      parameters: parameters != null ? Map.from(parameters) : null,
    ));
  }

  @override
  Future<void> trackScreenView(
    String screenName, {
    String? screenClass,
  }) async {
    if (!_isEnabled) return;
    screenViews.add(TrackedScreenView(
      name: screenName,
      screenClass: screenClass,
    ));
  }

  @override
  Future<void> trackError(
    dynamic exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? errorType,
  }) async {
    if (!_isEnabled) return;
    errors.add(TrackedError(
      exception: exception,
      errorType: errorType,
    ));
  }

  @override
  Future<void> addBreadcrumb(
    String message, {
    Map<String, dynamic>? data,
    String? category,
  }) async {
    if (!_isEnabled) return;
    breadcrumbs.add(TrackedBreadcrumb(
      message: message,
      category: category,
    ));
  }

  @override
  Future<void> resetUser() async {
    if (!_isEnabled) return;
    wasReset = true;
    userIds.clear();
    userProperties.clear();
  }

  @override
  Future<void> setTrackingEnabled(bool isEnabled) async {
    _isEnabled = isEnabled;
  }

  /// Clear all recorded tracking data
  void reset() {
    userIds.clear();
    userProperties.clear();
    events.clear();
    screenViews.clear();
    errors.clear();
    breadcrumbs.clear();
    wasInitialized = false;
    wasReset = false;
  }

  /// Check if an event with the given name was tracked
  bool hasTrackedEvent(String eventName) {
    return events.any((event) => event.name == eventName);
  }

  /// Get all events with the given name
  List<TrackedEvent> getEvents(String eventName) {
    return events.where((event) => event.name == eventName).toList();
  }

  /// Check if a screen with the given name was viewed
  bool hasTrackedScreen(String screenName) {
    return screenViews.any((screen) => screen.name == screenName);
  }

  /// Check if an error of the given type was tracked
  bool hasTrackedError(String? errorType) {
    return errors.any((error) => error.errorType == errorType);
  }
}

/// Represents a tracked event for testing
class TrackedEvent {
  final String name;
  final Map<String, dynamic>? parameters;

  TrackedEvent({required this.name, this.parameters});
}

/// Represents a tracked screen view for testing
class TrackedScreenView {
  final String name;
  final String? screenClass;

  TrackedScreenView({required this.name, this.screenClass});
}

/// Represents a tracked error for testing
class TrackedError {
  final dynamic exception;
  final String? errorType;

  TrackedError({required this.exception, this.errorType});
}

/// Represents a tracked breadcrumb for testing
class TrackedBreadcrumb {
  final String message;
  final String? category;

  TrackedBreadcrumb({required this.message, this.category});
}
