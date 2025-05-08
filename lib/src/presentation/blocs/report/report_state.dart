part of '../blocs.dart';

@freezed
abstract class ReportState with _$ReportState {
  const factory ReportState({
    @Default(false) bool isLoading,
    @Default([]) List<Report> reports,
    @Default(Report()) Report currentReport,
  }) = _ReportState;

  factory ReportState.initial() => const ReportState();
}
