part of 'repositories.dart';

abstract interface class ISoundRepository {
  Future<BaseResponse<Sound>> createSound(Map<String, dynamic> body);
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundBookmarked(String search, int page);
  Future<BaseResponse<Sound>> fetchSoundDetail(int soundId);
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundSuggestedList(String search, int page);
  Future<BaseResponse> updateBookmarkSound(int soundId);
}
