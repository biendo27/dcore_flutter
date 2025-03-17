part of 'repositories.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository with DataStateConvertible implements IAuthRepository {
  final AuthApi _authApi;
  AuthRepository(this._authApi);

  @override
  Future<BaseResponse<Auth>> login(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.login(body));
  }

  @override
  Future<BaseResponse<Auth>> loginZalo(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.loginZalo(body));
  }

  @override
  Future<BaseResponse<Auth>> register(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.register(body));
  }

  @override
  Future<BaseResponse<Auth>> forgotPassword(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.forgotPassword(body));
  }

  @override
  Future<BaseResponse> logout() {
    return request(apiCall: () => _authApi.logout());
  }

  @override
  Future<BaseResponse> resendOTP(String phone) {
    return request(apiCall: () => _authApi.resendOTP(phone));
  }

  @override
  Future<BaseResponse> resetPassword(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.resetPassword(body));
  }

  @override
  Future<BaseResponse> updatePassword(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.updatePassword(body));
  }

  @override
  Future<BaseResponse<AppUser>> verifyOTP(Map<String, dynamic> body) {
    return request(apiCall: () => _authApi.verifyOTP(body));
  }

  @override
  Future<BaseResponse> deletePermanentUser(String password) {
    return request(apiCall: () => _authApi.deletePermanentUser(password));
  }
}
