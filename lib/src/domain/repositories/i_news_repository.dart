part of 'repositories.dart';

abstract interface class INewsRepository {
  Future<BaseResponse<AppNews>> getNewsDetail(int newsId);
}
