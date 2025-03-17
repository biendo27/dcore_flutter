part of 'repositories.dart';

abstract interface class IAuthRepository {
  Future<BaseResponse<Auth>> login(Map<String, dynamic> body);
  Future<BaseResponse<Auth>> loginZalo(Map<String, dynamic> body);
  Future<BaseResponse<Auth>> register(Map<String, dynamic> body);
  Future<BaseResponse> logout();
  Future<BaseResponse<Auth>> forgotPassword(Map<String, dynamic> body);
  Future<BaseResponse> resetPassword(Map<String, dynamic> body);
  Future<BaseResponse> resendOTP(String phone);
  Future<BaseResponse<AppUser>> verifyOTP(Map<String, dynamic> body);
  Future<BaseResponse> updatePassword(Map<String, dynamic> body);
  Future<BaseResponse> deletePermanentUser(String password);
}
