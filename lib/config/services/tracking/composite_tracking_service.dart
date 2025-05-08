part of '../services.dart';

/// A composite implementation of AppTrackingService that delegates
/// to multiple tracking services.
///
/// This allows using multiple tracking providers simultaneously
/// (e.g., both Firebase Analytics and Sentry).
class CompositeTrackingService implements AppTrackingService {
  final List<AppTrackingService> _services;
  bool _isEnabled = true;

  CompositeTrackingService(this._services);

  @override
  Future<void> initialize() async {
    if (!_isEnabled) return;

    // Initialize all services
    for (final service in _services) {
      await service.initialize();
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_isEnabled) return;

    // Set user ID on all services
    for (final service in _services) {
      await service.setUserId(userId);
    }
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isEnabled) return;

    // Set properties on all services
    for (final service in _services) {
      await service.setUserProperties(properties);
    }
  }

  @override
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isEnabled) return;

    // Track event on all services
    for (final service in _services) {
      await service.trackEvent(eventName, parameters: parameters);
    }
  }

  @override
  Future<void> trackScreenView(
    String screenName, {
    String? screenClass,
  }) async {
    if (!_isEnabled) return;

    // Track screen view on all services
    for (final service in _services) {
      await service.trackScreenView(screenName, screenClass: screenClass);
    }
  }

  @override
  Future<void> trackError(
    dynamic exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? errorType,
  }) async {
    if (!_isEnabled) return;

    // Track error on all services
    for (final service in _services) {
      await service.trackError(
        exception,
        stackTrace: stackTrace,
        context: context,
        errorType: errorType,
      );
    }
  }

  @override
  Future<void> addBreadcrumb(
    String message, {
    Map<String, dynamic>? data,
    String? category,
  }) async {
    if (!_isEnabled) return;

    // Add breadcrumb to all services
    for (final service in _services) {
      await service.addBreadcrumb(message, data: data, category: category);
    }
  }

  @override
  Future<void> resetUser() async {
    if (!_isEnabled) return;

    // Reset user on all services
    for (final service in _services) {
      await service.resetUser();
    }
  }

  @override
  Future<void> setTrackingEnabled(bool isEnabled) async {
    _isEnabled = isEnabled;

    // Set tracking enabled status on all services
    for (final service in _services) {
      await service.setTrackingEnabled(isEnabled);
    }
  }

  /// Add a new tracking service to the composite
  void addTrackingService(AppTrackingService service) {
    _services.add(service);

    // Initialize the new service if tracking is enabled
    if (_isEnabled) {
      service.initialize();
    }
  }

  /// Remove a tracking service from the composite
  void removeTrackingService(AppTrackingService service) {
    _services.remove(service);
  }
}
