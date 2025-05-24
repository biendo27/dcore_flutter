part of 'repositories.dart';

abstract interface class IActivityRepository {
  Future<BaseResponseList> fetchOrder();
  Future<BaseResponseList> fetchSearchHistory();
}
