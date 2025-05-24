part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class ReportApi {
  @factoryMethod
  factory ReportApi(@Named(DIKey.appDio) Dio dio) = _ReportApi;

  @GET(AppEndpoint.reportList)
  Future<BaseResponseList<Report>> fetchReportList(@Query('category_type') ReportType type);

  @POST(AppEndpoint.reportCreate)
  Future<BaseResponse<ReportResult>> createReport(
    @Part(name: 'type_id') int typeId,
    @Part(name: 'type') ReportType type,
    @Part(name: 'category_id') int categoryId,
  );
}
