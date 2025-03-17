part of '../blocs.dart';

@lazySingleton
class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState.initial());

  void setIsDownloadSuccess(bool isDownloadSuccess) => emit(state.copyWith(isDownloadSuccess: isDownloadSuccess));
  void setReceived(int received) => emit(state.copyWith(received: received));
  void setTotal(int total) => emit(state.copyWith(total: total));
}
