part of 'repositories.dart';

abstract interface class IUploadRepository {
  Future<BaseResponseList<AppFile>> uploadFile(UploadType type, List<File> files);
}
