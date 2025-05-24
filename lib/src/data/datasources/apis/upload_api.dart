part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class UploadApi {
  @factoryMethod
  factory UploadApi(@Named(DIKey.appDio) Dio dio) = _UploadApi;

  @POST(AppEndpoint.upload)
  @MultiPart()
  Future<BaseResponseList<AppFile>> uploadFile(
    @Part(name: 'type') UploadType type,
    @Part(name: 'files[]') List<File> files,
  );
}
