part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(@Named(DIKey.appDio) Dio dio) = _AuthApi;

  @POST(AppEndpoint.login)
  Future<BaseResponse<Auth>> login(@Body() Map<String, dynamic> data);
  @POST(AppEndpoint.loginZalo)
  Future<BaseResponse<Auth>> loginZalo(@Body() Map<String, dynamic> data);

  @POST(AppEndpoint.register)
  Future<BaseResponse<Auth>> register(@Body() Map<String, dynamic> data);

  @POST(AppEndpoint.logout)
  Future<BaseResponse> logout();

  @POST(AppEndpoint.forgotPassword)
  Future<BaseResponse<Auth>> forgotPassword(@Body() Map<String, dynamic> data);

  @POST(AppEndpoint.resetPassword)
  Future<BaseResponse> resetPassword(@Body() Map<String, dynamic> data);

  @POST(AppEndpoint.resendOTP)
  Future<BaseResponse> resendOTP(@Part(name: 'phone') String phone);

  @POST(AppEndpoint.verifyOTP)
  Future<BaseResponse<AppUser>> verifyOTP(@Body() Map<String, dynamic> data);

  @POST(AppEndpoint.updatePassword)
  Future<BaseResponse> updatePassword(@Body() Map<String, dynamic> data);

  @DELETE(AppEndpoint.deletePermanentUser)
  Future<BaseResponse> deletePermanentUser(@Query('password') String password);
}
