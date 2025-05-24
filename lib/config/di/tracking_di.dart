part of 'di.dart';

@module
abstract class TrackingModule {
  // Default tracking service implementation that combines Firebase and Sentry
  @Named(DIKey.trackingService)
  @lazySingleton
  AppTrackingService get trackingService => CompositeTrackingService([
        firebaseAnalyticsService,
        sentryTrackingService,
      ]);

  // Firebase Analytics Service
  @Named(DIKey.firebaseAnalyticsService)
  @lazySingleton
  AppTrackingService get firebaseAnalyticsService => FirebaseAnalyticsService();

  // Sentry Tracking Service
  @Named(DIKey.sentryTrackingService)
  @lazySingleton
  AppTrackingService get sentryTrackingService => SentryTrackingService();

  // NoOp Tracking Service for test or disabled environments
  @Named(DIKey.noOpTrackingService)
  @lazySingleton
  AppTrackingService get noOpTrackingService => NoOpTrackingService();

  // Composite Tracking Service for custom configurations
  @Named(DIKey.compositeTrackingService)
  @lazySingleton
  AppTrackingService get compositeTrackingService => CompositeTrackingService([]);
}

/// Manual configuration for tracking dependencies
void configureTrackingDependencies(GetIt sl) {
  // This can be used for more advanced registration requirements
  // that can't be handled by Injectable annotations
}

/// Dynamically replace the current tracking service implementation
///
/// This can be used to switch between tracking implementations at runtime
/// (for example, when user opts out of tracking)
void switchToNoOpTracking(GetIt sl) {
  // Get the existing implementation
  final current = sl.get<AppTrackingService>(instanceName: DIKey.trackingService);

  // Only replace if it's not already a NoOpTrackingService
  if (current is! NoOpTrackingService) {
    // Unregister current implementation
    sl.unregister<AppTrackingService>(instanceName: DIKey.trackingService);

    // Register new implementation
    sl.registerSingleton<AppTrackingService>(
      sl.get<AppTrackingService>(instanceName: DIKey.noOpTrackingService),
      instanceName: DIKey.trackingService,
    );
  }
}

/// Return to the default CompositeTrackingService implementation
void restoreDefaultTracking(GetIt sl) {
  // Get the existing implementation
  final current = sl.get<AppTrackingService>(instanceName: DIKey.trackingService);

  // Only replace if it's a NoOpTrackingService
  if (current is NoOpTrackingService) {
    // Unregister current implementation
    sl.unregister<AppTrackingService>(instanceName: DIKey.trackingService);

    // Register composite service with default services
    sl.registerSingleton<AppTrackingService>(
      CompositeTrackingService([
        sl.get<AppTrackingService>(instanceName: DIKey.firebaseAnalyticsService),
        sl.get<AppTrackingService>(instanceName: DIKey.sentryTrackingService),
      ]),
      instanceName: DIKey.trackingService,
    );
  }
}
