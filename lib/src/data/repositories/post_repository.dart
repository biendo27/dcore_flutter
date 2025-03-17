part of 'repositories.dart';

@LazySingleton(as: IPostRepository)
class PostRepository with DataStateConvertible implements IPostRepository {
  final PostApi _postApi;
  PostRepository(this._postApi);

  @override
  Future<BaseResponseList<Post>> fetchPostList({int limit = 10, PostType postType = PostType.following, String deviceToken = ''}) {
    return requestList(apiCall: () {
      return _postApi.fetchPostList(
        limit: limit,
        postType: postType,
        deviceToken: deviceToken,
      );
    });
  }

  @override
  Future<BaseResponse<Post>> fetchPostDetail(int postId) {
    return request(apiCall: () => _postApi.fetchPostDetail(postId));
  }

  @override
  Future<BaseResponse<Post>> createPost(Map<String, dynamic> body) {
    return request(apiCall: () => _postApi.createPost(body));
  }

  @override
  Future<BaseResponse<Post>> updateLikePost(int postId) {
    return request(apiCall: () => _postApi.updateLikePost(postId));
  }

  @override
  Future<BaseResponse<Post>> updateBookmarkPost(int postId) {
    return request(apiCall: () => _postApi.updateBookmarkPost(postId));
  }

  @override
  Future<BaseResponse<BasePageBreak<Comment>>> fetchPostComment(Map<String, dynamic> body) {
    return request(apiCall: () => _postApi.fetchPostComment(body));
  }

  @override
  Future<BaseResponse> deletePost(Map<String, dynamic> body) {
    return request(apiCall: () => _postApi.deletePost(body));
  }

  @override
  Future<BaseResponse<Comment>> createPostComment(Map<String, dynamic> body) {
    return request(apiCall: () => _postApi.createPostComment(body));
  }

  @override
  Future<BaseResponse> deletePostComment(int commentId) {
    return request(apiCall: () => _postApi.deletePostComment({'comment_id': commentId}));
  }

  @override
  Future<BaseResponse<Comment>> updateLikePostComment(int postId) {
    return request(apiCall: () => _postApi.updateLikePostComment(postId));
  }

  @override
  Future<BaseResponse> reportPost(Map<String, dynamic> body) {
    return request(apiCall: () => _postApi.reportPost(body));
  }

  @override
  Future<BaseResponse> markAsReadPost({int postId = 0, String deviceToken = ''}) {
    return request(apiCall: () => _postApi.markAsReadPost(postId: postId, deviceToken: deviceToken));
  }

  @override
  Future<BaseResponse<BasePageBreak<Post>>> searchPost(String search, int page) {
    return request(apiCall: () => _postApi.searchPost(search, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<AppUser>>> searchUser(String search, int page) {
    return request(apiCall: () => _postApi.searchUser(search, page));
  }
}
