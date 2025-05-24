part of 'repositories.dart';

abstract interface class IPostRepository {
  Future<BaseResponseList<Post>> fetchPostList({int limit, PostType postType, String deviceToken});
  Future<BaseResponse<Post>> fetchPostDetail(int postId);
  Future<BaseResponse<Post>> createPost(Map<String, dynamic> body);
  Future<BaseResponse<Post>> updateLikePost(int postId);
  Future<BaseResponse<Post>> updateBookmarkPost(int postId);
  Future<BaseResponse<BasePageBreak<Comment>>> fetchPostComment(Map<String, dynamic> body);
  Future<BaseResponse<Comment>> createPostComment(Map<String, dynamic> body);
  Future<BaseResponse> deletePostComment(int commentId);
  Future<BaseResponse> deletePost(Map<String, dynamic> body);
  Future<BaseResponse<Comment>> updateLikePostComment(int postId);
  Future<BaseResponse> reportPost(Map<String, dynamic> body);
  Future<BaseResponse> markAsReadPost({int postId, String deviceToken});
  Future<BaseResponse<BasePageBreak<Post>>> searchPost(String search, int page);
  Future<BaseResponse<BasePageBreak<AppUser>>> searchUser(String search, int page);
}
