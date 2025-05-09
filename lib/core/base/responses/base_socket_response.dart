part of '../base.dart';

@Freezed(genericArgumentFactories: true)
sealed class BaseSocketResponse<T> with _$BaseSocketResponse<T> {
  const factory BaseSocketResponse({
    @Default('') String event,
    @Default('') String socket,
    T? data,
  }) = _BaseSocketResponseData;

  factory BaseSocketResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseSocketResponseFromJson(json, fromJsonT);
}