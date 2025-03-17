part of 'repositories.dart';

@LazySingleton(as: IGeographicalRepository)
class GeographicalRepository with DataStateConvertible implements IGeographicalRepository {
  final GeographicalApi _geographicalApi;
  GeographicalRepository(this._geographicalApi);

  @override
  Future<BaseResponseList> fetchNation() {
    return requestList(apiCall: _geographicalApi.fetchNation);
  }

  @override
  Future<BaseResponseList> fetchCity(int nationId) {
    return requestList(apiCall: () => _geographicalApi.fetchCity(nationId));
  }

  @override
  Future<BaseResponseList> fetchDistrict(int cityId) {
    return requestList(apiCall: () => _geographicalApi.fetchDistrict(cityId));
  }

  @override
  Future<BaseResponseList> fetchWard(int districtId) {
    return requestList(apiCall: () => _geographicalApi.fetchWard(districtId));
  }
}
