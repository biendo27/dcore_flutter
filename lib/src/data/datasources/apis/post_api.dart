part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class PostApi {
  @factoryMethod
  factory PostApi(@Named(DIKey.appDio) Dio dio) = _PostApi;

  @GET(AppEndpoint.getPostList)
  Future<BaseResponseList<Post>> fetchPostList({
    @Query('limit') required int limit,
    @Query('type') required PostType postType,
    @Query('device_token') required String deviceToken,
  });

  @GET(AppEndpoint.getPostDetail)
  Future<BaseResponse<Post>> fetchPostDetail(@Query('post_id') int postId);

  @POST(AppEndpoint.createPost)
  Future<BaseResponse<Post>> createPost(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.updateLikePost)
  Future<BaseResponse<Post>> updateLikePost(@Part(name: 'post_id') int postId);

  @POST(AppEndpoint.updateBookmarkPost)
  Future<BaseResponse<Post>> updateBookmarkPost(@Part(name: 'post_id') int postId);

  @POST(AppEndpoint.updateLikePostComment)
  Future<BaseResponse<Comment>> updateLikePostComment(@Part(name: 'comment_id') int commentId);

  @GET(AppEndpoint.getPostComment)
  Future<BaseResponse<BasePageBreak<Comment>>> fetchPostComment(@Queries() Map<String, dynamic> queries);

  @POST(AppEndpoint.createPostComment)
  Future<BaseResponse<Comment>> createPostComment(@Body() Map<String, dynamic> body);

  @DELETE(AppEndpoint.deletePostComment)
  Future<BaseResponse> deletePostComment(@Body() Map<String, dynamic> body);

  @DELETE(AppEndpoint.deletePost)
  Future<BaseResponse> deletePost(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.reportPost)
  Future<BaseResponse> reportPost(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.markAsReadPost)
  Future<BaseResponse> markAsReadPost({
    @Part(name: 'post_id') required int postId,
    @Part(name: 'device_token') required String deviceToken,
  });

  @GET(AppEndpoint.searchPost)
  Future<BaseResponse<BasePageBreak<Post>>> searchPost(@Query('search') String search, @Query('page') int page);

  @GET(AppEndpoint.searchUser)
  Future<BaseResponse<BasePageBreak<AppUser>>> searchUser(@Query('search') String search, @Query('page') int page);
}
