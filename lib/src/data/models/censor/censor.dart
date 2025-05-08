part of '../models.dart';

@freezed
abstract class Censor with _$Censor {
  const factory Censor({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String description,
    @Default(0) int pointMax,
  }) = _Censor;

  factory Censor.fromJson(Map<String, dynamic> json) => _$CensorFromJson(json);
}

@freezed
abstract class CensorResult with _$CensorResult {
  const factory CensorResult({
    @Default(0) int value,
    @Default(Censor()) Censor censor,
  }) = _CensorResult;

  factory CensorResult.fromJson(Map<String, dynamic> json) => _$CensorResultFromJson(json);
}

extension CensorX on Censor {
  CensorResult get toCensorResult {
    return CensorResult(
      value: 0,
      censor: this,
    );
  }
}
