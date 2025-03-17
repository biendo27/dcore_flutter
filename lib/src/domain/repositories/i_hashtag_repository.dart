part of 'repositories.dart';

abstract interface class IHashtagRepository {
  Future<BaseResponse<BasePageBreak<HashTag>>> fetchHashtagList(int page, String search);
} 