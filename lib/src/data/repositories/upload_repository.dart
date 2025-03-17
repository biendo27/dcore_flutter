part of 'repositories.dart';

@LazySingleton(as: IUploadRepository)
class UploadRepository with DataStateConvertible implements IUploadRepository {
  final UploadApi _uploadApi;
  UploadRepository(this._uploadApi);

  @override
  Future<BaseResponseList<AppFile>> uploadFile(UploadType type, List<File> files) {
    return requestList(apiCall: () => _uploadApi.uploadFile(type, files));
  }
}
