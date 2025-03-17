part of 'repositories.dart';

@LazySingleton(as: ILiveRepository)
class LiveRepository with DataStateConvertible implements ILiveRepository {
  final LiveApi _liveApi;

  LiveRepository(this._liveApi);

  @override
  Future<BaseResponse<BasePageBreak<Live>>> getLiveList(int page, String search) {
    return request(apiCall: () => _liveApi.getLiveList(page, search));
  }

  @override
  Future<BaseResponse<Live>> getLiveDetail(int id) {
    return request(apiCall: () => _liveApi.getLiveDetail(id));
  }

  @override
  Future<BaseResponse<Live>> createLive(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.createLive(body));
  }

  @override
  Future<BaseResponse> cancelLive(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.cancelLive(body));
  }

  @override
  Future<BaseResponse<Live>> startLive(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.startLive(body));
  }

  @override
  Future<BaseResponse<Live>> endLive(int liveId) {
    return request(apiCall: () => _liveApi.endLive(liveId));
  }

  @override
  Future<BaseResponse<BreakSchedule>> createLeaveRequest(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.createLeaveRequest(body));
  }

  @override
  Future<BaseResponse<BasePageBreak<BreakSchedule>>> getLeaveRequest(int page) {
    return request(apiCall: () => _liveApi.getLeaveRequest(page));
  }

  @override
  Future<BaseResponse<BreakSchedule>> getLeaveRequestDetail(int id) {
    return request(apiCall: () => _liveApi.getLeaveRequestDetail(id));
  }

  @override
  Future<BaseResponse> deleteLeaveRequest(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.deleteLeaveRequest(body));
  }

  @override
  Future<BaseResponse<LiveRequest>> createLiveRequest(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.createLiveRequest(body));
  }

  @override
  Future<BaseResponse<BasePageBreak<LiveRequest>>> getLiveRequest(int page) {
    return request(apiCall: () => _liveApi.getLiveRequest(page));
  }

  @override
  Future<BaseResponse<LiveRequest>> getLiveRequestDetail(int id) {
    return request(apiCall: () => _liveApi.getLiveRequestDetail(id));
  }

  @override
  Future<BaseResponse> deleteLiveRequest(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.deleteLiveRequest(body));
  }

  @override
  Future<BaseResponseList<LivePlatform>> getLivePlatforms() {
    return requestList(apiCall: () => _liveApi.getLivePlatforms());
  }

  @override
  Future<BaseResponseList<LiveArea>> getLiveAreas() {
    return requestList(apiCall: () => _liveApi.getLiveAreas());
  }

  @override
  Future<BaseResponse<BasePageBreak<LiveSchedule>>> getMySchedule(int page) {
    return request(apiCall: () => _liveApi.getMySchedule(page));
  }

  @override
  Future<BaseResponse<Live>> getMyNearestLive() {
    return request(apiCall: () => _liveApi.getMyNearestLive());
  }

  @override
  Future<BaseResponse<Live>> getMyScheduleDetail(int id) {
    return request(apiCall: () => _liveApi.getMyScheduleDetail(id));
  }

  @override
  Future<BaseResponse<Live>> updatePinProductToLive(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.updatePinProductToLive(body));
  }

  @override
  Future<BaseResponse<Comment>> updatePinCommentToLive(int liveId, int commentId) {
    return request(apiCall: () => _liveApi.updatePinCommentToLive(liveId, commentId));
  }

  @override
  Future<BaseResponse<LiveBooth>> getLiveBooth(int id) {
    return request(apiCall: () => _liveApi.getLiveBooth(id));
  }

  @override
  Future<BaseResponse> markAsRead(int id, String deviceToken) {
    return request(apiCall: () => _liveApi.markAsRead(id, deviceToken));
  }

  @override
  Future<BaseResponse<BasePageBreak<Comment>>> getListComment(int liveId, int page) {
    return request(apiCall: () => _liveApi.getListComment(liveId, page));
  }

  @override
  Future<BaseResponseList<Comment>> loadOldComment(int commentId) {
    return requestList(apiCall: () => _liveApi.loadOldComment(commentId));
  }

  @override
  Future<BaseResponse<Comment>> createComment(Map<String, dynamic> body) {
    return request(apiCall: () => _liveApi.createComment(body));
  }

  @override
  Future<BaseResponse> liveLike(int id) {
    return request(apiCall: () => _liveApi.liveLike(id));
  }

  @override
  Future<BaseResponse> leaveLive(int liveId) {
    return request(apiCall: () => _liveApi.leaveLive(liveId));
  }

  @override
  Future<BaseResponse<BasePageBreak<Product>>> getLiveProductOther(int liveId, int page) {
    return request(apiCall: () => _liveApi.getLiveProductOther(liveId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<LiveMission>>> getLiveMission(int liveId, int page) {
    return request(apiCall: () => _liveApi.getLiveMission(liveId, page));
  }

  @override
  Future<BaseResponse> receiveLiveMission(int missionLiveId) {
    return request(apiCall: () => _liveApi.receiveLiveMission(missionLiveId));
  }

  @override
  Future<BaseResponse<LiveExtraInfo>> getLiveExtraInfo(int liveId) {
    return request(apiCall: () => _liveApi.getLiveExtraInfo(liveId));
  }

  @override
  Future<BaseResponse<AppUser>> getLiveRandom(int liveId) {
    return request(apiCall: () => _liveApi.getLiveRandom(liveId));
  }

  @override
  Future<BaseResponse<BasePageBreak<Live>>> getLiveEventList(int page) {
    return request(apiCall: () => _liveApi.getLiveEventList(page));
  }

  @override
  Future<BaseResponse<Live>> liveEventSubscribe(int liveId) {
    return request(apiCall: () => _liveApi.liveEventSubscribe(liveId));
  }

  @override
  Future<BaseResponse<String>> generateAgoraToken(String roomId) {
    return request(apiCall: () => _liveApi.generateAgoraToken(roomId));
  }
}
