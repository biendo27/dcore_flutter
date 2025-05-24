part of '../base.dart';

@Freezed(genericArgumentFactories: true)
sealed class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    @Default(false) bool status,
    @Default('') String message,
    @Default(0) int code,
    T? data,
  }) = _BaseResponseData;

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
sealed class BaseResponseList<T> with _$BaseResponseList<T> {
  const factory BaseResponseList({
    @Default(false) bool status,
    @Default('') String message,
    @Default(0) int code,
    @Default([]) List<T> data,
  }) = _BaseResponseListData;

  factory BaseResponseList.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseResponseListFromJson(json, fromJsonT);
}
