part of '../models.dart';

@freezed
abstract class Report with _$Report {
  const factory Report({
    @Default(0) int id,
    @Default('') String name,
    @Default(ReportType.post) ReportType type,
    @Default(null) DateTime? createdAt,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}

@freezed
abstract class ReportResult with _$ReportResult {
  const factory ReportResult({
    @Default(0) int id,
    @Default(0) int typeId,
    @Default(ReportType.post) ReportType type,
    @Default(0) int categoryId,
    @Default(ReportStatus.pending) ReportStatus status,
    @Default(null) DateTime? createdAt,
  }) = _ReportResult;

  factory ReportResult.fromJson(Map<String, dynamic> json) => _$ReportResultFromJson(json);
}

enum ReportType {
  @JsonValue('post')
  post,
  @JsonValue('sound')
  sound,
  @JsonValue('comment')
  comment,
  @JsonValue('live')
  live,
  @JsonValue('product')
  product,
}

enum ReportStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
}
