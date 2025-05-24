part of 'repositories.dart';

@LazySingleton(as: ISoundRepository)
class SoundRepository with DataStateConvertible implements ISoundRepository {
  final SoundApi _soundApi;
  SoundRepository(this._soundApi);

  @override
  Future<BaseResponse<Sound>> createSound(Map<String, dynamic> body) {
    return request(apiCall: () => _soundApi.createSound(body));
  }

  @override
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundBookmarked(String search, int page) {
    return request(apiCall: () => _soundApi.fetchSoundBookmarked(search, page));
  }

  @override
  Future<BaseResponse<Sound>> fetchSoundDetail(int soundId) {
    return request(apiCall: () => _soundApi.fetchSoundDetail(soundId));
  }

  @override
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundSuggestedList(String search, int page) {
    return request(apiCall: () => _soundApi.fetchSoundSuggestedList(search, page));
  }

  @override
  Future<BaseResponse> updateBookmarkSound(int soundId) {
    return request(apiCall: () => _soundApi.updateBookmarkSound(soundId));
  }
}
