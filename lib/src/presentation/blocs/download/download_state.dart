part of '../blocs.dart';


@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(false) bool isDownloadSuccess,
    @Default(0) int received,
    @Default(0) int total,
  }) = _DownloadState;
  factory DownloadState.initial() => const DownloadState();
}
