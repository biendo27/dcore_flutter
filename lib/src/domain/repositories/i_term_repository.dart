part of 'repositories.dart';

abstract interface class ITermRepository {
  Future<BaseResponse> fetchTerms();
}
