part of '../base.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.server([String? message]) = _ServerFailure;
  const factory Failure.connection([String? message]) = _ConnectionFailure;
  const factory Failure.database([String? message]) = _DatabaseFailure;
  const factory Failure.cache([String? message]) = _CacheFailure;
  const factory Failure.notFound([String? message]) = _NotFoundFailure;
  const factory Failure.unauthorized([String? message]) = _UnauthorizedFailure;
  const factory Failure.invalidInput([String? message]) = _InvalidInputFailure;
  const factory Failure.unexpected([String? message]) = _UnexpectedFailure;
  const factory Failure.forbidden([String? message]) = _ForbiddenFailure;
  const factory Failure.pending([String? message]) = _PendingFailure;
  const factory Failure.fromDioException(DioException error) = _FromDioExceptionFailure;
}
