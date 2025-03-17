part of '../blocs.dart';

@lazySingleton
class ReportCubit extends Cubit<ReportState> with CubitActionMixin<ReportState> {
  final IReportRepository _reportRepository;

  ReportCubit(this._reportRepository) : super(ReportState.initial());

  void setCurrentReport(Report report) => emit(state.copyWith(currentReport: report));

  Future<void> fetchReportList(ReportType type) async {
    executeListAction(
      action: () => _reportRepository.fetchReportList(type),
      onSuccess: (response) {
        emit(state.copyWith(reports: response.data));
      },
    );
  }

  Future<void> createReport(int typeId) async {
    executeAction(
      action: () => _reportRepository.createReport(
        typeId: typeId,
        type: state.currentReport.type,
        categoryId: state.currentReport.id,
      ),
      onSuccess: (response) {
        DMessage.showMessage(message: AppConfig.context!.text.reportSuccess, type: MessageType.success);
        AppConfig.context!.read<PostCubit>().removePostAfterReport(typeId);
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }
}
