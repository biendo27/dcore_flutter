part of 'repositories.dart';

@LazySingleton(as: IReportRepository)
class ReportRepository with DataStateConvertible implements IReportRepository {
  final ReportApi _reportApi;
  ReportRepository(this._reportApi);

  @override
  Future<BaseResponseList<Report>> fetchReportList(ReportType type) {
    return requestList(apiCall: () => _reportApi.fetchReportList(type));
  }

  @override
  Future<BaseResponse<ReportResult>> createReport({int typeId = 0, ReportType type = ReportType.post, int categoryId = 0}) {
    return request(apiCall: () => _reportApi.createReport(typeId, type, categoryId));
  }
}
