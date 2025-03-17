part of 'responses.dart';

@Freezed(genericArgumentFactories: true)
sealed class BaseSocketResponse<T> with _$BaseSocketResponse {
  const factory BaseSocketResponse({
    @Default('') String event,
    @Default('') String socket,
    T? data,
  }) = _BaseSocketResponse;

  factory BaseSocketResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseSocketResponseFromJson(json, fromJsonT);
}
