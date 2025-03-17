part of 'repositories.dart';

abstract interface class IReportRepository {
  Future<BaseResponseList<Report>> fetchReportList(ReportType type);
  Future<BaseResponse<ReportResult>> createReport({int typeId, ReportType type, int categoryId});
}
