part of 'repositories.dart';

abstract interface class IGeographicalRepository {
  Future<BaseResponseList> fetchNation();
  Future<BaseResponseList> fetchCity(int nationId);
  Future<BaseResponseList> fetchDistrict(int cityId);
  Future<BaseResponseList> fetchWard(int districtId);
}
